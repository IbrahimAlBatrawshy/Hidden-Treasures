import 'package:flutter/material.dart';
import '../../models/restaurant_model.dart';
import '../../componets/componets.dart';
import '../../constants/app_colors.dart';
import 'restaurant_deatails_screen.dart';

class RestaurantScreen extends StatefulWidget {
  const RestaurantScreen({super.key});

  @override
  State<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              AppHeader(
                searchController: _searchController,
                searchHint: 'Search for restaurants...',
                onProfileTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Profile page coming soon!'),
                      backgroundColor: AppColors.secondary,
                    ),
                  );
                },
                onSearchChanged: () {
                  // Handle search functionality
                },
              ),
              // Featured Restaurants Section
              SizedBox(
                height: 280,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  itemCount: featuredRestaurants.length,
                  itemBuilder: (BuildContext context, int index) {
                    Restaurant restaurant = featuredRestaurants[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RestaurantDeatailsScreen(restaurant: restaurant),
                          ),
                        );
                      },
                      child: FeaturedRestaurantCard(
                        restaurant: restaurant,
                        onFavoritePressed: () {
                          setState(() {
                            restaurant.isFavorite = !restaurant.isFavorite;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                restaurant.isFavorite 
                                  ? 'Added ${restaurant.name} to favorites'
                                  : 'Removed ${restaurant.name} from favorites'
                              ),
                              backgroundColor: restaurant.isFavorite ? AppColors.favorite : AppColors.textSecondary,
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              
              // Popular Restaurants Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Popular Restaurant',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('See all restaurants'),
                            backgroundColor: AppColors.secondary,
                          ),
                        );
                      },
                      child: const Text(
                        'See all',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.secondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Popular Restaurants List
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: popularRestaurants.length,
                  itemBuilder: (BuildContext context, int index) {
                    Restaurant restaurant = popularRestaurants[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RestaurantDeatailsScreen(restaurant: restaurant),
                          ),
                        );
                      },
                      child: PopularRestaurantCard(
                        restaurant: restaurant,
                        onFavoritePressed: () {
                          setState(() {
                            restaurant.isFavorite = !restaurant.isFavorite;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                restaurant.isFavorite 
                                  ? 'Added ${restaurant.name} to favorites'
                                  : 'Removed ${restaurant.name} from favorites'
                              ),
                              backgroundColor: restaurant.isFavorite ? AppColors.favorite : AppColors.textSecondary,
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
