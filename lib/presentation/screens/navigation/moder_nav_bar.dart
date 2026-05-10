import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

typedef OnTabChangeCallback = void Function(int index);
typedef OnCameraCallback = void Function();

class NavigationItem {
  final IconData icon;
  final String label;

  NavigationItem({
    required this.icon,
    required this.label,
  });
}

class ModernNavigationBar extends StatelessWidget {
  const ModernNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTabChange,
    required this.onCameraPressed,
    required this.height,
  });

  final int currentIndex;
  final OnTabChangeCallback onTabChange;
  final OnCameraCallback onCameraPressed;
  final double height;

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final iconSize = w * 0.075;

    final List<NavigationItem> items = [
      NavigationItem(icon: Icons.home_outlined, label: "Home"),      // fixed: use IconData
      NavigationItem(icon: Icons.chat_bubble_outline, label: "Chat"), // fixed
      NavigationItem(icon:  Icons.door_sliding_outlined, label: "Wardrobe"),
      NavigationItem(icon: Icons.photo_library_outlined, label: "Explore"),
    ];

    return Container(
      height: height,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _item(items[0], 0, iconSize),
          _item(items[1], 1, iconSize),
          _camera(iconSize),
          _item(items[2], 2, iconSize),
          _item(items[3], 3, iconSize),
        ],
      ),
    );
  }

  Widget _item(NavigationItem item, int index, double size) {
    final isActive = currentIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => onTabChange(index),
        child: Center(
          child: Icon(
            item.icon,        // now it's an IconData, not an Icon widget
            size: size,
            color: isActive ? Colors.black : Colors.grey.shade500,
            weight: isActive ? 1000 : 600,
          ),
        ),
      ),
    );
  }

  Widget _camera(double size) {
    return GestureDetector(
      onTap: onCameraPressed,
      child: Container(
        width: size * 2.2,
        height: size * 2.2,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Icon(
          Icons.camera_alt_outlined,
          size: size * 0.9,
          color: Colors.black,
          weight: 900,
        ),
      ),
    );
  }
}