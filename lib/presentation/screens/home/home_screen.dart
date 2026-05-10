
/// ===============================================================
/// HOME SCREEN
/// ===============================================================
/// FLOW:
///
/// HOME SCREEN
///    ↓
/// PlannerWidget
///
/// IF NO EVENTS:
///    → show empty state
///    → show calendar button
///
/// IF EVENTS EXIST:
///    → show all planned cards
///    → show top-right floating button
///
/// BUTTON CLICK:
///    → opens UnifiedCalendarPage
///
/// AFTER EVENT CREATION:
///    → automatically refreshes
/// ===============================================================

/// ===============================================================
/// HOME SCREEN
/// ===============================================================
/// ONLY SHOWS:
/// - Planner icon button
/// - Navigates to PlannerPage
///
/// DO NOT PUT PLANNER WIDGET HERE
/// ===============================================================

import 'package:Kaivon/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../config/theme/app_dimensions.dart';
import '../../../data/network/internet_provider.dart';

import '../../widgets/weather.dart';
import '../profile/profile_screen.dart';
import '../startUp/skeleton.dart';

import 'CalenderPage.dart';
import 'home_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    Future.delayed(
      const Duration(seconds: 2),
          () {
        setState(() {
          isLoading = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    context.watch<InternetProvider>();

    return Scaffold(
      backgroundColor: AppColors.shade100,

      body: SafeArea(
        child: isLoading
            ? const SizedBox.expand(
          child: Skeleton(),
        )
            : SingleChildScrollView(
          child: Column(
            children: [
              /// HEADER
              HomeHeader(
                onOpenProfile: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProfileScreen(
                        onBackToHome: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),

              const OutfitCard(),
              const SizedBox(height: 30),
              /// WEATHER
              const WeatherWidget(),

              const SizedBox(height: 30),

              /// ===================================================
              /// PLANNER ICON BUTTON
              /// ===================================================

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal:
                  AppDimensions.paddingL,
                ),

                child: GestureDetector(
                  onTap: () async {
                    /// OPEN PLANNER PAGE
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                        const PlannerPage(),
                      ),
                    );

                    /// REFRESH HOME AFTER RETURN
                    setState(() {});
                  },

                  child: Container(
                    width: double.infinity,

                    padding:
                    const EdgeInsets.all(18),

                    decoration: BoxDecoration(
                      color:
                      const Color(0xFF6C63FF),

                      borderRadius:
                      BorderRadius.circular(
                        26,
                      ),
                    ),

                    child: Row(
                      children: [
                        Container(
                          height: 58,
                          width: 58,

                          decoration:
                          BoxDecoration(
                            color: Colors.white
                                .withOpacity(
                              0.15,
                            ),

                            borderRadius:
                            BorderRadius
                                .circular(
                              18,
                            ),
                          ),

                          child: const Icon(
                            Icons
                                .calendar_month_rounded,

                            color: Colors.white,
                            size: 30,
                          ),
                        ),

                        const SizedBox(width: 16),

                        const Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment
                                .start,

                            children: [
                              Text(
                                "Planner",

                                style: TextStyle(
                                  color:
                                  Colors.white,

                                  fontSize: 20,

                                  fontWeight:
                                  FontWeight
                                      .bold,
                                ),
                              ),

                              SizedBox(height: 4),

                              Text(
                                "Plan trips & events",

                                style: TextStyle(
                                  color:
                                  Colors.white70,

                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const Icon(
                          Icons.arrow_forward_ios,

                          color: Colors.white,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),
              const CategoriesSection(),
            ],
          ),
        ),
      ),
    );
  }
}