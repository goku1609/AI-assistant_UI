import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/network/internet_provider.dart';

class NoInternetScreen extends StatelessWidget {
  final Widget? child;

  const NoInternetScreen({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    final hasInternet = context.watch<InternetProvider>().hasInternet;

    if (hasInternet) {
      return child ?? const SizedBox(); // fallback
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// 🌐 Icon
              Icon(
                Icons.wifi_off_rounded,
                size: 60,
                color: Colors.grey.shade400,
              ),

              const SizedBox(height: 20),

              /// Title
              const Text(
                "No Internet",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 8),

              /// Subtitle
              Text(
                "Please check your connection",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class NoInternetApp extends StatelessWidget {
  const NoInternetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NoInternetScreen(
        child: null,
      ),
    );
  }
}
