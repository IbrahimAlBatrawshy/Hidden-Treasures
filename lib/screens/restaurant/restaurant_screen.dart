import 'package:flutter/material.dart';
import '../../models/restaurant_model.dart';
import '../../constants/app_colors.dart';
import 'restaurant_deatails_screen.dart';

class RestaurantScreen extends StatefulWidget {
  const RestaurantScreen({super.key});

  @override
  State<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  final TextEditingController _searchController = TextEditingController();
  late final List<Restaurant> _allRestaurants;
  List<Restaurant> _filteredRestaurants = [];

  @override
  void initState() {
    super.initState();
    _allRestaurants = [...featuredRestaurants, ...popularRestaurants];
    _filteredRestaurants = _allRestaurants;
    _searchController.addListener(_filterRestaurants);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterRestaurants);
    _searchController.dispose();
    super.dispose();
  }

  void _filterRestaurants() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredRestaurants = _allRestaurants.where((restaurant) {
        return restaurant.name.toLowerCase().contains(query);
      }).toList();
    });
  }

  void _toggleFavorite(Restaurant restaurant) {
    setState(() {
      restaurant.isFavorite = !restaurant.isFavorite;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          restaurant.isFavorite
              ? 'Added ${restaurant.name} to favorites'
              : 'Removed ${restaurant.name} from favorites',
        ),
        backgroundColor:
            restaurant.isFavorite ? AppColors.favorite : AppColors.textSecondary,
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
          'Restaurants',
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
                hintText: 'Search for restaurants...',
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
          // Restaurants List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: _filteredRestaurants.length,
              itemBuilder: (BuildContext context, int index) {
                final restaurant = _filteredRestaurants[index];
                return _buildRestaurantListItem(restaurant);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRestaurantListItem(Restaurant restaurant) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RestaurantDeatailsScreen(restaurant: restaurant),
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
                restaurant.imageUrl,
                width: 120,
                height: 140,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 120,
                  height: 140,
                  color: AppColors.backgroundSecondary,
                  child: const Icon(Icons.restaurant, color: AppColors.textLight, size: 40),
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
                        restaurant.name,
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
                              restaurant.address,
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
                            restaurant.rating.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
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
                  restaurant.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: AppColors.favorite,
                  size: 24,
                ),
                onPressed: () => _toggleFavorite(restaurant),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
