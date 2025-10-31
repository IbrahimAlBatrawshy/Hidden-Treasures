import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'favorites_state.dart';

enum FavoriteType { hotel, restaurant, event, car }

class FavoritesCubit extends HydratedCubit<FavoritesState> {
  FavoritesCubit() : super(const FavoritesState());

  void toggleHotel(String hotelName) {
    final favorites = Set<String>.from(state.favoriteHotels);
    if (favorites.contains(hotelName)) {
      favorites.remove(hotelName);
    } else {
      favorites.add(hotelName);
    }
    emit(state.copyWith(favoriteHotels: favorites));
  }

  void toggleRestaurant(String restaurantName) {
    final favorites = Set<String>.from(state.favoriteRestaurants);
    if (favorites.contains(restaurantName)) {
      favorites.remove(restaurantName);
    } else {
      favorites.add(restaurantName);
    }
    emit(state.copyWith(favoriteRestaurants: favorites));
  }

  void toggleEvent(String eventId) {
    final favorites = Set<String>.from(state.favoriteEvents);
    if (favorites.contains(eventId)) {
      favorites.remove(eventId);
    } else {
      favorites.add(eventId);
    }
    emit(state.copyWith(favoriteEvents: favorites));
  }

  void toggleCar(String carId) {
    final favorites = Set<String>.from(state.favoriteCars);
    if (favorites.contains(carId)) {
      favorites.remove(carId);
    } else {
      favorites.add(carId);
    }
    emit(state.copyWith(favoriteCars: favorites));
  }

  bool isHotelFavorite(String hotelName) {
    return state.favoriteHotels.contains(hotelName);
  }

  bool isRestaurantFavorite(String restaurantName) {
    return state.favoriteRestaurants.contains(restaurantName);
  }

  bool isEventFavorite(String eventId) {
    return state.favoriteEvents.contains(eventId);
  }

  bool isCarFavorite(String carId) {
    return state.favoriteCars.contains(carId);
  }

  void clearAllFavorites() {
    emit(const FavoritesState());
  }

  void clearFavoritesByType(FavoriteType type) {
    switch (type) {
      case FavoriteType.hotel:
        emit(state.copyWith(favoriteHotels: {}));
        break;
      case FavoriteType.restaurant:
        emit(state.copyWith(favoriteRestaurants: {}));
        break;
      case FavoriteType.event:
        emit(state.copyWith(favoriteEvents: {}));
        break;
      case FavoriteType.car:
        emit(state.copyWith(favoriteCars: {}));
        break;
    }
  }

  @override
  FavoritesState? fromJson(Map<String, dynamic> json) {
    try {
      return FavoritesState.fromJson(json);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(FavoritesState state) {
    try {
      return state.toJson();
    } catch (_) {
      return null;
    }
  }
}
