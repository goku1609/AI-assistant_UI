// import 'package:flutter/material.dart';
// import 'package:profiler/presentation/widgets/no_internet_widget.dart';
// import 'package:provider/provider.dart';
// import 'internet_provider.dart';
// import 'no_internet_widget.dart';
//
// class AppWrapper extends StatelessWidget {
//   final Widget child;
//
//   const AppWrapper({super.key, required this.child});
//
//   @override
//   Widget build(BuildContext context) {
//     final internet = context.watch<InternetProvider>();
//
//     return Stack(
//       children: [
//         child, // Your full app (navigation, screens, everything)
//
//         // 🚫 Block entire app when no internet
//         if (!internet.hasInternet)
//           Container(
//             color: Colors.black.withOpacity(0.7),
//             child: const NoInternetScreen(child: null,),
//           ),
//       ],
//     );
//   }
// }
