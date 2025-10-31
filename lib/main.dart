import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hidden_treasures/screens/bottomNavPages/Profile_screen.dart';
import 'package:hidden_treasures/screens/bottomNavPages/chats/chat_screen.dart';
import 'package:hidden_treasures/screens/bottomNavPages/fav_screen.dart';
import 'package:hidden_treasures/screens/car/carRental_screen.dart';
import 'package:hidden_treasures/screens/event/event_screen.dart';
import 'package:hidden_treasures/screens/hotel/hotel_screen.dart';
import 'package:hidden_treasures/screens/myaccount_screen.dart';
import 'package:hidden_treasures/screens/notfications_screen.dart';
import 'package:hidden_treasures/screens/restaurant/restaurant_screen.dart';
import 'firebase_options.dart';
import 'package:hidden_treasures/screens/splash_screen.dart';
import 'package:hidden_treasures/screens/onboarding_screen.dart';
import 'package:hidden_treasures/screens/home_screen.dart';
import 'package:hidden_treasures/screens/bottomNavPages/map_screen.dart';
import 'package:hidden_treasures/screens/signup_screen.dart';
import 'package:hidden_treasures/screens/settings_screen.dart';
import 'package:hidden_treasures/screens/logout_screen.dart';
import 'package:hidden_treasures/screens/login_screen.dart';
import 'package:hidden_treasures/screens/help_center_screen.dart';
import 'package:hidden_treasures/screens/email_verification_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/onboarding': (context) => const OnboardingScreen(),
        '/home': (context) => const HomeScreen(),
        '/map': (context) => const MapScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/notifications': (context) => const NotficationsScreen(),
        '/myaccount': (context) => const MyAccountScreen(),
        '/logout': (context) => const LogOutScreen(),
        '/login': (context) => const LoginScreen(),
        '/email-verification': (context) => const EmailVerificationScreen(),
        '/helpcenter': (context) => const HelpCenterScreen(),
        '/restaurant': (context) => const RestaurantScreen(),
        '/hotel': (context) => const HotelScreen(),
        '/event': (context) => const EventScreen(),
        '/carrental': (context) => const CarrentalScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/favourites': (context) => const FavouritsScreen(),
        '/chat': (context) => const ChatScreen(),
      },
    );
  }
}
