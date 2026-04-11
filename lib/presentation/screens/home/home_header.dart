import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../config/theme/app_colors.dart';
import '../../../config/theme/app_dimensions.dart';
import '../../../config/theme/app_theme.dart';
import '../../widgets/ip_startup_info_service.dart';
import '../startUp/CalenderPage.dart';
import '../startUp/StartUpInfo.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.paddingL),
      child: SizedBox(
        width: double.infinity, // ✅ forces full width
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Good Morning,",
              style: TextStyle(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 4),
            const Text(
              "Himanshu",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      Icons.auto_awesome,
      Icons.checkroom,
      Icons.menu_book,
      Icons.fitness_center,
      Icons.content_cut,
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.map((icon) {
          return Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppDimensions.radiusCard),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Icon(icon, color: AppColors.iconColor),
          );
        }).toList(),
      ),
    );
  }
}

class SearchBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),

        // 🔥 BORDER
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1,
        ),

        // 🔥 SHADOW (floating effect)
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: Colors.grey.shade600),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search outfits...",
                border: InputBorder.none,
                hintStyle: TextStyle(
                  color: Colors.grey.shade500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DateCard extends StatelessWidget {
  const DateCard({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now(); // ✅ always current

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const CalendarPage()),
        );
      },
      child: Container(
        height: 120,
        width: 120,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// Top text → Wed Sep
            Text(
              "${_dayName(now.weekday)} ${_monthName(now.month)}",
              style: TextStyle(
                fontSize: 30,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),

            const Spacer(),

            /// Big date → 18
            Text(
              "${now.day}",
              style: const TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.bold,
                height: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _dayName(int day) {
    const days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
    return days[day - 1];
  }

  String _monthName(int month) {
    const months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ];
    return months[month - 1];
  }
}

class DataCard extends StatelessWidget {
  const DataCard({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 120,
        width: 120,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),

        // 👇 IMPORTANT FIX
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: 90, // prevents collapse
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// Top text
                Text(
                  "Streak Continuing for ",
                  style: TextStyle(
                    fontSize: 20, // 👈 reduce slightly
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 8),

                /// Big number
                Text(
                  "${now.day} Days",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 32, // 👈 responsive
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OutfitCard extends StatelessWidget {
  const OutfitCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(28),
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // 🔥 Mannequin Image
            AspectRatio(
              aspectRatio: 5 / 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Image.asset(
                  'assets/images/dummy.webp',
                  fit: BoxFit.contain,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // 🔥 Bottom Section
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              decoration: const BoxDecoration(
                color: Color(0xFFEAEAEA),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(28),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Text
                  const Text(
                    "Today's Outfit",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),

                  // Icon Button
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          barrierColor: Colors.transparent,
                          // no dark background
                          builder: (context) {
                            return Stack(
                              children: [
                                // Position popup near button (center-right style)
                                Positioned(
                                  top: 200, // adjust as needed
                                  right: 20, // adjust as needed
                                  child: Material(
                                    color: Colors.transparent,
                                    child: Container(
                                      width: 260,
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(14),
                                        boxShadow: const [
                                          BoxShadow(
                                            blurRadius: 10,
                                            color: Colors.black26,
                                          )
                                        ],
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Header
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                "Outfit Info",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () =>
                                                    Navigator.pop(context),
                                                child: const Icon(Icons.close,
                                                    size: 18),
                                              ),
                                            ],
                                          ),

                                          const SizedBox(height: 10),

                                          const Text(
                                              "👕 Topwear: Black Hoodie"),
                                          const Text(
                                              "👖 Bottomwear: Cargo Pants"),

                                          const SizedBox(height: 10),
                                          const Divider(),

                                          const Text(
                                            "✨ Accessories",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 6),

                                          const Text("• Watch"),
                                          const Text("• Sneakers"),
                                          const Text("• Cap"),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: const FaIcon(FontAwesomeIcons.message),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
