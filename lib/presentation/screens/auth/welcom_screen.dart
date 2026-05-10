/* ===================== WELCOME SCREEN ===================== */

import 'package:Kaivon/presentation/screens/auth/signup_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../config/theme/app_colors.dart';
import '../../notifications/notification.dart';
import 'auth_widget.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthContainer(
      child: Scaffold(
        backgroundColor: Colors.transparent, // ✅ IMPORTANT FIX

        body: LayoutBuilder(
          builder: (context, constraints) {
            final w = constraints.maxWidth;
            final h = constraints.maxHeight;

            return Stack(
              children: [

                // ✅ BASE FIX (removes teal leaks)
                // Container(color: Colors.white),

                TopContent(
                  height: h * 0.65,
                  width: w,
                  showText: true,
                ),

                Align(
                  alignment: Alignment.bottomCenter,
                  child: BottomWaveCard(height: h * 0.55),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: w * 0.08),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: h * 0.65),

                      Text(
                        'Welcome',
                        style: TextStyle(
                          fontSize: w * 0.08,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),

                      SizedBox(height: h * 0.015),

                      Text(
                        'Progress, Every Day \nBuilt for Better You',
                        style: TextStyle(
                          fontSize: w * 0.040,
                          color: Colors.black45,
                        ),
                      ),

                      const Spacer(),

                      Align(
                        alignment: Alignment.centerRight,
                        child: ContinueButton(onPressed: () {  },),
                      ),

                      SizedBox(height: h * 0.04),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}


class ContinueButton extends StatefulWidget {
  final double size;
  final VoidCallback onPressed;

  const ContinueButton({
    super.key,
    this.size = 60,
    required this.onPressed,
  });

  @override
  State<ContinueButton> createState() => _ContinueButtonState();
}

class _ContinueButtonState extends State<ContinueButton> {
  bool _loading = false;

  void _handlePress() {
    if (_loading) return;

    setState(() => _loading = true);

    // 🚀 1. START NOTIFICATIONS (NO AWAIT → NON BLOCKING)
    NotificationService().startAutoScheduler(
      title: "Outfit Ready",
      message: "Your outfit is ready 👕",
      intervalInMinutes: 2,
    );

    // 🚀 2. OPTIONAL: test notification (also non-blocking)
    NotificationService().showTestNotification();

    // 🚀 3. NAVIGATE IMMEDIATELY
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );

    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handlePress,
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black,
        ),
        child: _loading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Icon(Icons.arrow_forward, color: Colors.white),
      ),
    );
  }
}