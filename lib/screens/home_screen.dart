import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons_plus/flutter_icons_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hidden_treasures/componets/componets.dart';
import 'package:hidden_treasures/constants/app_colors.dart';
import 'package:hidden_treasures/models/hotel_model.dart';
import 'package:hidden_treasures/models/user_model.dart';
import 'package:hidden_treasures/screens/new_pf_Screen.dart';
import 'package:hidden_treasures/screens/notfications_screen.dart';
import 'package:hidden_treasures/screens/bottomNavPages/profile_screen.dart';
import 'package:hidden_treasures/screens/bottomNavPages/chats/chat_screen.dart';
import 'package:hidden_treasures/screens/bottomNavPages/fav_screen.dart';
import 'package:hidden_treasures/screens/bottomNavPages/map_screen.dart';
import 'package:hidden_treasures/screens/car/carRental_screen.dart';
import 'package:hidden_treasures/screens/event/event_screen.dart';
import 'package:hidden_treasures/screens/hotel/hotel_details_screen.dart';
import 'package:hidden_treasures/screens/hotel/hotel_screen.dart';
import 'package:hidden_treasures/screens/restaurant/restaurant_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserModel user = UserModel.users.first;

  int _tabIndex = 2;
  int? _topBarIndex;

  int get tabIndex => _tabIndex;
  int? get topIndex => _topBarIndex;

  set tabIndex(int v) {
    _tabIndex = v;
    _topBarIndex = v;
    setState(() {});
  }

  late PageController pageController;

  late final List<Widget> pages = [
    const MapScreen(),
    const ChatScreen(),
    _buildHomePage(),
    const FavouritsScreen(),
    const newProfileScreen(),
  ];

  late final List<Widget> topBarPages = [
    const HotelScreen(),
    const RestaurantScreen(),
    const EventScreen(),
    const CarrentalScreen(),
  ];

  int selectedCategory = -1; // -1 means none selected

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: _tabIndex);
  }

  Widget _buildHomePage() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          const SizedBox(height: 30),
          ListTile(
            leading: CircleAvatar(backgroundImage: user.image, radius: 35),
            title: Text(
              "Hi, ${user.userName}",
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: const Text(
              "Good Afternoon ",
              style: TextStyle(color: AppColors.textSecondary),
            ),
            trailing: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NotficationsScreen(),
                  ),
                );
              },
              icon: const Icon(
                Icons.notifications,
                color: AppColors.buttonPrimary,
              ),
            ),
          ),
          const SizedBox(height: 10),

          //Text
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2),
            child: Text(
              "Let's Explore Cities and \nplaces",
              style: TextStyle(
                fontSize: 26.0,
                height: 1.5,
                color: Color.fromRGBO(33, 45, 82, 1),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          // search bar
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Container(
              height: 59.0,
              decoration: BoxDecoration(
                color: Color.fromRGBO(251, 251, 251, 1),
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: EdgeInsets.only(left: 16.0, right: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search for Events,Hotels...",
                        hintStyle: GoogleFonts.inter(
                          color: Color.fromRGBO(163, 171, 195, 1),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 50.0,
                    width: 50.0,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Icon(Icons.search, color: Colors.orange),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 15),
          Container(height: 1, width: double.infinity, color: Colors.black),
          const SizedBox(height: 10),
          const Align(
            alignment: Alignment.centerLeft,
            child: Center(
              child: Text(
                "Categories",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: AppColors.secondary,
                ),
              ),
            ),
          ),
          const SizedBox(height: 5),

          // Categories Row
          SizedBox(
            height: 60,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              children: [
                _buildCategory(
                  index: 0,
                  icon: Icons.hotel,
                  label: "Hotels",
                  page: const HotelScreen(),
                ),
                const SizedBox(width: 10),
                _buildCategory(
                  index: 1,
                  icon: Icons.restaurant_rounded,
                  label: "Restaurants",
                  page: const RestaurantScreen(),
                ),
                const SizedBox(width: 10),
                _buildCategory(
                  index: 2,
                  icon: Icons.event,
                  label: "Events",
                  page: const EventScreen(),
                ),
                const SizedBox(width: 10),
                _buildCategory(
                  index: 3,
                  icon: Icons.car_rental,
                  label: "CarRentals",
                  page: const CarrentalScreen(),
                ),
              ],
            ),
          ),

          const SizedBox(height: 15),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.secondary,
            ),
            padding: const EdgeInsets.all(10),
            child: const Center(
              child: Text(
                "Trending Now",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),

          // Featured Hotels Section
          SizedBox(
            height: 280,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              itemCount: featuredHotels.length,
              itemBuilder: (BuildContext context, int index) {
                Hotel hotel = featuredHotels[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HotelDetailsScreen(hotel: hotel),
                      ),
                    );
                  },
                  child: FeaturedHotelCard(
                    hotel: hotel,
                    onFavoritePressed: () {
                      setState(() {
                        hotel.isFavorite = !hotel.isFavorite;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            hotel.isFavorite
                                ? 'Added ${hotel.name} to favorites'
                                : 'Removed ${hotel.name} from favorites',
                          ),
                          backgroundColor: hotel.isFavorite
                              ? AppColors.favorite
                              : AppColors.textSecondary,
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategory({
    required int index,
    required IconData icon,
    required String label,
    required Widget page,
  }) {
    bool isSelected = selectedCategory == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = index;
        });
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.orange : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? Colors.white : Colors.black),
            const SizedBox(width: 5),
            Text(
              label,
              style: TextStyle(color: isSelected ? Colors.white : Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: pages,
      ),
      bottomNavigationBar: CircleNavBar(
        activeIcons: const [
          Icon(Icons.map, color: AppColors.background),
          Icon(Icons.chat, color: AppColors.background),
          Icon(Icons.home, color: AppColors.background),
          Icon(Icons.favorite, color: AppColors.background),
          Icon(Icons.person, color: AppColors.background),
        ],
        inactiveIcons: const [
          Icon(Icons.map, color: AppColors.background),
          Icon(Icons.chat, color: AppColors.background),
          Icon(Icons.home, color: AppColors.background),
          Icon(Icons.favorite_border, color: AppColors.background),
          Icon(Icons.person_outline, color: AppColors.background),
        ],
        height: 60,
        circleWidth: 55,
        color: AppColors.secondary,
        activeIndex: tabIndex,
        onTap: (index) {
          tabIndex = index;
          pageController.jumpToPage(index);
        },
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
        cornerRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
          bottomRight: Radius.circular(24),
          bottomLeft: Radius.circular(24),
        ),
        shadowColor: AppColors.backgroundDark,
      ),
    );
  }
}
