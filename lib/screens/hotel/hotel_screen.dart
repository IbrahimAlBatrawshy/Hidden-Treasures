import 'package:flutter/material.dart';
import '../../models/hotel_model.dart';
import '../../componets/componets.dart';
import '../../constants/app_colors.dart';
import 'hotel_details_screen.dart';

class HotelScreen extends StatefulWidget {
  const HotelScreen({super.key});

  @override
  State<HotelScreen> createState() => _HotelScreenState();
}

class _HotelScreenState extends State<HotelScreen> {
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
                searchHint: 'Search for hotels...',
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
              // Featured Hotels Section
              SizedBox(
                height: 280,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  itemCount: featuredHotels.length,
                  itemBuilder: (BuildContext context, int index) {
                    Hotel hotel = featuredHotels[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HotelDetailsScreen(hotel: hotel),
                          ),
                        );
                      },
                      child: FeaturedHotelCard(
                        hotel: hotel,
                        onFavoritePressed: () {
                          setState(() {
                            hotel.isFavorite = !hotel.isFavorite;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                hotel.isFavorite 
                                  ? 'Added ${hotel.name} to favorites'
                                  : 'Removed ${hotel.name} from favorites'
                              ),
                              backgroundColor: hotel.isFavorite ? AppColors.favorite : AppColors.textSecondary,
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              
              // Popular Hotels Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Popular Hotel',
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
                            content: Text('See all hotels'),
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
              
              // Popular Hotels List
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: popularHotels.length,
                  itemBuilder: (BuildContext context, int index) {
                    Hotel hotel = popularHotels[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HotelDetailsScreen(hotel: hotel),
                          ),
                        );
                      },
                      child: PopularHotelCard(
                        hotel: hotel,
                        onFavoritePressed: () {
                          setState(() {
                            hotel.isFavorite = !hotel.isFavorite;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                hotel.isFavorite 
                                  ? 'Added ${hotel.name} to favorites'
                                  : 'Removed ${hotel.name} from favorites'
                              ),
                              backgroundColor: hotel.isFavorite ? AppColors.favorite : AppColors.textSecondary,
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