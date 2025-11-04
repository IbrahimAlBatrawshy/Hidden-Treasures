import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hidden_treasures/constants/app_colors.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();
  final TextEditingController _startController = TextEditingController();
  final TextEditingController _endController = TextEditingController();
  final TextEditingController _placeSearchController = TextEditingController();

  // Cairo default center
  static const LatLng _cairoCenter = LatLng(30.033333, 31.233334);
  LatLng _currentCenter = _cairoCenter;
  LatLng? _currentLocation;
  LatLng? _startPoint;
  LatLng? _endPoint;

  List<Marker> _markers = [];
  List<LatLng> _routePoints = [];
  bool _isLoadingLocation = false;
  bool _isLoadingRoute = false;
  String? _distance;
  String? _duration;
  bool _mapReady = false;

  // Egypt bounds (approx)
  final LatLngBounds _egyptBounds = LatLngBounds(
    const LatLng(21.7, 24.7),
    const LatLng(31.7, 36.9),
  );

  bool _isInEgypt(LatLng point) => _egyptBounds.contains(point);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _getCurrentLocation());
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _showMessage('Location services are disabled. Please enable them.');
      return false;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _showMessage('Location permissions are denied');
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _showMessage(
        'Location permissions are permanently denied. Enable them in settings.',
      );
      return false;
    }

    return true;
  }

  Future<void> _getCurrentLocation() async {
    if (!mounted) return;
    setState(() => _isLoadingLocation = true);

    try {
      final bool hasPermission = await _handleLocationPermission();
      if (!hasPermission) {
        if (mounted) setState(() => _isLoadingLocation = false);
        return;
      }

      final Position position =
          await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.bestForNavigation,
            timeLimit: const Duration(seconds: 15),
          ).timeout(
            const Duration(seconds: 15),
            onTimeout: () => throw Exception('Location request timed out'),
          );

      if (!mounted) return;

      final LatLng userLatLng = LatLng(position.latitude, position.longitude);

      setState(() {
        _currentLocation = userLatLng;
        _currentCenter = _isInEgypt(userLatLng) ? userLatLng : _cairoCenter;
        if (!_isInEgypt(userLatLng)) {
          _showMessage(
            'Current location is outside Egypt. Centering on Cairo.',
          );
        }
        _markers = [
          if (_isInEgypt(userLatLng))
            Marker(
              width: 80,
              height: 80,
              point: userLatLng,
              builder: (ctx) => Container(
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.my_location,
                  size: 40,
                  color: Colors.blue,
                ),
              ),
            ),
        ];
        _isLoadingLocation = false;
      });

      await Future.delayed(const Duration(milliseconds: 200));
      if (mounted && _mapReady) {
        try {
          _mapController.move(_currentCenter, 15.0);
        } catch (_) {}
      }
    } catch (e) {
      debugPrint('Location error: $e');
      _showMessage('Failed to get location. Please try again.');
      if (mounted) setState(() => _isLoadingLocation = false);
    }
  }

  Future<LatLng?> _searchLocation(String query) async {
    if (query.trim().isEmpty) return null;

    final Uri url = Uri.parse(
      'https://nominatim.openstreetmap.org/search?q=${Uri.encodeComponent(query)}&format=json&limit=1&countrycodes=eg&addressdetails=0',
    );

    try {
      final http.Response response = await http
          .get(
            url,
            headers: const {
              'User-Agent': 'HiddenTreasures/1.0 (contact: support@hidden.tld)',
            },
          )
          .timeout(const Duration(seconds: 12));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
        if (data.isNotEmpty) {
          final double lat = double.parse(data[0]['lat'] as String);
          final double lon = double.parse(data[0]['lon'] as String);
          return LatLng(lat, lon);
        }
      } else {
        debugPrint('Search failed with status ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Search error: $e');
      _showMessage('Search failed. Please try again.');
    }

    return null;
  }

  Future<void> _getDirections() async {
    // If user typed text but didn't hit enter, resolve the points now
    if (_startPoint == null && _startController.text.trim().isNotEmpty) {
      _startPoint = await _searchLocation(_startController.text.trim());
    }
    if (_endPoint == null && _endController.text.trim().isNotEmpty) {
      _endPoint = await _searchLocation(_endController.text.trim());
    }

    // Validate bounds (Egypt only)
    if (_startPoint != null && !_isInEgypt(_startPoint!)) {
      _showMessage('Start point is outside Egypt. Using Cairo instead.');
      _startPoint = _cairoCenter;
    }
    if (_endPoint != null && !_isInEgypt(_endPoint!)) {
      _showMessage('End point is outside Egypt. Using Cairo instead.');
      _endPoint = _cairoCenter;
    }

    if (_startPoint == null || _endPoint == null) {
      _showMessage('Please set both start and end points');
      return;
    }

    if (!mounted) return;
    setState(() => _isLoadingRoute = true);

    final Uri url = Uri.parse(
      'https://router.project-osrm.org/route/v1/driving/'
      '${_startPoint!.longitude},${_startPoint!.latitude};'
      '${_endPoint!.longitude},${_endPoint!.latitude}'
      '?overview=full&geometries=geojson',
    );

    try {
      final http.Response response = await http
          .get(url)
          .timeout(const Duration(seconds: 20));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data =
            jsonDecode(response.body) as Map<String, dynamic>;

        final List<dynamic>? routes = data['routes'] as List<dynamic>?;
        if (routes != null && routes.isNotEmpty) {
          final Map<String, dynamic> route =
              routes.first as Map<String, dynamic>;
          final List<dynamic> coordinates =
              (route['geometry'] as Map<String, dynamic>)['coordinates']
                  as List<dynamic>;

          if (!mounted) return;
          setState(() {
            _routePoints = coordinates
                .map(
                  (coord) => LatLng(
                    (coord as List<dynamic>)[1].toDouble(),
                    coord[0].toDouble(),
                  ),
                )
                .toList();

            _distance = '${(route['distance'] / 1000).toStringAsFixed(2)} km';
            _duration = '${(route['duration'] / 60).toStringAsFixed(0)} min';

            _markers = [
              Marker(
                width: 80,
                height: 80,
                point: _startPoint!,
                builder: (ctx) => const Icon(
                  Icons.location_on,
                  size: 40,
                  color: Colors.green,
                ),
              ),
              Marker(
                width: 80,
                height: 80,
                point: _endPoint!,
                builder: (ctx) =>
                    const Icon(Icons.location_on, size: 40, color: Colors.red),
              ),
            ];
            _isLoadingRoute = false;
          });

          await Future.delayed(const Duration(milliseconds: 200));
          if (mounted && _mapReady && _routePoints.isNotEmpty) {
            try {
              final LatLngBounds bounds = LatLngBounds.fromPoints(_routePoints);
              _mapController.fitBounds(
                bounds,
                options: const FitBoundsOptions(padding: EdgeInsets.all(50)),
              );
            } catch (e) {
              debugPrint('Fit bounds error: $e');
            }
          }
        } else {
          _showMessage('No route found');
          if (mounted) setState(() => _isLoadingRoute = false);
        }
      } else {
        _showMessage('Failed to get directions');
        if (mounted) setState(() => _isLoadingRoute = false);
      }
    } catch (e) {
      debugPrint('Directions error: $e');
      _showMessage('Failed to get directions. Please try again.');
      if (mounted) setState(() => _isLoadingRoute = false);
    }
  }

  Future<void> _setStartPoint() async {
    final LatLng? location = await _searchLocation(_startController.text);
    if (location != null) {
      setState(() => _startPoint = location);
      _showMessage('Start point set');
    } else {
      _showMessage('Start location not found');
    }
  }

  Future<void> _setEndPoint() async {
    final LatLng? location = await _searchLocation(_endController.text);
    if (location != null) {
      setState(() => _endPoint = location);
      _showMessage('End point set');
    } else {
      _showMessage('End location not found');
    }
  }

  void _useCurrentLocationAsStart() {
    if (_currentLocation != null) {
      final LatLng start = _isInEgypt(_currentLocation!)
          ? _currentLocation!
          : _cairoCenter;
      setState(() {
        _startPoint = start;
        _startController.text = _isInEgypt(_currentLocation!)
            ? 'Current Location'
            : 'Cairo';
      });
      if (!_isInEgypt(_currentLocation!)) {
        _showMessage('Current location outside Egypt. Using Cairo as start.');
      }
      _showMessage('Using current location as start point');
    } else {
      _showMessage('Current location not available. Please wait...');
      _getCurrentLocation();
    }
  }

  Future<void> _searchAndCenterOnPlace() async {
    final String query = _placeSearchController.text.trim();
    if (query.isEmpty) return;
    final LatLng? location = await _searchLocation(query);
    if (location != null) {
      setState(() {
        _currentCenter = location;
        _markers = [
          ..._markers,
          Marker(
            width: 60,
            height: 60,
            point: location,
            builder: (ctx) =>
                const Icon(Icons.place, color: Colors.purple, size: 36),
          ),
        ];
      });
      if (_mapReady) _mapController.move(location, 14.0);
    } else {
      _showMessage('Place not found in Egypt');
    }
  }

  void _clearRoute() {
    setState(() {
      _routePoints = [];
      _startPoint = null;
      _endPoint = null;
      _distance = null;
      _duration = null;
      _startController.clear();
      _endController.clear();
      _markers = _currentLocation != null
          ? [
              Marker(
                width: 80,
                height: 80,
                point: _currentLocation!,
                builder: (ctx) => Container(
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.my_location,
                    size: 40,
                    color: Colors.blue,
                  ),
                ),
              ),
            ]
          : [];
    });
  }

  void _showMessage(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Map & Directions',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
        backgroundColor: AppColors.secondary,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Map
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              // Newer flutter_map API fields
              minZoom: 3.0,
              maxZoom: 18.0,

              onMapReady: () => setState(() => _mapReady = true),
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: const ['a', 'b', 'c'],
                userAgentPackageName: 'com.hiddentreasures.app',
              ),
              if (_routePoints.isNotEmpty)
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: _routePoints,
                      strokeWidth: 4.0,
                      color: Colors.blue,
                    ),
                  ],
                ),
              MarkerLayer(markers: _markers),
            ],
          ),

          // Direction + search panel
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Single place search (Egypt only)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.search,
                          color: Colors.deepPurple,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            controller: _placeSearchController,
                            decoration: InputDecoration(
                              hintText: 'Search place in Egypt',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.grey[100],
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              isDense: true,
                            ),
                            onSubmitted: (_) => _searchAndCenterOnPlace(),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.travel_explore,
                            color: Colors.deepPurple,
                          ),
                          onPressed: _searchAndCenterOnPlace,
                          tooltip: 'Search place',
                        ),
                      ],
                    ),
                  ),

                  // Start location
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.trip_origin,
                          color: Colors.green,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            controller: _startController,
                            decoration: InputDecoration(
                              hintText: 'Start location (Egypt)',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.grey[100],
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              isDense: true,
                            ),
                            onSubmitted: (_) => _setStartPoint(),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.my_location,
                            color: Colors.blue,
                          ),
                          onPressed: _useCurrentLocationAsStart,
                          tooltip: 'Use current location',
                        ),
                      ],
                    ),
                  ),

                  // End location
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            controller: _endController,
                            decoration: InputDecoration(
                              hintText: 'End location (Egypt)',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.grey[100],
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              isDense: true,
                            ),
                            onSubmitted: (_) => _setEndPoint(),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.directions,
                            color: Colors.deepOrange,
                          ),
                          onPressed: _getDirections,
                          tooltip: 'Get directions',
                        ),
                      ],
                    ),
                  ),

                  if (_distance != null && _duration != null)
                    Container(
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      decoration: BoxDecoration(
                        color: Colors.deepOrange.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.straighten,
                                size: 18,
                                color: Colors.deepOrange,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                _distance!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepOrange,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.access_time,
                                size: 18,
                                color: Colors.deepOrange,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                _duration!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepOrange,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),

          if (_isLoadingLocation || _isLoadingRoute)
            Container(
              color: Colors.black.withOpacity(0.3),
              child: const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrange),
                ),
              ),
            ),

          Positioned(
            right: 10,
            bottom: 10,
            child: FloatingActionButton(
              heroTag: 'location',
              backgroundColor: Colors.white,
              onPressed: _getCurrentLocation,
              child: const Icon(Icons.my_location, color: Colors.blue),
            ),
          ),

          if (_routePoints.isNotEmpty)
            Positioned(
              right: 10,
              bottom: 100,
              child: FloatingActionButton(
                heroTag: 'clear',
                backgroundColor: Colors.white,
                onPressed: _clearRoute,
                child: const Icon(Icons.clear, color: Colors.red),
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _startController.dispose();
    _endController.dispose();
    _placeSearchController.dispose();
    super.dispose();
  }
}
