import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:hidden_treasures/componets/componets.dart';
import 'package:hidden_treasures/constants/app_colors.dart';
import 'package:hidden_treasures/models/hotel_model.dart';
import 'package:hidden_treasures/models/user_model.dart';
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
    const ProfileScreen(),
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
            leading: CircleAvatar(backgroundImage: user.image, radius: 30),
            title: Text(
              "Hi, ${user.userName}",
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 17,
              ),
            ),
            subtitle: const Text(
              "Good Afternoon ",
              style: TextStyle(color: AppColors.textSecondary),
            ),
            trailing: IconButton(
              onPressed: () {
                // TODO: Navigate to notifications screen
              },
              icon: const Icon(
                Icons.notifications,
                color: AppColors.buttonPrimary,
              ),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              filled: true,
              fillColor: AppColors.borderLight,
              hintText: "Search",
              hintStyle: const TextStyle(
                color: AppColors.textLight,
                fontSize: 12,
              ),
              prefixIcon: const Icon(
                Icons.search,
                color: AppColors.textLight,
                size: 25,
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  // TODO: Add filter action
                },
                icon: const Icon(Icons.filter_list_sharp),
              ),
            ),
          ),
          const SizedBox(height: 25),
          Container(height: 1, width: double.infinity, color: Colors.black),
          const SizedBox(height: 10),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Categories",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: AppColors.accent,
              ),
            ),
          ),
          const SizedBox(height: 5),

          // Categories Row
          SizedBox(
            height: 60, // give fixed height for the horizontal list
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
              borderRadius: BorderRadius.circular(25),
              color: AppColors.secondary,
            ),
            padding: const EdgeInsets.all(10),
            child: const Center(
              child: Text(
                "Trending Now",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 25,
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
