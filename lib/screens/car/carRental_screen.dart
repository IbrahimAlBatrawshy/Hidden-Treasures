import 'package:flutter/material.dart';
import 'package:hidden_treasures/screens/car/carDetails_screen.dart';
import '../../constants/app_colors.dart';
import '../../models/car_model.dart';
import '../../componets/componets.dart';

class CarrentalScreen extends StatefulWidget {
  const CarrentalScreen({super.key});

  @override
  State<CarrentalScreen> createState() => _CarrentalScreenState();
}

class _CarrentalScreenState extends State<CarrentalScreen> {
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
              AppHeader(
                searchController: _searchController,
                searchHint: 'Search for cars...',
                onProfileTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Profile page coming soon!'),
                      backgroundColor: AppColors.secondary,
                    ),
                  );
                },
                onSearchChanged: () {},
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Featured Cars',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      'See all',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.secondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              SizedBox(
                height: 280,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: featuredCars.length,
                  itemBuilder: (context, index) {
                    final car = featuredCars[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CarDetailsScreen(car: car),
                          ),
                        );
                      },
                      child: FeaturedCarCard(
                        car: car,
                        onFavoritePressed: () {
                          setState(() {
                            car.isFavorite = !car.isFavorite;
                          });
                        },
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 24),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Popular Cars',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      'See all',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.secondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: popularCars.length,
                  itemBuilder: (context, index) {
                    final car = popularCars[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CarDetailsScreen(car: car),
                          ),
                        );
                      },
                      child: PopularCarCard(
                        car: car,
                        onFavoritePressed: () {
                          setState(() {
                            car.isFavorite = !car.isFavorite;
                          });
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

// (legacy inline car card removed; using FeaturedCarCard/PopularCarCard components)
