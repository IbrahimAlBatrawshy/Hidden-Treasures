import 'package:flutter/material.dart';
import 'package:hidden_treasures/screens/car/carDetails_screen.dart';
import '../../constants/app_colors.dart';
import '../../models/car_model.dart';

class CarrentalScreen extends StatefulWidget {
  const CarrentalScreen({super.key});

  @override
  State<CarrentalScreen> createState() => _CarrentalScreenState();
}

class _CarrentalScreenState extends State<CarrentalScreen> {
  final TextEditingController _searchController = TextEditingController();
  late final List<CarModel> _allCars;
  List<CarModel> _filteredCars = [];

  @override
  void initState() {
    super.initState();
    _allCars = [...featuredCars, ...popularCars];
    _filteredCars = _allCars;
    _searchController.addListener(_filterCars);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterCars);
    _searchController.dispose();
    super.dispose();
  }

  void _filterCars() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredCars = _allCars.where((car) {
        return car.displayName.toLowerCase().contains(query);
      }).toList();
    });
  }

  void _toggleFavorite(CarModel car) {
    setState(() {
      car.isFavorite = !car.isFavorite;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          car.isFavorite
              ? 'Added ${car.displayName} to favorites'
              : 'Removed ${car.displayName} from favorites',
        ),
        backgroundColor:
            car.isFavorite ? AppColors.favorite : AppColors.textSecondary,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF3E0),
      appBar: AppBar(
        backgroundColor: AppColors.secondary,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 25),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: const Text(
          'Cars',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for cars...',
                prefixIcon:
                    const Icon(Icons.search, color: AppColors.textLight),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
          // Cars List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: _filteredCars.length,
              itemBuilder: (BuildContext context, int index) {
                final car = _filteredCars[index];
                return _buildCarListItem(car);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCarListItem(CarModel car) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CarDetailsScreen(car: car),
          ),
        );
      },
      child: Card(
        color: Colors.white,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 3,
        shadowColor: AppColors.shadowLight,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              child: Image.network(
                car.imageUrl,
                width: 120,
                height: 140,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 120,
                  height: 140,
                  color: AppColors.backgroundSecondary,
                  child: const Icon(Icons.directions_car, color: AppColors.textLight, size: 40),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: SizedBox(
                  height: 124,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        car.displayName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        children: [
                          const Icon(Icons.location_on,
                              size: 14, color: AppColors.textSecondary),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              car.location,
                              style: const TextStyle(
                                  fontSize: 12, color: AppColors.textSecondary),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star,
                              color: AppColors.star, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            car.rating.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '${car.currency}${car.pricePerDay.toStringAsFixed(0)}/day',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.secondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                icon: Icon(
                  car.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: AppColors.favorite,
                  size: 24,
                ),
                onPressed: () => _toggleFavorite(car),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
