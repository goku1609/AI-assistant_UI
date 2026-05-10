import 'package:Kaivon/presentation/screens/home/liked_outfits.dart';
import 'package:Kaivon/presentation/screens/home/recommendation_screen.dart';
import 'package:Kaivon/presentation/screens/payment/payment_screen.dart';
import 'package:Kaivon/presentation/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'CalenderPage.dart';

/// =======================================================
/// HOME THEME CONFIG
/// =======================================================

class HomeTheme {
  static const Color background = Color(0xFFE9E7FF);
  static const Color card = Color(0xFFF7F6FF);
  static const Color primary = Color(0xFF7C78F2);
  static const Color textDark = Color(0xFF1F1F39);
  static const Color textLight = Color(0xFF8B8BA7);
  static const Color white = Colors.white;

  static BorderRadius cardRadius = BorderRadius.circular(26);
}

/// =======================================================
/// REUSABLE SECTION TITLE
/// =======================================================

class HomeSectionTitle extends StatelessWidget {
  final String title;
  final String? actionText;
  final VoidCallback? onTap;

  const HomeSectionTitle({
    super.key,
    required this.title,
    this.actionText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: HomeTheme.textDark,
            ),
          ),

          if (actionText != null)
            GestureDetector(
              onTap: onTap,
              child: Text(
                actionText!,
                style: const TextStyle(
                  fontSize: 15,
                  color: HomeTheme.textLight,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// =======================================================
/// MAIN HEADER
/// =======================================================

class HomeHeader extends StatelessWidget {
  final VoidCallback onOpenProfile;

  const HomeHeader({
    super.key,
    required this.onOpenProfile,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 24, 22, 10),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 26,
            backgroundImage: AssetImage(
              'assets/images/mannequin.png',
            ),
          ),

          const SizedBox(width: 14),

          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hey, Himanshu",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 22,
                    color: HomeTheme.textDark,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Start today's styling.",
                  style: TextStyle(
                    fontSize: 16,
                    color: HomeTheme.textLight,
                  ),
                ),
              ],
            ),
          ),

          _headerButton(
            icon: Icons.notifications_none_rounded,
            onTap: () {},
          ),

          const SizedBox(width: 12),

          _headerButton(
            icon: Icons.person,
            onTap: onOpenProfile,
          ),
        ],
      ),
    );
  }

  static Widget _headerButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52,
        width: 52,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFFF2F3F5), // ✅ round background added
        ),
        child: Icon(
          icon,
          color: HomeTheme.textDark,
        ),
      ),
    );
  }
}

/// =======================================================
/// REUSABLE ACTION CARD
/// =======================================================

class ActionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const ActionCard({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 135,
          padding: const EdgeInsets.all(18),

          decoration: BoxDecoration(
            color: HomeTheme.card,
            borderRadius: HomeTheme.cardRadius,
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 42,
                width: 42,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 20,
                  color: HomeTheme.primary,
                ),
              ),

              const Spacer(),

              Text(
                title,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: HomeTheme.textDark,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// =======================================================
/// CATEGORY SECTION
/// =======================================================
class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});
  Widget squareCard({
    required String title,
    required String count,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 120,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// TOP ROW
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Expanded(
                    child: Text(
                      title,
                      textAlign: TextAlign.left,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),

              const Spacer(),

              /// CENTER NUMBER (SAFE)
              Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    count,
                    style: const TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget streakCard() {
    return Expanded(
      child: GestureDetector(
        onTap: () {},
        child: Container(
          height: 120,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E2E),
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Streak",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 13,
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "12 Days",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        height: 40,
                        width: 40,
                        child: CircularProgressIndicator(
                          value: 0.65,
                          strokeWidth: 4,
                          backgroundColor: Colors.white24,
                          valueColor:
                          const AlwaysStoppedAnimation(Colors.orange),
                        ),
                      ),
                      const Icon(
                        Icons.local_fire_department,
                        color: Colors.orange,
                        size: 18,
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget coinsCard() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(top: 14),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Coins",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),

            const SizedBox(height: 6),

            const Text(
              "1,250",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: 0.7,
                minHeight: 10,
                backgroundColor: Colors.grey.shade200,
                valueColor:
                const AlwaysStoppedAnimation(Color(0xFF6C63FF)),
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              "70% to next reward",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Column(
        children: [
          Row(
            children: [
              squareCard(
                title: "Outfits",
                count: "24",
                icon: FontAwesomeIcons.shirt,
                onTap: () {},
              ),
              const SizedBox(width: 14),
              streakCard(),
            ],
          ),

          const SizedBox(height: 14),

          Row(
            children: [
              squareCard(
                title: "Saved",
                count: "18",
                icon: FontAwesomeIcons.bookmark,
                onTap: () {},
              ),
              const SizedBox(width: 14),
              squareCard(
                title: "Wardrobe",
                count: "56",
                icon: FontAwesomeIcons.images,
                onTap: () {},
              ),
            ],
          ),

          coinsCard(),
        ],
      ),
    );
  }
}

/// =======================================================
/// DATE CARD
/// =======================================================

/// =======================================================
/// HOME CARD (REPLACES DATE + TRIP CARD)
/// =======================================================

class PlannerCard extends StatelessWidget {
  const PlannerCard({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),

      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const UnifiedCalendarPage(),
            ),
          );
        },

        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(width * 0.05),

          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF7C78F2),
                Color(0xFF9B96FF),
              ],
            ),
            borderRadius: BorderRadius.circular(30),
          ),

          child: Row(
            children: [
              /// ICON
              Container(
                height: width * 0.18,
                width: width * 0.18,

                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),

                child: Icon(
                  Icons.calendar_month_rounded,
                  color: Colors.white,
                  size: width * 0.085,
                ),
              ),

              SizedBox(width: width * 0.045),

              /// CONTENT
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Planner",
                      style: TextStyle(
                        fontSize: width * 0.06,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                    SizedBox(height: width * 0.015),

                    Text(
                      "Plan your trips, events & outfits.",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: width * 0.035,
                        color: Colors.white.withOpacity(0.85),
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),

              Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white,
                size: width * 0.045,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// =======================================================
/// OUTFIT CARD
/// =======================================================

class OutfitCard extends StatefulWidget {
  const OutfitCard({super.key});

  @override
  State<OutfitCard> createState() => _OutfitCardState();
}

class _OutfitCardState extends State<OutfitCard> {
  bool showActions = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 0, 22, 30),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HomeSectionTitle(
            title: "Today's Outfit",
          ),

          const SizedBox(height: 18),

          GestureDetector(
            onTap: () {
              setState(() {
                showActions = !showActions;
              });
            },

            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32),
              ),

              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18),

                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: Image.asset(
                            'assets/images/mannequin.png',
                            height: 380,
                            width: double.infinity,
                            fit: BoxFit.contain,
                          ),
                        ),

                        const SizedBox(height: 16),

                      ],
                    ),
                  ),

                  if (showActions)
                    Positioned(
                      top: 18,
                      right: 18,
                      child: Row(
                        children: [
                          _actionButton(
                            Icons.visibility_outlined,
                                () {},
                          ),

                          const SizedBox(width: 10),

                          _actionButton(
                            Icons.bookmark_border,
                                () {},
                          ),
                        ],
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

  Widget _actionButton(
      IconData icon,
      VoidCallback onTap,
      ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 46,
        width: 46,

        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),

        child: Icon(
          icon,
          color: HomeTheme.textDark,
        ),
      ),
    );
  }
}