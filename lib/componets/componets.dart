import 'package:flutter/material.dart';
import '../models/hotel_model.dart';
import '../models/restaurant_model.dart';
import '../models/event_model.dart';
import '../constants/app_colors.dart';

class FeaturedHotelCard extends StatelessWidget {
  final Hotel hotel;
  final VoidCallback? onTap;
  final VoidCallback? onFavoritePressed;

  const FeaturedHotelCard({
    super.key,
    required this.hotel,
    this.onTap,
    this.onFavoritePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      margin:  EdgeInsets.only(right: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
         boxShadow: [
           BoxShadow(
             color: AppColors.shadowLight,
             blurRadius: 8,
             offset:  Offset(0, 4),
           ),
         ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Hotel Image
            Positioned.fill(
              child: Image.network(
                hotel.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                   return Container(
                     color: AppColors.backgroundSecondary,
                     child:  Icon(Icons.hotel, size: 50, color: AppColors.textLight),
                   );
                },
              ),
            ),
            
            // Favorite Button
            Positioned(
              top: 12,
              right: 12,
              child: GestureDetector(
                onTap: onFavoritePressed,
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
                     hotel.isFavorite ? Icons.favorite : Icons.favorite_border,
                     color: hotel.isFavorite ? AppColors.favorite : AppColors.textLight,
                     size: 20,
                   ),
                ),
              ),
            ),
            
            // Bottom Info Overlay
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding:  EdgeInsets.all(16),
                 decoration: BoxDecoration(
                   gradient: AppColors.overlayGradient,
                 ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Text(
                       hotel.name,
                       style:  TextStyle(
                         color: AppColors.textWhite,
                         fontSize: 18,
                         fontWeight: FontWeight.bold,
                       ),
                     ),
                      SizedBox(height: 4),
                     Text(
                       hotel.address,
                       style: TextStyle(
                         color: AppColors.textWhite.withOpacity(0.9),
                         fontSize: 14,
                       ),
                     ),
                     SizedBox(height: 8),
                    Row(
                      children: [
                         Icon(
                           Icons.star,
                           color: AppColors.star,
                           size: 16,
                         ),
                          SizedBox(width: 4),
                         Text(
                           hotel.rating.toString(),
                           style:  TextStyle(
                             color: AppColors.textWhite,
                             fontSize: 14,
                             fontWeight: FontWeight.w500,
                           ),
                         ),
                          Spacer(),
                         Text(
                           '\$${hotel.price.toStringAsFixed(1)} /night',
                           style:  TextStyle(
                             color: AppColors.textWhite,
                             fontSize: 16,
                             fontWeight: FontWeight.bold,
                           ),
                         ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PopularHotelCard extends StatelessWidget {
  final Hotel hotel;
  final VoidCallback? onTap;
  final VoidCallback? onFavoritePressed;

  const PopularHotelCard({
    super.key,
    required this.hotel,
    this.onTap,
    this.onFavoritePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin:  EdgeInsets.only(right: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
         boxShadow: [
           BoxShadow(
             color: AppColors.shadowLight,
             blurRadius: 6,
             offset:  Offset(0, 3),
           ),
         ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hotel Image
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.network(
                      hotel.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                         return Container(
                           color: AppColors.backgroundSecondary,
                           child:  Icon(Icons.hotel, size: 30, color: AppColors.textLight),
                         );
                      },
                    ),
                  ),
                  // Favorite Button
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: onFavoritePressed,
                      child: Container(
                        padding: EdgeInsets.all(6),
                         decoration: BoxDecoration(
                           color: AppColors.background,
                           shape: BoxShape.circle,
                           boxShadow: [
                             BoxShadow(
                               color: AppColors.shadowLight,
                               blurRadius: 3,
                               offset:  Offset(0, 1),
                             ),
                           ],
                         ),
                         child: Icon(
                           hotel.isFavorite ? Icons.favorite : Icons.favorite_border,
                           color: hotel.isFavorite ? AppColors.favorite : AppColors.textLight,
                           size: 16,
                         ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Hotel Info
            Expanded(
              flex: 2,
              child: Padding(
                padding:  EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Text(
                       hotel.name,
                       style:  TextStyle(
                         fontSize: 10,
                         fontWeight: FontWeight.bold,
                         color: AppColors.textPrimary,
                       ),
                       maxLines: 1,
                       overflow: TextOverflow.ellipsis,
                     ),
                      SizedBox(height: 4),
                     Text(
                       hotel.address,
                       style: TextStyle(
                         color: AppColors.textSecondary,
                         fontSize: 12,
                       ),
                       maxLines: 1,
                       overflow: TextOverflow.ellipsis,
                     ),
                     Spacer(),
                    Row(
                      children: [
                         Icon(
                          Icons.star,
                          color: AppColors.star,
                          size: 14,
                        ),
                         SizedBox(width: 4),
                        Text(
                          hotel.rating.toString(),
                          style:  TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textPrimary,
                          ),
                        ),
                         Spacer(),
                        Text(
                          '\$${hotel.price.toStringAsFixed(1)} /night',
                          style:  TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FeatureTag extends StatelessWidget {
  final IconData icon;
  final String text;

  const FeatureTag({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: AppColors.textPrimary,
          ),
           SizedBox(width: 4),
          Text(
            text,
            style:  TextStyle(
              fontSize: 12,
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class BookingButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;

  const BookingButton({
    super.key,
    required this.text,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.background,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 8,
            offset:  Offset(0, -4),
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor ?? AppColors.secondary,
            foregroundColor: textColor ?? AppColors.textWhite,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 0,
          ),
          child: Text(
            text,
            style:  TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class FeaturedRestaurantCard extends StatelessWidget {
  final Restaurant restaurant;
  final VoidCallback? onTap;
  final VoidCallback? onFavoritePressed;

  const FeaturedRestaurantCard({
    super.key,
    required this.restaurant,
    this.onTap,
    this.onFavoritePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      margin:  EdgeInsets.only(right: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 8,
            offset:  Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Restaurant Image
            Positioned.fill(
              child: Image.network(
                restaurant.imageUrl,
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
                onTap: onFavoritePressed,
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
                    restaurant.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: restaurant.isFavorite ? AppColors.favorite : AppColors.textLight,
                    size: 20,
                  ),
                ),
              ),
            ),
            
            // Bottom Info Overlay
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding:  EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: AppColors.overlayGradient,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurant.name,
                      style:  TextStyle(
                        color: AppColors.textWhite,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                     SizedBox(height: 4),
                    Text(
                      restaurant.address,
                      style: TextStyle(
                        color: AppColors.textWhite.withOpacity(0.9),
                        fontSize: 14,
                      ),
                    ),
                     SizedBox(height: 8),
                    Row(
                      children: [
                         Icon(
                          Icons.star,
                          color: AppColors.star,
                          size: 16,
                        ),
                         SizedBox(width: 4),
                        Text(
                          restaurant.rating.toString(),
                          style:  TextStyle(
                            color: AppColors.textWhite,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                         Spacer(),
                        Text(
                          '\$${restaurant.price.toStringAsFixed(0)} /person',
                          style:  TextStyle(
                            color: AppColors.textWhite,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PopularRestaurantCard extends StatelessWidget {
  final Restaurant restaurant;
  final VoidCallback? onTap;
  final VoidCallback? onFavoritePressed;

  const PopularRestaurantCard({
    super.key,
    required this.restaurant,
    this.onTap,
    this.onFavoritePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin:  EdgeInsets.only(right: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 6,
            offset:  Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Restaurant Image
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.network(
                      restaurant.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: AppColors.backgroundSecondary,
                          child:  Icon(Icons.restaurant, size: 30, color: AppColors.textLight),
                        );
                      },
                    ),
                  ),
                  // Favorite Button
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: onFavoritePressed,
                      child: Container(
                        padding:  EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.shadowLight,
                              blurRadius: 3,
                              offset:  Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Icon(
                          restaurant.isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: restaurant.isFavorite ? AppColors.favorite : AppColors.textLight,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Restaurant Info
            Expanded(
              flex: 2,
              child: Padding(
                padding:  EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurant.name,
                      style:  TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                     SizedBox(height: 4),
                    Text(
                      restaurant.address,
                      style:  TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                     Spacer(),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: AppColors.star,
                          size: 14,
                        ),
                         SizedBox(width: 4),
                        Text(
                          restaurant.rating.toString(),
                          style:  TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textPrimary,
                          ),
                        ),
                         Spacer(),
                        Text(
                          '\$${restaurant.price.toStringAsFixed(0)} /person',
                          style:  TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuThumbnailCard extends StatelessWidget {
  final String imageUrl;
  final String? title;
  final VoidCallback? onTap;

  const MenuThumbnailCard({
    super.key,
    required this.imageUrl,
    this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        height: 100,
        margin:  EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowLight,
              blurRadius: 4,
              offset:  Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: AppColors.backgroundSecondary,
                      child:  Icon(Icons.restaurant_menu, size: 30, color: AppColors.textLight),
                    );
                  },
                ),
              ),
              if (title != null)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding:  EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius:  BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                    child: Text(
                      title!,
                      style:  TextStyle(
                        color: AppColors.textWhite,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class FeaturedEventCard extends StatelessWidget {
  final Event event;
  final VoidCallback? onTap;
  final VoidCallback? onFavoritePressed;

  const FeaturedEventCard({
    super.key,
    required this.event,
    this.onTap,
    this.onFavoritePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Event Image
            Positioned.fill(
              child: Image.network(
                event.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: AppColors.backgroundSecondary,
                    child: const Icon(Icons.event, size: 50, color: AppColors.textLight),
                  );
                },
              ),
            ),
            
            // Favorite Button
            Positioned(
              top: 12,
              right: 12,
              child: GestureDetector(
                onTap: onFavoritePressed,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.shadowLight,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    event.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: event.isFavorite ? AppColors.favorite : AppColors.textLight,
                    size: 20,
                  ),
                ),
              ),
            ),
            
            // Category Tag
            Positioned(
              top: 12,
              left: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.secondary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  event.category,
                  style: const TextStyle(
                    color: AppColors.textWhite,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            
            // Bottom Info Overlay
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  gradient: AppColors.overlayGradient,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.name,
                      style: const TextStyle(
                        color: AppColors.textWhite,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: AppColors.textWhite,
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            event.location,
                            style: TextStyle(
                              color: AppColors.textWhite.withOpacity(0.9),
                              fontSize: 14,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: AppColors.star,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          event.rating.toString(),
                          style: const TextStyle(
                            color: AppColors.textWhite,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '\$${event.price.toStringAsFixed(0)}',
                          style: const TextStyle(
                            color: AppColors.textWhite,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppHeader extends StatelessWidget {
  final TextEditingController searchController;
  final String searchHint;
  final VoidCallback? onProfileTap;
  final VoidCallback? onSearchChanged;

  const AppHeader({
    super.key,
    required this.searchController,
    this.searchHint = 'Search for events...',
    this.onProfileTap,
    this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Greeting and Profile
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Hello,',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const Text(
                    'Where do you want to go?',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: onProfileTap,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.backgroundSecondary,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.shadowLight,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.person,
                    color: AppColors.textPrimary,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Search Bar
          Container(
            decoration: BoxDecoration(
              color: AppColors.backgroundSecondary,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadowLight,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              controller: searchController,
              onChanged: (value) => onSearchChanged?.call(),
              decoration: InputDecoration(
                hintText: searchHint,
                hintStyle: const TextStyle(
                  color: AppColors.textLight,
                  fontSize: 16,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.textSecondary,
                  size: 24,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
              ),
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PopularEventCard extends StatelessWidget {
  final Event event;
  final VoidCallback? onTap;
  final VoidCallback? onFavoritePressed;

  const PopularEventCard({
    super.key,
    required this.event,
    this.onTap,
    this.onFavoritePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin:  EdgeInsets.only(right: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 6,
            offset:  Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Event Image
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.network(
                      event.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: AppColors.backgroundSecondary,
                          child:  Icon(Icons.event, size: 30, color: AppColors.textLight),
                        );
                      },
                    ),
                  ),
                  // Favorite Button
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: onFavoritePressed,
                      child: Container(
                        padding:  EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.shadowLight,
                              blurRadius: 3,
                              offset:  Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Icon(
                          event.isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: event.isFavorite ? AppColors.favorite : AppColors.textLight,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                  // Category Tag
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding:  EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        event.category,
                        style:  TextStyle(
                          color: AppColors.textWhite,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Event Info
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.name,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: AppColors.textSecondary,
                          size: 12,
                        ),
                         SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            event.location,
                            style:  TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 12,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                     Spacer(),
                    Row(
                      children: [
                         Icon(
                          Icons.star,
                          color: AppColors.star,
                          size: 14,
                        ),
                         SizedBox(width: 4),
                        Text(
                          event.rating.toString(),
                          style:  TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textPrimary,
                          ),
                        ),
                         Spacer(),
                        Text(
                          '\$${event.price.toStringAsFixed(0)}',
                          style:  TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
