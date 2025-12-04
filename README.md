# HiddenTreasures-DEPI

## 💎 Project Overview

**HiddenTreasures-DEPI** is a robust, cross-platform mobile application developed using **Flutter**. The project is designed to be a feature-rich foundation, with a strong emphasis on secure user authentication, advanced state management, and integration of various third-party services.

The application is built to support multiple platforms:
*   **Mobile:** Android, iOS
*   **Desktop:** Windows, macOS, Linux
*   **Web**

The primary development language is **Dart**, with platform-specific configurations handled by **C++** and **CMake**.

## ✨ Key Features

The `mo-latest` branch includes a wide array of integrated features, making it a comprehensive starting point for a modern mobile application:

*   **Secure Authentication:** Full Firebase Email/Password authentication flow with sign-in, sign-up, and password reset.
*   **Mandatory Email Verification:** Enforced email verification with an auto-checking screen, resend functionality, and a 60-second cooldown.
*   **Advanced State Management:** Utilizes the **BLoC/Cubit** pattern with **HydratedBloc** for predictable, persistent, and scalable state management.
*   **Location & Mapping:** Integration with Google Maps for location services, geolocation, and drawing polylines.
*   **Credit Card Integration:** Functionality for handling credit card inputs and payment-related features.
*   **Real-time Messaging:** Firebase Cloud Messaging for push notifications.
*   **Social Sign-In:** Support for Google and Facebook sign-in.
*   **Chatbot:** Inclusion of a dedicated chatbot feature.

## 📱 Application Screens

The application is structured with a variety of screens to handle user authentication, navigation, and core features.

### Authentication Screens

| Screen | File | Description |
| :--- | :--- | :--- |
| **Login Screen** | `login_screen.dart` | Handles user sign-in with email/password, forgot password, and navigation to the sign-up screen. |
| **Sign Up Screen** | `signup_screen.dart` | Handles new user registration and automatically triggers email verification. |
| **Email Verification Screen** | `email_verification_screen.dart` | Mandatory screen for unverified users, featuring auto-check, resend email, and manual check functionality. |
| **Logout Screen** | `logout_screen.dart` | Handles the user sign-out process. |

### Main Navigation Screens (Bottom Navigation Bar)

These screens are likely accessed via a bottom navigation bar, as suggested by the `bottomNavPages` directory.

| Screen | File | Description |
| :--- | :--- | :--- |
| **Favorites Screen** | `bottomNavPages/fav_screen.dart` | Displays the user's saved favorite items (e.g., hotels, restaurants), managed by `FavoritesCubit`. |
| **Map Screen** | `bottomNavPages/map_screen.dart` | Displays the map interface, likely for searching and viewing locations, utilizing `google_maps_flutter` and `geolocator`. |
| **New Profile Screen** | `bottomNavPages/new_pf_Screen.dart` | A new or updated user profile screen. |
| **Chats Screen** | `bottomNavPages/chats/` | Contains screens related to the in-app chat or messaging feature. |

### Feature & Utility Screens

| Screen | File | Description |
| :--- | :--- | :--- |
| **Home Screen** | `home_screen.dart` | The main landing page after successful login/verification. |
| **My Account Screen** | `myaccount_screen.dart` | User account settings and profile management. |
| **Notifications Screen** | `notifications_screen.dart` | Displays a list of user notifications. |
| **Help Center Screen** | `help_center_screen.dart` | Provides help, support, and troubleshooting information. |
| **Car/Event/Hotel/Restaurant** | `car/`, `event/`, `hotel/`, `restaurant/` | Directories suggesting dedicated screens for detailed views and listings of these specific categories (e.g., Car Details, Event Listings, Hotel Booking, Restaurant Menus). |

## ⚙️ Technology Stack and Dependencies

The project leverages a modern Flutter stack with the following key dependencies (from `pubspec.yaml`):

| Category | Package | Version | Purpose |
| :--- | :--- | :--- | :--- |
| **State Management** | `flutter_bloc` | `^8.1.6` | Core BLoC/Cubit implementation for state management. |
| | `equatable` | `^2.0.5` | Value equality for BLoC states and events. |
| | `hydrated_bloc` | `^9.1.5` | Automatic state persistence to local storage. |
| **Firebase** | `firebase_core` | `^4.1.1` | Core Firebase services initialization. |
| | `firebase_auth` | `^6.1.0` | Email/Password and social authentication. |
| | `firebase_messaging` | `^16.0.2` | Push notifications and real-time messaging. |
| | `cloud_functions` | `^6.0.3` | Calling Firebase Cloud Functions. |
| **Mapping & Location** | `google_maps_flutter` | `^2.13.1` | Displaying and interacting with Google Maps. |
| | `geolocator` | `^14.0.2` | Accessing the device's current location. |
| | `flutter_polyline_points` | `^3.1.0` | Decoding encoded polylines for routes. |
| | `flutter_map` | `^5.0.0` | Open-source map library. |
| | `latlong2` | `^0.9.1` | Latitude and longitude utilities. |
| **User Interface** | `lottie` | `^3.3.2` | Displaying Lottie animations. |
| | `flutter_svg` | `^2.2.1` | Rendering SVG files. |
| | `awesome_dialog` | `^3.3.0` | Customizable, animated dialogs. |
| | `circle_nav_bar` | `^2.2.0` | Custom circular navigation bar. |
| **Utility & Other** | `flutter_credit_card` | `^4.1.0` | UI for credit card input. |
| | `permission_handler` | `^12.0.1` | Managing device permissions (e.g., location). |
| | `shared_preferences` | `^2.1.0` | Simple persistent storage for key-value pairs. |
| | `chat_bot` | `^1.3.2` | Chatbot implementation. |
| | `intl` | `^0.18.2` | Internationalization and localization. |

## 🏗️ Application Architecture

The project follows a clean, maintainable architecture centered around the **BLoC/Cubit** pattern for state management.

### State Management (BLoC/Cubit)

*   **Core Principle:** All application state is managed by **Cubits** (a simpler version of BLoC) to ensure a clear separation of concerns between the UI and business logic.
*   **Persistence:** **HydratedBloc** is used to automatically persist and rehydrate the state of specific Cubits (e.g., `FavoritesCubit`, `UserProfileCubit`, `AppSettingsCubit`) to local storage, ensuring data survives app restarts.
*   **Cubits Implemented:**
    *   `AuthCubit`: Handles all authentication states and operations.
    *   `FavoritesCubit`: Manages user-specific favorites (e.g., hotels, restaurants) with persistence.
    *   `UserProfileCubit`: Manages user profile data and synchronization with Firebase.
    *   `AppSettingsCubit`: Manages app-wide settings like dark mode and language.

### Authentication Flow

The authentication is handled by `firebase_auth` and is tightly integrated with the state management system.

1.  **Sign Up:** User registers, and a verification email is automatically sent.
2.  **Redirection:** The user is immediately redirected to the **Email Verification Screen**.
3.  **Verification Screen:** This screen:
    *   Automatically checks the user's verification status every 3 seconds.
    *   Provides a "Resend Email" button with a 60-second cooldown.
    *   Redirects to the main app only after successful email verification.
4.  **Sign In:** Unverified users attempting to sign in are blocked and redirected to the verification screen.

## 🛠️ Getting Started

### Prerequisites

*   [Flutter SDK](https://flutter.dev/docs/get-started/install) installed and configured.
*   A **Firebase Project** with the following services enabled:
    *   **Authentication:** Email/Password, Google Sign-In, and Facebook Sign-In.
    *   **Cloud Messaging** (for push notifications).
    *   **Cloud Functions** (if used).

### Setup

1.  **Clone the repository and switch branch:**
    ```bash
    git clone https://github.com/Mohamed-Ayman28/HiddenTreasures-DEPI.git
    cd HiddenTreasures-DEPI
    git checkout mo-latest
    ```

2.  **Install dependencies:**
    ```bash
    flutter pub get
    ```

3.  **Configure Firebase:**
    *   Add your platform-specific configuration files (`google-services.json` for Android, `GoogleService-Info.plist` for iOS) to the respective platform folders.
    *   Ensure all required sign-in providers are enabled in your Firebase console.

4.  **Run the application:**
    ```bash
    flutter run
    ```

## 📚 Internal Documentation

For more in-depth details on the implementation of core features, please refer to the following files within the repository:

*   [`FIREBASE_AUTH_README.md`](FIREBASE_AUTH_README.md): Detailed guide on the Firebase Email/Password authentication implementation.
*   [`EMAIL_VERIFICATION_FEATURE.md`](EMAIL_VERIFICATION_FEATURE.md): In-depth explanation of the email verification screen, user flow, and technical implementation.
*   [`STATE_MANAGEMENT_GUIDE.md`](STATE_MANAGEMENT_GUIDE.md): Comprehensive guide on the BLoC/Cubit architecture and HydratedBloc persistence.

## 🤝 Contributing

This project is currently under active development on the `mo-latest` branch. Contributions, bug reports, and feature suggestions are welcome via issues and pull requests.

## 📝 License

*(License information is not explicitly provided in the repository. Please check the repository for a LICENSE file or contact the maintainer for licensing details.)*

## 🧑‍💻 Developer

**Mohamed-Ayman28**
*   *Note: The original repository only mentions the developer's GitHub handle.*
