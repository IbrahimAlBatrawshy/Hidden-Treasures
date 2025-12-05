import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../models/restaurant_model.dart';
import '../../componets/componets.dart';
import '../../constants/app_colors.dart';

class RestaurantDeatailsScreen extends StatefulWidget {
  final Restaurant restaurant;

  const RestaurantDeatailsScreen({
    super.key,
    required this.restaurant,
  });

  @override
  State<RestaurantDeatailsScreen> createState() => _RestaurantDeatailsScreenState();
}

class _RestaurantDeatailsScreenState extends State<RestaurantDeatailsScreen> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.restaurant.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF3E0),
      appBar: AppBar(
        backgroundColor: AppColors.secondary,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white, size: 25),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title:  Text(
          'Details',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Main Restaurant Image
              Container(
                height: 240,
                margin:  EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadowLight,
                      blurRadius: 8,
                      offset:  Offset(0, 4),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        widget.restaurant.imageUrl,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: AppColors.backgroundSecondary,
                            child:  Icon(Icons.restaurant, size: 50, color: AppColors.textLight),
                          );
                        },
                      ),
                    ),
                    // Favorite Button
                    Positioned(
                      top: 12,
                      right: 12,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isFavorite = !isFavorite;
                          });
                        },
                        child: Container(
                          padding:  EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.background,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.shadowLight,
                                blurRadius: 4,
                                offset:  Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? AppColors.favorite : AppColors.textLight,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

               SizedBox(height: 16),

              // Feature Tags
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    FeatureTag(icon: Icons.wifi, text: 'Free Wifi'),
                     SizedBox(width: 8),
                    FeatureTag(icon: Icons.free_breakfast, text: 'Breakfast'),
                     SizedBox(width: 8),
                    FeatureTag(icon: Icons.star, text: '5.0'),
                  ],
                ),
              ),

               SizedBox(height: 16),

              // Restaurant Name and Location
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.restaurant.name}',
                      style:  TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                     SizedBox(height: 8),
                    Row(
                      children: [
                         Icon(
                          Icons.location_on,
                          color: AppColors.secondary,
                          size: 16,
                        ),
                         SizedBox(width: 4),
                        Text(
                          widget.restaurant.address,
                          style:  TextStyle(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

               SizedBox(height: 20),

              // Description Section
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                     SizedBox(height: 8),
                     Text(
                      'Mo Bistro Restaurant is a modern dining destination known for its vibrant atmosphere, stylish interiors, and a menu that blends international flavors with a contemporary twist.',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),

               SizedBox(height: 20),

              // Menu Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Menu',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          List<String> menuImages = [
                            'https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=200',
                            'https://images.unsplash.com/photo-1565299624946-b28f40a0ca4b?w=200',
                            'https://images.unsplash.com/photo-1551218808-94e220e084d2?w=200',
                          ];
                          List<String> menuTitles = [
                            'Steak',
                            'Pasta',
                            'Dessert',
                          ];
                          return MenuThumbnailCard(
                            imageUrl: menuImages[index],
                            title: menuTitles[index],
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Selected ${menuTitles[index]}'),
                                  backgroundColor: AppColors.primary,
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),
            ],

          ),
        ),
      ),
      bottomNavigationBar: BookingButton(
        text: 'Connected With Restaurant',
        onPressed: () {
          // Show hotline dialog with copy action
          showDialog(
            context: context,
            builder: (context) {
              final phoneStr = widget.restaurant.phoneNumber.toString();
              final displayed = phoneStr.length >= 5 ? phoneStr.substring(0, 5) : phoneStr;
              return Dialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 8,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                      decoration: const BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.call, color: AppColors.textWhite),
                          const SizedBox(width: 8),
                          const Expanded(
                            child: Text(
                              'Restaurant Hotline',
                              style: TextStyle(
                                color: AppColors.textWhite,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => Navigator.of(context).pop(),
                            child: const Icon(Icons.close, color: AppColors.textWhite),
                          ),
                        ],
                      ),
                    ),

                    // Content
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            displayed,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Use this number to contact the restaurant for reservations or inquiries.',
                            style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
                          ),
                          const SizedBox(height: 16),

                          // Actions
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () async {
                                    await Clipboard.setData(ClipboardData(text: phoneStr));
                                    Navigator.of(context).pop();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.secondary,
                                    foregroundColor: AppColors.textWhite,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 12),
                                    child: Text('Copy', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(color: AppColors.secondary),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 12),
                                    child: Text('Close', style: TextStyle(fontSize: 16)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),

    );
  }
}
