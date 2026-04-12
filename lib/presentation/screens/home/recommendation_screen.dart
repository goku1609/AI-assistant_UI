import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

/* ================= MODEL ================= */

class ChatMessage {
  final String? text;
  final File? image;
  final bool isUser;

  ChatMessage({
    this.text,
    this.image,
    required this.isUser,
  });
}

/* ================= SCREEN ================= */

class GenerateScreen extends StatefulWidget {
  const GenerateScreen({super.key});

  @override
  State<GenerateScreen> createState() => _GenerateScreenState();
}

class _GenerateScreenState extends State<GenerateScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final ImagePicker _picker = ImagePicker();

  List<ChatMessage> messages = [];
  bool isLoading = false;

  File? _selectedImage;

  /* ================= THEME ================= */

  bool get isNight {
    final hour = DateTime.now().hour;
    return hour >= 18 || hour <= 6;
  }

  Color get bgColor =>
      isNight ? Colors.blueGrey.shade900 : Colors.orange.shade50;

  Color get botBubbleColor =>
      isNight ? Colors.blueGrey.shade800 : Colors.orange.shade100;

  Color get botTextColor =>
      isNight ? Colors.white : Colors.black87;

  Color get userBubbleColor =>
      isNight ? Colors.grey.shade700 : Colors.grey.shade300;

  Color get userTextColor =>
      isNight ? Colors.white : Colors.black87;

  Color get inputBg =>
      isNight ? Colors.blueGrey.shade800 : Colors.white;

  Color get sendBg =>
      isNight ? Colors.blueGrey.shade600 : Colors.orange.shade400;

  /* ================= IMAGE PICK ================= */

  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(
      source: source,
      imageQuality: 80,
    );

    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  void _showImagePicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
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

  /* ================= SEND MESSAGE ================= */

  Future<void> sendMessage() async {
    final text = _controller.text.trim();

    if (text.isEmpty && _selectedImage == null) return;

    setState(() {
      messages.add(ChatMessage(
        text: text.isNotEmpty ? text : null,
        image: _selectedImage,
        isUser: true,
      ));
      isLoading = true;
    });

    _controller.clear();
    _scrollToBottom();

    try {
      var request = http.MultipartRequest(
        "POST",
        Uri.parse("https://your-backend.com/chat"),
      );

      if (text.isNotEmpty) {
        request.fields["message"] = text;
      }

      if (_selectedImage != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            "image",
            _selectedImage!.path,
          ),
        );
      }

      final response = await request.send();
      final resBody = await response.stream.bytesToString();

      String reply = "No response";

      if (response.statusCode == 200) {
        final data = jsonDecode(resBody);
        reply = data["reply"] ?? "No reply";
      }

      setState(() {
        messages.add(ChatMessage(
          text: reply,
          isUser: false,
        ));
      });
    } catch (_) {
      setState(() {
        messages.add(ChatMessage(
          text: "Something went wrong",
          isUser: false,
        ));
      });
    }

    setState(() {
      isLoading = false;
      _selectedImage = null;
    });

    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  /* ================= UI ================= */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Chat"),
      ),

      body: Column(
        children: [
          /* ================= CHAT ================= */

          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(12),
              itemCount: messages.length,
              itemBuilder: (context, i) {
                final msg = messages[i];
                final isUser = msg.isUser;

                return Align(
                  alignment: isUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.all(10),
                    constraints: const BoxConstraints(maxWidth: 280),
                    decoration: BoxDecoration(
                      color: isUser
                          ? userBubbleColor
                          : botBubbleColor,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (msg.image != null)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              msg.image!,
                              height: 150,
                              width: 150,
                              fit: BoxFit.cover,
                            ),
                          ),

                        if (msg.text != null)
                          Padding(
                            padding: EdgeInsets.only(
                                top: msg.image != null ? 8 : 0),
                            child: Text(
                              msg.text!,
                              style: TextStyle(
                                color: isUser
                                    ? userTextColor
                                    : botTextColor,
                                fontSize: 14,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          /* ================= TYPING ================= */

          if (isLoading)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(
                "typing...",
                style: TextStyle(
                  color: isNight
                      ? Colors.white54
                      : Colors.black45,
                  fontSize: 12,
                ),
              ),
            ),

          /* ================= INPUT ================= */

          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                /* IMAGE PREVIEW */
                if (_selectedImage != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            _selectedImage!,
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: -5,
                          right: -5,
                          child: GestureDetector(
                            onTap: () =>
                                setState(() => _selectedImage = null),
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.close,
                                size: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                /* INPUT ROW */
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 14),
                        decoration: BoxDecoration(
                          color: inputBg,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _controller,
                                style: const TextStyle(fontSize: 14),
                                decoration: const InputDecoration(
                                  hintText: "Type a message...",
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: _showImagePicker,
                              child: Icon(
                                Icons.image_outlined,
                                color: isNight
                                    ? Colors.white70
                                    : Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(width: 10),

                    GestureDetector(
                      onTap: sendMessage,
                      child: Container(
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(
                          color: sendBg,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.send,
                          color: isNight
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}