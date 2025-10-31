import 'package:flutter/material.dart';
import 'package:hidden_treasures/screens/login_screen.dart';
import '../models/onboarding_model.dart';
import '../widgets/onboarding_page.dart';
import '../widgets/page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final List<OnboardingModel> _pages = OnboardingModel.getOnboardingPages();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Navigate to main app (you can replace this with your home screen)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _skipToEnd() {
    _pageController.animateToPage(
      _pages.length - 1,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // PageView with onboarding pages
          PageView.builder(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            itemCount: _pages.length,
            itemBuilder: (context, index) {
              return OnboardingPage(model: _pages[index]);
            },
          ),

          // Top navigation (Skip button)
          Positioned(
            top: 50,
            right: 20,
            child: _currentPage < _pages.length - 1
                ? TextButton(
                    onPressed: _skipToEnd,
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        color: _pages[_currentPage].primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                : SizedBox(),
          ),

          // Bottom navigation
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Previous button
                  _currentPage > 0
                      ? TextButton(
                          onPressed: _previousPage,
                          child: Text(
                            'Previous',
                            style: TextStyle(
                              color: _pages[_currentPage].primaryColor,
                              fontSize: 16,
                            ),
                          ),
                        )
                      : SizedBox(width: 80),

                  // Page indicator
                  PageIndicator(
                    currentPage: _currentPage,
                    pageCount: _pages.length,
                    color: _pages[_currentPage].primaryColor,
                  ),

                  // Next button
                  ElevatedButton(
                    onPressed: _nextPage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _pages[_currentPage].primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    child: Text(
                      _currentPage < _pages.length - 1 ? 'Next' : 'Start',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
