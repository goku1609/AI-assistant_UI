import 'package:Kaivon/config/theme/app_colors.dart';
import 'package:Kaivon/presentation/screens/auth/reset_password.dart';
import 'package:Kaivon/presentation/screens/auth/signup_screen.dart';
import 'package:Kaivon/presentation/screens/home/home_screen.dart';
import 'package:Kaivon/presentation/screens/navigation/main_navigation.dart';
import 'package:flutter/material.dart';

import 'auth_widget.dart';
import 'otp_screen.dart';

/*
  PIXEL-ACCURATE AUTH UI (WELCOME + LOGIN)
  - Fully dynamic sizing via LayoutBuilder
  - No MediaQuery
  - Modular, production-ready
  - Reusable components
*/

/* ===================== ROOT WRAPPER ===================== */

class AuthContainer extends StatelessWidget {
  final Widget child;

  const AuthContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final h = constraints.maxHeight;

        return Scaffold(
          body: Center(
            child: Container(
              width: w,
              height: h,
              color: AppColors.background,
              child: child,
            ),
          ),
        );
      },
    );
  }
}



/* ===================== LOGIN SCREEN ===================== */
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();

  void _sendOtp() {
    final phone = _phoneController.text.trim();

    if (phone.isEmpty || phone.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enter valid phone number")),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => OtpScreen(phone: phone, flow: OtpFlow.signup,),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      // backgroundColor: AppColors.background,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // 🔹 Title
              const Text(
                "Welcome",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                "Enter your phone number to continue",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 32),

              // 🔹 Phone Input
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Phone number",
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // 🔹 Send OTP Button
              LoginButton(height: h, width: w,nextScreen: const OtpScreen(phone: "phone", flow: OtpFlow.signup), text: 'Next',),
            ],
          ),
        ),
      ),
    );
  }
}


class LoginButton extends StatelessWidget {
  final double width;
  final double height;
  final String text;
  final Widget nextScreen;

  const LoginButton({
    super.key,
    required this.width,
    required this.height,
    required this.text,
    required this.nextScreen,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => nextScreen, // ✅ FIXED
        ),
      );
    },
        child:
        Container(
          width: double.infinity,
          height: height * 0.07,
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(width * 0.03),
          ),
          alignment: Alignment.center,

            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: width * 0.05,
              ),
            ),
          ),
        );
  }
}