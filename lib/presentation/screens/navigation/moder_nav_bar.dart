import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

typedef OnTabChangeCallback = void Function(int index);
typedef OnCameraCallback = void Function();

class ModernNavigationBar extends StatefulWidget {
  const ModernNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTabChange,
    required this.onCameraPressed,
    required this.height,
    required this.borderRadius,
    required this.elevation,
    this.backgroundColor = const Color(0xFFFFFFFF),
    this.activeColor = const Color(0xFFB3E5D8),
  });

  final int currentIndex;
  final OnTabChangeCallback onTabChange;
  final OnCameraCallback onCameraPressed;

  // ✅ NOW FULLY DYNAMIC (no defaults)
  final double height;
  final double borderRadius;
  final double elevation;

  final Color backgroundColor;
  final Color activeColor;

  @override
  State<ModernNavigationBar> createState() => _ModernNavigationBarState();
}

class _ModernNavigationBarState extends State<ModernNavigationBar>
    with SingleTickerProviderStateMixin {

  late AnimationController _animationController;

  late final List<NavigationItem> _items = [
    NavigationItem(
      icon: const HugeIcon(
        icon: HugeIcons.strokeRoundedHome01,
        color: Colors.white,
        strokeWidth: 2.5,
      ),
      label: 'Home',
    ),
    NavigationItem(
      icon: const HugeIcon(
        icon: HugeIcons.strokeRoundedChat,
        color: Colors.white,
        strokeWidth: 2.5,
      ),
      label: 'Dashboard',
    ),
    NavigationItem(
      icon: const HugeIcon(
        icon: HugeIcons.strokeRoundedHanger,
        color: Colors.white,
        strokeWidth: 2.5,
      ),
      label: 'Shop',
    ),
    NavigationItem(
      icon: const HugeIcon(
        icon: HugeIcons.strokeRoundedUser,
        color: Colors.white,
        strokeWidth: 2.5,
      ),
      label: 'Profile',
    ),
  ];

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    final iconSize = w * 0.06;

    return Container(
      height: widget.height,
      margin: EdgeInsets.symmetric(horizontal: w * 0.05),
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: widget.elevation,
            offset: Offset(0, widget.elevation / 2),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildItem(0, iconSize),
          _buildItem(1, iconSize),

          // camera center
          _buildCamera(iconSize),

          _buildItem(2, iconSize),
          _buildItem(3, iconSize),
        ],
      ),
    );
  }

  // ================= NAV ITEM =================
  Widget _buildItem(int index, double iconSize) {
    final isActive = widget.currentIndex == index;
    final item = _items[index];

    return Expanded(
      child: GestureDetector(
        onTap: () {
          widget.onTabChange(index);
          _animationController.forward(from: 0);
        },
        child: Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: isActive ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(25),
              boxShadow: isActive
                  ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ]
                  : [],
            ),
            child: SizedBox(
              width: iconSize,
              height: iconSize,
              child: HugeIcon(
                icon: (item.icon as HugeIcon).icon,
                color: isActive ? Colors.black : Colors.white,
                strokeWidth: 2.5,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ================= CAMERA =================
  Widget _buildCamera(double iconSize) {
    final size = iconSize * 2.4;

    return GestureDetector(
      onTap: widget.onCameraPressed,
      child: Container(
        width: size,
        height: size,
        margin: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.2),
              blurRadius: 10,
            ),
          ],
        ),
        child: Center(
          child: HugeIcon(
            icon: HugeIcons.strokeRoundedCamera01,
            color: Colors.black,
            size: size * 0.6,
            strokeWidth: 2.5,
          ),
        ),
      ),
    );
  }
}

// ================= MODEL =================
class NavigationItem {
  final Widget icon;
  final String label;

  NavigationItem({
    required this.icon,
    required this.label,
  });
}