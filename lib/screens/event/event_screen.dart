import 'package:flutter/material.dart';
import '../../models/event_model.dart';
import '../../componets/componets.dart';
import '../../constants/app_colors.dart';
import 'event_details_screen.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
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
                searchHint: 'Search for events...',
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
              
              // Featured Events Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Featured Events',
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
                            content: Text('See all featured events'),
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
              
              // Featured Events List
              SizedBox(
                height: 280,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: featuredEvents.length,
                  itemBuilder: (BuildContext context, int index) {
                    Event event = featuredEvents[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EventDetailsScreen(event: event),
                          ),
                        );
                      },
                      child: FeaturedEventCard(
                        event: event,
                        onFavoritePressed: () {
                          setState(() {
                            event.isFavorite = !event.isFavorite;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                event.isFavorite 
                                  ? 'Added ${event.name} to favorites'
                                  : 'Removed ${event.name} from favorites'
                              ),
                              backgroundColor: event.isFavorite ? AppColors.favorite : AppColors.textSecondary,
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Popular Events Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Popular Events',
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
                            content: Text('See all popular events'),
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
              
              // Popular Events List
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: popularEvents.length,
                  itemBuilder: (BuildContext context, int index) {
                    Event event = popularEvents[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EventDetailsScreen(event: event),
                          ),
                        );
                      },
                      child: PopularEventCard(
                        event: event,
                        onFavoritePressed: () {
                          setState(() {
                            event.isFavorite = !event.isFavorite;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                event.isFavorite 
                                  ? 'Added ${event.name} to favorites'
                                  : 'Removed ${event.name} from favorites'
                              ),
                              backgroundColor: event.isFavorite ? AppColors.favorite : AppColors.textSecondary,
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
