import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool showBack;
  final VoidCallback? onBackPress;
  final List<Widget>? actions;
  final Color backgroundColor;

  const CustomAppBar({
    super.key,
    this.title,
    this.showBack = false,
    this.onBackPress,
    this.actions,
    this.backgroundColor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: 0,
      centerTitle: true,

      automaticallyImplyLeading: false,

      // ================= BACK BUTTON =================
      leading: showBack
          ? GestureDetector(
        onTap: onBackPress ??
                () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            },
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      )
          : null,

      leadingWidth: showBack ? 60 : 0,

      // ================= TITLE =================
      title: title != null
          ? Text(
        title!,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
      )
          : null,

      // ================= ACTIONS =================
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}