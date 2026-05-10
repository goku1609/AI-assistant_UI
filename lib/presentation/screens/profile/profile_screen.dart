import 'package:flutter/material.dart';
import 'profile_sound_toggle.dart';

class ProfileScreen extends StatefulWidget {
  final VoidCallback onBackToHome;

  const ProfileScreen({
    super.key,
    required this.onBackToHome,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isSoundEnabled = true;

  void _handleEditProfile() {}
  void _handleHelpSupport() {}
  void _handlePoints() {}
  void _handleNotifications() {}
  void _handleAbout() {}
  void _handleLogout() {}

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFA8D8D8),

      // ================= APP BAR =================
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: widget.onBackToHome,
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: const Icon(Icons.arrow_back, color: Colors.black),
          ),
        ),
        leadingWidth: 60,
      ),

      // ================= BODY =================
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: w * 0.04),
          child: Column(
            children: [
              SizedBox(height: w * 0.05),

              _buildMenuSection(w),

              SizedBox(height: w * 0.05),

              ProfileSoundToggle(
                isEnabled: _isSoundEnabled,
                onToggle: (val) {
                  setState(() => _isSoundEnabled = val);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuSection(double w) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _MenuCard(
                icon: Icons.edit,
                title: "Edit Profile",
                onTap: _handleEditProfile,
              ),
            ),
            SizedBox(width: w * 0.04),
            Expanded(
              child: _MenuCard(
                icon: Icons.help_outline,
                title: "Help & Support",
                onTap: _handleHelpSupport,
              ),
            ),
          ],
        ),

        SizedBox(height: w * 0.04),

        _FullWidthMenuCard(
          icon: Icons.star,
          title: "My Points",
          onTap: _handlePoints,
        ),

        SizedBox(height: w * 0.03),

        _FullWidthMenuCard(
          icon: Icons.notifications,
          title: "Notifications",
          onTap: _handleNotifications,
        ),

        SizedBox(height: w * 0.03),

        _FullWidthMenuCard(
          icon: Icons.info_outline,
          title: "About",
          onTap: _handleAbout,
        ),

        SizedBox(height: w * 0.03),

        _FullWidthMenuCard(
          icon: Icons.logout,
          title: "Logout",
          isDestructive: true,
          onTap: _handleLogout,
        ),
      ],
    );
  }
}

// ================= SMALL CARD =================
class _MenuCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _MenuCard({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: w * 0.06),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Icon(icon, size: w * 0.08),
            SizedBox(height: w * 0.02),
            Text(
              title,
              style: TextStyle(
                fontSize: w * 0.035,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ================= FULL WIDTH CARD =================
class _FullWidthMenuCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool isDestructive;

  const _FullWidthMenuCard({
    required this.icon,
    required this.title,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: w * 0.04,
          vertical: w * 0.045,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isDestructive ? Colors.red : Colors.black87,
            ),
            SizedBox(width: w * 0.04),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: w * 0.04,
                  fontWeight: FontWeight.w600,
                  color: isDestructive ? Colors.red : Colors.black87,
                ),
              ),
            ),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}