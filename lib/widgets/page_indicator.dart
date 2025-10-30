import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  final int currentPage;
  final int pageCount;
  final Color color;

  const PageIndicator({
    super.key,
    required this.currentPage,
    required this.pageCount,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        pageCount,
            (index) => _buildDot(index),
      ),
    );
  }

  Widget _buildDot(int index) {
    bool isActive = index == currentPage;

    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? color : color.withOpacity(0.3),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}