import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class InternetProvider extends ChangeNotifier {
  bool _hasInternet = true;

  bool get hasInternet => _hasInternet;

  late StreamSubscription<List<ConnectivityResult>> _subscription;

  InternetProvider() {
    _init();
  }

  void _init() async {
    final connectivity = Connectivity();

    // ✅ Listen to changes (NOW returns LIST)
    _subscription = connectivity.onConnectivityChanged.listen((results) {
      _updateStatus(results);
    });

    // ✅ Initial check
    final results = await connectivity.checkConnectivity();
    _updateStatus(results);
  }

  void _updateStatus(List<ConnectivityResult> results) {
    // If ANY network is available → true
    final hasConnection = results.any(
      (result) => result != ConnectivityResult.none,
    );

    if (hasConnection != _hasInternet) {
      _hasInternet = hasConnection;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
