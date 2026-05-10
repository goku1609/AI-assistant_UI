import 'package:flutter/material.dart';
import 'body_type.dart';
import 'package:Kaivon/presentation/screens/auth/login_screen.dart';

class GenderScreen extends StatefulWidget {
  const GenderScreen({super.key});

  @override
  State<GenderScreen> createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  String? selectedGender;

  void _handleGender(String gender) {
    setState(() {
      selectedGender = gender;
    });
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    final items = [
      "Man",
      "Woman",
      "Other",
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F7),

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: w * 0.06),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: w * 0.12),

              /// HEADER TEXT
              Text(
                "Tell us about yourself",
                style: TextStyle(
                  fontSize: w * 0.08,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              SizedBox(height: w * 0.02),

              Text(
                "Select your gender to continue",
                style: TextStyle(
                  fontSize: w * 0.04,
                  color: Colors.grey.shade600,
                ),
              ),

              SizedBox(height: w * 0.08),

              /// LIST (1 per row)
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final gender = items[index];
                    final isSelected = selectedGender == gender;

                    return GestureDetector(
                      onTap: () => _handleGender(gender),

                      child: Container(
                        margin: EdgeInsets.only(bottom: w * 0.04),

                        padding: EdgeInsets.symmetric(
                          vertical: w * 0.06,
                          horizontal: w * 0.04,
                        ),

                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),

                          border: Border.all(
                            color: isSelected
                                ? Colors.black
                                : Colors.transparent,
                            width: 2,
                          ),

                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),

                        child: Text(
                          gender,
                          style: TextStyle(
                            fontSize: w * 0.05,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              /// NEXT BUTTON
              LoginButton(
                height: h,
                width: w,
                nextScreen: const BodyType(),
                text: 'Next',
              ),

              SizedBox(height: w * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}