import 'package:equatable/equatable.dart';

class FavoritesState extends Equatable {
  final Set<String> favoriteHotels;
  final Set<String> favoriteRestaurants;
  final Set<String> favoriteEvents;
  final Set<String> favoriteCars;

  const FavoritesState({
    this.favoriteHotels = const {},
    this.favoriteRestaurants = const {},
    this.favoriteEvents = const {},
    this.favoriteCars = const {},
  });

  FavoritesState copyWith({
    Set<String>? favoriteHotels,
    Set<String>? favoriteRestaurants,
    Set<String>? favoriteEvents,
    Set<String>? favoriteCars,
  }) {
    return FavoritesState(
      favoriteHotels: favoriteHotels ?? this.favoriteHotels,
      favoriteRestaurants: favoriteRestaurants ?? this.favoriteRestaurants,
      favoriteEvents: favoriteEvents ?? this.favoriteEvents,
      favoriteCars: favoriteCars ?? this.favoriteCars,
    );
  }

  int get totalFavorites =>
      favoriteHotels.length +
      favoriteRestaurants.length +
      favoriteEvents.length +
      favoriteCars.length;

  @override
  List<Object?> get props => [
        favoriteHotels,
        favoriteRestaurants,
        favoriteEvents,
        favoriteCars,
      ];

  // For persistence
  Map<String, dynamic> toJson() {
    return {
      'hotels': favoriteHotels.toList(),
      'restaurants': favoriteRestaurants.toList(),
      'events': favoriteEvents.toList(),
      'cars': favoriteCars.toList(),
    };
  }

  factory FavoritesState.fromJson(Map<String, dynamic> json) {
    return FavoritesState(
      favoriteHotels: Set<String>.from(json['hotels'] ?? []),
      favoriteRestaurants: Set<String>.from(json['restaurants'] ?? []),
      favoriteEvents: Set<String>.from(json['events'] ?? []),
      favoriteCars: Set<String>.from(json['cars'] ?? []),
    );
  }
}
