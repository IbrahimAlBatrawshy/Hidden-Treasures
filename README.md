# HiddenTreasures-DEPI

## 💎 Project Overview

**HiddenTreasures-DEPI** is a cross-platform mobile application developed using **Flutter**. It is a project focused on providing a robust and secure user authentication system, primarily leveraging **Firebase Authentication** for email and password sign-in, along with a comprehensive **Email Verification** feature.

The project is structured as a multi-platform Flutter application, supporting:

*   **Mobile:** Android, iOS
*   **Desktop:** Windows, macOS, Linux
*   **Web**

The core language is **Dart** (9.3%), with significant portions of the codebase dedicated to platform-specific configurations in **C++** (45.7%) and **CMake** (36.5%).

## 🔐 Authentication Features

The application features a fully implemented and secure user authentication flow using Firebase Email/Password Authentication.

### Key Authentication Components:

| Component | File | Features Implemented |
| :--- | :--- | :--- |
| **Login Screen** | `login_screen.dart` | Sign-in, password visibility toggle, loading indicator, error handling, and forgot password functionality. |
| **Sign Up Screen** | `signup_screen.dart` | User registration, password validation, display name update, and automatic email verification sending. |
| **Auth Service** | `services/auth_service.dart` | Centralized service for all authentication operations: sign-in, registration, sign-out, password reset, email verification, and profile updates. |

### Email Verification Enforcement

A dedicated **Email Verification Screen** (`email_verification_screen.dart`) ensures that users cannot access the main application until their email address is verified.

| Feature | Description |
| :--- | :--- |
| **Automatic Checking** | The screen automatically checks the verification status every 3 seconds and redirects to the home screen upon success. |
| **Resend Email** | A one-click option to resend the verification email with a 60-second cooldown to prevent spam. |
| **Manual Check** | A "I've Verified My Email" button for an instant status check. |
| **User Flow** | Unverified users are redirected to this screen upon sign-in, and new sign-ups are automatically sent here. |

## 🛠️ Getting Started

This project is a standard Flutter application. To get started, ensure you have the Flutter SDK installed and configured.

### Prerequisites

*   [Flutter SDK](https://flutter.dev/docs/get-started/install)
*   [Firebase Project](https://console.firebase.google.com/) with **Email/Password** sign-in enabled in the **Authentication** section.

### Setup

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/Mohamed-Ayman28/HiddenTreasures-DEPI.git
    cd HiddenTreasures-DEPI
    ```

2.  **Switch to the `mo-latest` branch:**
    ```bash
    git checkout mo-latest
    ```

3.  **Install dependencies:**
    ```bash
    flutter pub get
    ```

4.  **Configure Firebase:**
    *   Follow the official FlutterFire documentation to add your `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) files to the respective platform folders.
    *   Ensure the **Email/Password** sign-in provider is enabled in your Firebase console.

5.  **Run the application:**
    ```bash
    flutter run
    ```

## 🚀 How to Test Authentication

The application is ready for testing the full authentication and verification flow:

1.  **Sign Up:** Create a new account. You will be immediately redirected to the **Email Verification Screen**.
2.  **Verify Email:** Check your email inbox and click the verification link. The app will automatically detect the change and navigate to the home screen.
3.  **Sign In:** Sign out and then sign back in with your verified credentials.
4.  **Unverified Sign In:** If you sign up and do *not* verify your email, attempting to sign in will redirect you back to the **Email Verification Screen**.

## 📚 Documentation

For more detailed information on specific features, please refer to the following internal documentation files:

*   [`FIREBASE_AUTH_README.md`](FIREBASE_AUTH_README.md): Detailed guide on the Firebase Email/Password authentication implementation.
*   [`EMAIL_VERIFICATION_FEATURE.md`](EMAIL_VERIFICATION_FEATURE.md): In-depth explanation of the email verification screen, user flow, and technical implementation.

## 🤝 Contributing

This project is currently under active development on the `mo-latest` branch. Contributions are welcome. Please open an issue or submit a pull request for any suggested improvements or bug fixes.

## 📝 License

*(License information is not explicitly provided in the repository. Assume standard open-source practices or add license information once available.)*

## 🧑‍💻 Developer

**Mohamed-Ayman28**
**Mohamed-Ayman28**
**Mohamed-Ayman28**
**Mohamed-Ayman28**
