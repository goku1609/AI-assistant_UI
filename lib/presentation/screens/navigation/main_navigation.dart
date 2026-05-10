import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:Kaivon/config/theme/app_colors.dart';
import '../explorer/explorer.dart';
import '../home/home_screen.dart';
import '../home/recommendation_screen.dart';   // Make sure this file exists
import '../home/wardrobe_gallery_page.dart';
import 'moder_nav_bar.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

  late final List<Widget> _pages = [
    const HomeScreen(),
    const GenerateScreen(),          // Ensure GenerateScreen is defined
    const WardrobeGalleryPage(),
    const Explorer(),
  ];

  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(
      source: source,
      imageQuality: 80,
    );
    if (image == null) return;
    setState(() {
      _selectedImage = File(image.path);
    });
  }

  void _showImageSourcePicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt_outlined),
                title: const Text("Camera"),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_outlined),
                title: const Text("Gallery"),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F3F5),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: ModernNavigationBar(
        currentIndex: _currentIndex,
        onTabChange: (index) => setState(() => _currentIndex = index),
        onCameraPressed: _showImageSourcePicker,
        height: MediaQuery.of(context).size.width * 0.16,
      ),
    );
  }
}