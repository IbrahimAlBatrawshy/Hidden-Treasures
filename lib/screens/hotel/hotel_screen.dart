import 'package:flutter/material.dart';
import '../../models/hotel_model.dart';
import '../../constants/app_colors.dart';
import 'hotel_details_screen.dart';

class HotelScreen extends StatefulWidget {
  const HotelScreen({super.key});

  @override
  State<HotelScreen> createState() => _HotelScreenState();
}

class _HotelScreenState extends State<HotelScreen> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _budgetController = TextEditingController();
  late final List<Hotel> _allHotels;
  List<Hotel> _filteredHotels = [];

  @override
  void initState() {
    super.initState();
    _allHotels = [...featuredHotels, ...popularHotels];
    _filteredHotels = _allHotels;
    _searchController.addListener(_filterHotels);
    _budgetController.addListener(_filterHotels);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterHotels);
    _budgetController.removeListener(_filterHotels);
    _searchController.dispose();
    _budgetController.dispose();
    super.dispose();
  }

  void _filterHotels() {
    final query = _searchController.text.toLowerCase().trim();
    double? maxBudget;
    final budgetText = _budgetController.text.trim();
    if (budgetText.isNotEmpty) {
      maxBudget = double.tryParse(budgetText.replaceAll(',', ''));
    }

    setState(() {
      _filteredHotels = _allHotels.where((hotel) {
        final matchesQuery = query.isEmpty ||
            hotel.name.toLowerCase().contains(query) ||
            hotel.address.toLowerCase().contains(query);
        final matchesBudget = maxBudget == null || hotel.price <= maxBudget;
        return matchesQuery && matchesBudget;
      }).toList();
    });
  }

  void _toggleFavorite(Hotel hotel) {
    setState(() {
      hotel.isFavorite = !hotel.isFavorite;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          hotel.isFavorite
              ? 'Added ${hotel.name} to favorites'
              : 'Removed ${hotel.name} from favorites',
        ),
        backgroundColor:
            hotel.isFavorite ? AppColors.favorite : AppColors.textSecondary,
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
          'Hotels',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
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
                hintText: 'Search for hotels...',
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
          // Budget Filter
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: TextField(
              controller: _budgetController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                hintText: 'Max price per night',
                prefixIcon: const Icon(Icons.attach_money, color: AppColors.textLight),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
          // Hotels List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: _filteredHotels.length,
              itemBuilder: (BuildContext context, int index) {
                final hotel = _filteredHotels[index];
                return _buildHotelListItem(hotel);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHotelListItem(Hotel hotel) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HotelDetailsScreen(hotel: hotel),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 3,
        color: Colors.white,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              child: Image.network(
                hotel.imageUrl,
                width: 120,
                height: 140,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 120,
                  height: 140,
                  color: AppColors.backgroundSecondary,
                  child: const Icon(Icons.image_not_supported_outlined,
                      color: AppColors.textLight, size: 40),
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
                        hotel.name,
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
                              hotel.address,
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
                            hotel.rating.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '\$${hotel.price.toStringAsFixed(2)}/night',
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
                  hotel.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: AppColors.favorite,
                  size: 24,
                ),
                onPressed: () => _toggleFavorite(hotel),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
