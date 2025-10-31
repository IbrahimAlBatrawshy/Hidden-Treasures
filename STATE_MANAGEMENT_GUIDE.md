# State Management Implementation Guide

## Overview
This project now uses **Cubit** (from the flutter_bloc package) for state management across the entire Hidden Treasures app. All state is managed centrally and persisted using HydratedBloc.

---

## Architecture

### Dependencies Added
```yaml
flutter_bloc: ^8.1.6       # BLoC pattern implementation
equatable: ^2.0.5          # Value equality for states
hydrated_bloc: ^9.1.5      # State persistence
path_provider: ^2.1.4      # Local storage paths
```

### File Structure
```
lib/
├── cubits/
│   ├── auth/
│   │   ├── auth_state.dart        # Authentication states
│   │   └── auth_cubit.dart        # Auth business logic
│   ├── favorites/
│   │   ├── favorites_state.dart   # Favorites state with JSON
│   │   └── favorites_cubit.dart   # Favorites management
│   ├── user_profile/
│   │   ├── user_profile_state.dart  # User profile state
│   │   └── user_profile_cubit.dart  # Profile management
│   └── app_settings/
│       ├── app_settings_state.dart  # App settings state
│       └── app_settings_cubit.dart  # Settings management
├── main.dart                         # Updated with BLoC providers
└── screens/
    ├── login_screen.dart            # ✅ Updated to use AuthCubit
    ├── signup_screen.dart           # ✅ Updated to use AuthCubit
    ├── fav_screen.dart              # ⏳ Needs FavoritesCubit integration
    ├── Profile_screen.dart          # ⏳ Needs UserProfileCubit integration
    └── settings_screen.dart         # ⏳ Needs AppSettingsCubit integration
```

---

## Cubits Overview

### 1. AuthCubit (`lib/cubits/auth/`)

**Purpose:** Manages authentication state and Firebase Auth operations

**States:**
- `AuthInitial` - Initial state when app starts
- `AuthLoading` - During async auth operations
- `AuthAuthenticated` - User successfully logged in
- `AuthUnauthenticated` - User not logged in
- `AuthEmailVerificationRequired` - Email needs verification
- `AuthError` - Authentication error occurred

**Methods:**
```dart
await authCubit.signIn(email, password);
await authCubit.signUp(email, password, displayName);
await authCubit.signOut();
await authCubit.sendPasswordResetEmail(email);
await authCubit.reloadUser();
```

**Usage Example:**
```dart
BlocConsumer<AuthCubit, AuthState>(
  listener: (context, state) {
    if (state is AuthAuthenticated) {
      // Navigate to home
    } else if (state is AuthError) {
      // Show error message
    }
  },
  builder: (context, state) {
    final isLoading = state is AuthLoading;
    return ElevatedButton(
      onPressed: isLoading ? null : () {
        context.read<AuthCubit>().signIn(email, password);
      },
      child: isLoading ? CircularProgressIndicator() : Text('Login'),
    );
  },
)
```

---

### 2. FavoritesCubit (`lib/cubits/favorites/`)

**Purpose:** Manages user favorites across all categories with automatic persistence

**State Properties:**
```dart
Set<String> favoriteHotels       // Hotel IDs
Set<String> favoriteRestaurants  // Restaurant IDs
Set<String> favoriteEvents       // Event IDs
Set<String> favoriteCars         // Car IDs
int totalFavorites               // Total count
```

**Methods:**
```dart
favoritesCubit.toggleHotel(hotelId);
favoritesCubit.toggleRestaurant(restaurantId);
favoritesCubit.toggleEvent(eventId);
favoritesCubit.toggleCar(carId);

bool isFavorite = favoritesCubit.isHotelFavorite(hotelId);
favoritesCubit.clearAllFavorites();
```

**Usage Example:**
```dart
BlocBuilder<FavoritesCubit, FavoritesState>(
  builder: (context, state) {
    final isFavorite = state.favoriteHotels.contains(hotel.id);
    
    return IconButton(
      icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
      onPressed: () {
        context.read<FavoritesCubit>().toggleHotel(hotel.id);
      },
    );
  },
)
```

**Persistence:** Automatically saves to local storage. Survives app restarts!

---

### 3. UserProfileCubit (`lib/cubits/user_profile/`)

**Purpose:** Manages user profile data with Firebase synchronization

**State Properties:**
```dart
String displayName
String email
String photoUrl
int bookingsCount
int reviewsCount
bool isLoading
```

**Methods:**
```dart
await profileCubit.updateDisplayName(newName);
await profileCubit.updatePhotoUrl(newPhotoUrl);
profileCubit.incrementBookings();
profileCubit.incrementReviews();
await profileCubit.refreshFromFirebase();
```

**Usage Example:**
```dart
BlocBuilder<UserProfileCubit, UserProfileState>(
  builder: (context, state) {
    return Column(
      children: [
        Text(state.displayName),
        Text('${state.bookingsCount} Bookings'),
        ElevatedButton(
          onPressed: () async {
            await context.read<UserProfileCubit>()
                .updateDisplayName('New Name');
          },
          child: Text('Update Name'),
        ),
      ],
    );
  },
)
```

---

### 4. AppSettingsCubit (`lib/cubits/app_settings/`)

**Purpose:** Manages app-wide settings with persistence

**State Properties:**
```dart
bool darkMode                  // Dark theme enabled
bool twoFactorAuth            // 2FA enabled
String language               // App language
bool notificationsEnabled     // Push notifications
bool locationEnabled          // Location services
```

**Methods:**
```dart
settingsCubit.toggleDarkMode();
settingsCubit.toggleTwoFactorAuth();
settingsCubit.setLanguage('ar');  // 'en', 'ar', etc.
settingsCubit.toggleNotifications();
settingsCubit.toggleLocation();
settingsCubit.resetToDefaults();
```

**Usage Example:**
```dart
BlocBuilder<AppSettingsCubit, AppSettingsState>(
  builder: (context, state) {
    return SwitchListTile(
      title: Text('Dark Mode'),
      value: state.darkMode,
      onChanged: (_) {
        context.read<AppSettingsCubit>().toggleDarkMode();
      },
    );
  },
)
```

---

## Main.dart Setup

The app is initialized with HydratedBloc storage and all cubits are provided at the root level:

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize HydratedBloc storage for state persistence
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  
  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (_) => AuthCubit()),
        BlocProvider<FavoritesCubit>(create: (_) => FavoritesCubit()),
        BlocProvider<UserProfileCubit>(create: (_) => UserProfileCubit()),
        BlocProvider<AppSettingsCubit>(create: (_) => AppSettingsCubit()),
      ],
      child: MaterialApp(...),
    );
  }
}
```

---

## Completed Integrations ✅

### Login Screen (`login_screen.dart`)
- ✅ Uses `AuthCubit` for authentication
- ✅ `BlocConsumer` listens to auth state changes
- ✅ Automatically navigates on success
- ✅ Shows error messages from cubit
- ✅ Password reset functionality

### Signup Screen (`signup_screen.dart`)
- ✅ Uses `AuthCubit` for registration
- ✅ `BlocConsumer` handles state updates
- ✅ Navigates to email verification
- ✅ Comprehensive error handling

---

## Pending Integrations ⏳

### Favorites Screen (`fav_screen.dart`)
**What needs to be done:**

1. Import BLoC packages:
```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hidden_treasures/cubits/favorites/favorites_cubit.dart';
import 'package:hidden_treasures/cubits/favorites/favorites_state.dart';
```

2. Remove local state management:
```dart
// DELETE these:
List<String> favoriteHotelIds = [];
List<String> favoriteRestaurantIds = [];
List<String> favoriteEventIds = [];
List<String> favoriteCarIds = [];
```

3. Replace favorite getters:
```dart
// OLD:
List<HotelModel> get favoriteHotels =>
    HotelModel.hotels.where((h) => favoriteHotelIds.contains(h.id)).toList();

// NEW:
List<HotelModel> favoriteHotels(Set<String> favIds) =>
    HotelModel.hotels.where((h) => favIds.contains(h.id)).toList();
```

4. Wrap build method with BlocBuilder:
```dart
@override
Widget build(BuildContext context) {
  return BlocBuilder<FavoritesCubit, FavoritesState>(
    builder: (context, favState) {
      final favoriteHotelsList = favoriteHotels(favState.favoriteHotels);
      final favoriteRestaurantsList = favoriteRestaurants(favState.favoriteRestaurants);
      // ... rest of UI
    },
  );
}
```

5. Update toggle methods:
```dart
// OLD:
IconButton(
  icon: Icon(favoriteHotelIds.contains(hotel.id) ? Icons.favorite : Icons.favorite_border),
  onPressed: () {
    setState(() {
      if (favoriteHotelIds.contains(hotel.id)) {
        favoriteHotelIds.remove(hotel.id);
      } else {
        favoriteHotelIds.add(hotel.id);
      }
    });
  },
)

// NEW:
BlocBuilder<FavoritesCubit, FavoritesState>(
  builder: (context, state) {
    final isFavorite = state.favoriteHotels.contains(hotel.id);
    return IconButton(
      icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
      onPressed: () {
        context.read<FavoritesCubit>().toggleHotel(hotel.id);
      },
    );
  },
)
```

---

### Profile Screen (`Profile_screen.dart`)
**What needs to be done:**

1. Import BLoC packages:
```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hidden_treasures/cubits/user_profile/user_profile_cubit.dart';
import 'package:hidden_treasures/cubits/user_profile/user_profile_state.dart';
import 'package:hidden_treasures/cubits/favorites/favorites_cubit.dart';
```

2. Replace static user data with cubit:
```dart
// OLD:
final user = UserModel.users.first;

// NEW: Wrap with BlocBuilder
BlocBuilder<UserProfileCubit, UserProfileState>(
  builder: (context, profileState) {
    return Column(
      children: [
        Text(profileState.displayName),
        Text(profileState.email),
        // ...
      ],
    );
  },
)
```

3. Update stats to use cubits:
```dart
BlocBuilder<FavoritesCubit, FavoritesState>(
  builder: (context, favState) {
    return _buildStatCard(
      '${favState.totalFavorites}',
      'Favorites',
      Icons.favorite,
      Colors.red,
    );
  },
)

BlocBuilder<UserProfileCubit, UserProfileState>(
  builder: (context, profileState) {
    return _buildStatCard(
      '${profileState.bookingsCount}',
      'Bookings',
      Icons.book,
      Colors.blue,
    );
  },
)
```

4. Update photo functionality:
```dart
void _showPhotoOptions(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (_) => Column(
      children: [
        ListTile(
          leading: Icon(Icons.camera),
          title: Text('Take Photo'),
          onPressed: () async {
            // Get photo from camera
            String? photoUrl = await takePhoto();
            if (photoUrl != null) {
              await context.read<UserProfileCubit>().updatePhotoUrl(photoUrl);
            }
          },
        ),
        // ... gallery option
      ],
    ),
  );
}
```

---

### Settings Screen (`settings_screen.dart`)
**What needs to be done:**

1. Import BLoC packages:
```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hidden_treasures/cubits/app_settings/app_settings_cubit.dart';
import 'package:hidden_treasures/cubits/app_settings/app_settings_state.dart';
```

2. Remove local state:
```dart
// DELETE:
bool darkMode = false;
bool twoFactorAuth = false;
bool notificationsEnabled = true;
bool locationEnabled = true;
```

3. Wrap with BlocBuilder:
```dart
@override
Widget build(BuildContext context) {
  return BlocBuilder<AppSettingsCubit, AppSettingsState>(
    builder: (context, settings) {
      return Scaffold(
        // ... app bar
        body: ListView(
          children: [
            SettingsTile(
              icon: Icons.dark_mode,
              title: 'Dark Mode',
              trailing: Switch(
                value: settings.darkMode,
                onChanged: (_) {
                  context.read<AppSettingsCubit>().toggleDarkMode();
                },
              ),
            ),
            // ... more settings
          ],
        ),
      );
    },
  );
}
```

4. Update all toggles similarly

---

## Benefits of This Implementation

### 1. **Centralized State**
- All state is managed in one place per feature
- No more prop drilling
- Easy to access from anywhere in the widget tree

### 2. **Automatic Persistence**
- Favorites, profile, and settings survive app restarts
- No manual SharedPreferences code needed
- Automatic JSON serialization

### 3. **Predictable State Changes**
- All state changes go through cubit methods
- Easy to track and debug
- Testable business logic

### 4. **Separation of Concerns**
- UI code separated from business logic
- Screens just display and trigger actions
- Cubits handle all the logic

### 5. **Reactive UI**
- BlocBuilder automatically rebuilds when state changes
- No manual setState calls needed
- Optimized rebuilds (only affected widgets)

### 6. **Better Error Handling**
- Errors are part of the state
- Consistent error handling across app
- User-friendly error messages

---

## Testing

### Unit Test Example (AuthCubit)
```dart
test('signIn emits [AuthLoading, AuthAuthenticated] on success', () {
  // Arrange
  final authCubit = AuthCubit();
  
  // Act & Assert
  expectLater(
    authCubit.stream,
    emitsInOrder([
      isA<AuthLoading>(),
      isA<AuthAuthenticated>(),
    ]),
  );
  
  authCubit.signIn('test@example.com', 'password123');
});
```

---

## Common Patterns

### Reading Cubit (One-time access)
```dart
context.read<AuthCubit>().signOut();
```

### Watching Cubit (Rebuilds on change)
```dart
final favorites = context.watch<FavoritesCubit>().state;
```

### BlocBuilder (Rebuild part of tree)
```dart
BlocBuilder<AuthCubit, AuthState>(
  builder: (context, state) => Text(state.toString()),
)
```

### BlocListener (Side effects only)
```dart
BlocListener<AuthCubit, AuthState>(
  listener: (context, state) {
    if (state is AuthError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.message)),
      );
    }
  },
  child: YourWidget(),
)
```

### BlocConsumer (Both rebuild and side effects)
```dart
BlocConsumer<AuthCubit, AuthState>(
  listener: (context, state) {
    if (state is AuthAuthenticated) Navigator.pushNamed(context, '/home');
  },
  builder: (context, state) => YourWidget(),
)
```

---

## Next Steps

1. ✅ Run the app and test login/signup with the new AuthCubit
2. ⏳ Update `fav_screen.dart` to use FavoritesCubit
3. ⏳ Update `Profile_screen.dart` to use UserProfileCubit
4. ⏳ Update `settings_screen.dart` to use AppSettingsCubit
5. ⏳ Create BlocObserver for debugging (optional)
6. ⏳ Write unit tests for all cubits
7. ⏳ Consider adding BlocProvider.value where needed for nested navigation

---

## Resources

- [flutter_bloc Documentation](https://bloclibrary.dev/)
- [HydratedBloc Guide](https://pub.dev/packages/hydrated_bloc)
- [Equatable Package](https://pub.dev/packages/equatable)
- [BLoC Pattern Architecture](https://bloclibrary.dev/#/architecture)

---

## Troubleshooting

### State not persisting?
- Make sure HydratedBloc.storage is initialized before runApp()
- Check that fromJson/toJson are implemented correctly
- Clear app data and reinstall if corrupted

### Widget not rebuilding?
- Use BlocBuilder, not just context.read()
- Make sure State class extends Equatable
- Override props getter in State classes

### Multiple rebuilds?
- Use BlocSelector for specific properties
- Consider using const constructors
- Profile with DevTools to identify issues

---

**Status:** ✅ Core implementation complete | ⏳ Screen integrations pending
