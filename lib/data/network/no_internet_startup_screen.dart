import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../../main.dart';

class NoInternetStartupScreen extends StatefulWidget {
  const NoInternetStartupScreen({super.key});

  @override
  State<NoInternetStartupScreen> createState() =>
      _NoInternetStartupScreenState();
}

class _NoInternetStartupScreenState extends State<NoInternetStartupScreen> {
  bool isChecking = false;

  Future<void> retry() async {
    setState(() => isChecking = true);

    final result = await Connectivity().checkConnectivity();

    if (result != ConnectivityResult.none) {
      // Restart app UI
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const RestartApp(),
        ),
      );
    } else {
      setState(() => isChecking = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.wifi_off, size: 60, color: Colors.grey.shade400),
              const SizedBox(height: 20),
              const Text(
                "No Internet",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Text(
                "Turn on internet to continue",
                style: TextStyle(color: Colors.grey.shade600),
              ),
              const SizedBox(height: 24),
              isChecking
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: retry,
                      child: const Text("Retry"),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class RestartApp extends StatelessWidget {
  const RestartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const WardrobeApp();
  }
}
