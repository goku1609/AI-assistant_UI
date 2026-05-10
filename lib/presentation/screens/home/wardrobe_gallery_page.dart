import 'package:Kaivon/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

class WardrobeGalleryPage extends StatelessWidget {
  const WardrobeGalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.shade200,

      appBar: AppBar(
        elevation: 0,
        title:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Create your look",
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 4),
            Text(
              "Style Studio",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w800,
                color: Colors.black,
              ),
            ),
          ],
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(height: 10),

              // ================= RECENT CREATIONS =================
              const Text(
                "Recent Creations",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 10),

              SizedBox(
                height: 120,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    _RecentCard(title: "Street Fit", icon: Icons.style),
                    _RecentCard(title: "Party Look", icon: Icons.celebration),
                    _RecentCard(title: "Office Wear", icon: Icons.work_outline),
                    _RecentCard(title: "Vacation Fit", icon: Icons.flight_takeoff),
                    _RecentCard(title: "Date Night", icon: Icons.favorite_border),
                    _RecentCard(title: "Wedding", icon: Icons.emoji_people_outlined),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // ================= OCCASIONS =================
              const Text(
                "Occasions",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 10),

              GridView.count(
                crossAxisCount: 4,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.85,
                children: const [
                  _OccasionCard(icon: Icons.favorite_border, title: "Date"),
                  _OccasionCard(icon: Icons.celebration_outlined, title: "Party"),
                  _OccasionCard(icon: Icons.groups_outlined, title: "Meeting"),
                  _OccasionCard(icon: Icons.volunteer_activism_outlined, title: "Wedding"),
                  _OccasionCard(icon: Icons.dinner_dining, title: "Dinner"),
                  _OccasionCard(icon: Icons.flight_takeoff, title: "Vacation"),
                  _OccasionCard(icon: Icons.work_outline, title: "Office"),
                ],
              ),

              const SizedBox(height: 20),

              // ================= WARDROBE =================
              const Text(
                "Your Wardrobe",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 10),

              const _FilterChips(),

              const SizedBox(height: 10),

              GridView.builder(
                itemCount: 6,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        "assets/clothes/blazer.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}




class _RecentCard extends StatelessWidget {
  final String title;
  final IconData icon;

  const _RecentCard({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 28, color: Colors.black87),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _OccasionCard extends StatelessWidget {
  final IconData icon;
  final String title;

  const _OccasionCard({
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 26, color: Colors.black87),
          const SizedBox(height: 6),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterChips extends StatelessWidget {
  const _FilterChips();

  @override
  Widget build(BuildContext context) {
    final filters = ["All", "Topwear", "Bottomwear", "Casual", "Party"];

    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(right: 8),
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(filters[index]),
            ),
          );
        },
      ),
    );
  }
}