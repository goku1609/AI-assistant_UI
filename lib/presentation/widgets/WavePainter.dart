// // lib/screens/home/widgets/home_header.dart
// import 'package:flutter/material.dart';
// import '../../../config/theme/app_colors.dart';
// import '../../../config/theme/app_dimensions.dart';
// import '../../../config/theme/app_theme.dart';
// import '../../widgets/ip_startup_info_service.dart';
// import '../startUp/StartUpInfo.dart';
//
// class HomeHeader extends StatefulWidget {
//   const HomeHeader({super.key});
//
//   @override
//   State<HomeHeader> createState() => _HomeHeaderState();
// }
//
// class _HomeHeaderState extends State<HomeHeader> {
//   final TextEditingController _searchController = TextEditingController();
//   bool _searchFocused = false;
//
//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: AppColors.surface,
//       padding: EdgeInsets.fromLTRB(
//         AppDimensions.paddingL,
//         AppDimensions.paddingM,
//         AppDimensions.paddingL,
//         AppDimensions.paddingL,
//       ),
//       child: Column(
//         children: [
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: const [
//                     Row(
//                       children: [
//                         Icon(Icons.auto_awesome,
//                             size: 14, color: AppColors.iconColor),
//                         SizedBox(width: 6),
//                         Text(
//                           'AI-POWERED STYLE',
//                           style: TextStyle(
//                             color: AppColors.textHint,
//                             fontSize: 11,
//                             fontWeight: FontWeight.w700,
//                             letterSpacing: 1.5,
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 8),
//                     Text(
//                       'Good Morning,',
//                       style: TextStyle(
//                         color: AppColors.textPrimary,
//                         fontSize: 24,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                     Text(
//                       'Himanshu',
//                       style: TextStyle(
//                         color: AppColors.textSecondary,
//                         fontSize: 24,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               IconButton(
//                 onPressed: () {},
//                 icon: Stack(
//                   children: const [
//                     Icon(Icons.notifications_none, color: AppColors.iconColor),
//                     Positioned(
//                       right: 0,
//                       top: 0,
//                       child: CircleAvatar(
//                           radius: 4, backgroundColor: AppColors.borderLight),
//                     ),
//                   ],
//                 ),
//               ),
//               const CircleAvatar(
//                 radius: 20,
//                 backgroundColor: AppColors.iconBg,
//                 child: Text(
//                   'H',
//                   style: TextStyle(
//                       color: AppColors.textSecondary,
//                       fontWeight: FontWeight.w700),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: AppDimensions.paddingM),
//           Focus(
//             onFocusChange: (value) => setState(() => _searchFocused = value),
//             child: Container(
//               padding: EdgeInsets.symmetric(
//                   horizontal: AppDimensions.paddingM, vertical: 2),
//               decoration: BoxDecoration(
//                 color: _searchFocused ? AppColors.surface : AppColors.iconBg,
//                 borderRadius:
//                 BorderRadius.circular(AppDimensions.borderRadiusButton),
//                 border: Border.all(
//                   color: _searchFocused
//                       ? AppColors.borderLight
//                       : Colors.transparent,
//                 ),
//                 boxShadow: _searchFocused
//                     ? [
//                   BoxShadow(
//                       color: AppColors.shadowLight,
//                       blurRadius: AppDimensions.blurRadiusSmall)
//                 ]
//                     : null,
//               ),
//               child: Row(
//                 children: [
//                   Icon(Icons.search, color: AppColors.iconColor),
//                   SizedBox(width: AppDimensions.paddingS),
//                   Expanded(
//                     child: TextField(
//                       controller: _searchController,
//                       style: TextStyle(
//                           color: AppColors.textPrimary,
//                           fontSize: AppDimensions.fontS),
//                       decoration: InputDecoration(
//                         hintText: 'Search styles, outfits, tips...',
//                         hintStyle: TextStyle(color: AppColors.textHint),
//                         border: InputBorder.none,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // Make the class public (no underscore)
// class CategoryItem {
//   final String id;
//   final String label;
//   final IconData icon;
//
//   const CategoryItem(
//       {required this.id, required this.label, required this.icon});
// }
//
// class CategoriesSection extends StatefulWidget {
//   const CategoriesSection({super.key});
//
//   @override
//   State<CategoriesSection> createState() => _CategoriesSectionState();
// }
//
// class _CategoriesSectionState extends State<CategoriesSection> {
//   // Now using public CategoryItem
//   final List<CategoryItem> _categories = const [
//     CategoryItem(
//         id: 'ai-stylist', label: 'AI Stylist', icon: Icons.auto_awesome),
//     CategoryItem(id: 'wardrobe', label: 'Wardrobe', icon: Icons.checkroom),
//     CategoryItem(
//         id: 'style-guide', label: 'Style Guide', icon: Icons.menu_book),
//     CategoryItem(id: 'fitness', label: 'Fitness', icon: Icons.fitness_center),
//     CategoryItem(id: 'grooming', label: 'Grooming', icon: Icons.content_cut),
//   ];
//
//   String? _selectedCategoryId;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: AppDimensions.paddingL),
//       child: Row(
//         children: _categories.map((item) {
//           final isSelected = _selectedCategoryId == item.id;
//           return Expanded(
//             child: InkWell(
//               onTap: () => setState(
//                       () => _selectedCategoryId = isSelected ? null : item.id),
//               child: Column(
//                 children: [
//                   Container(
//                     width: 52,
//                     height: 52,
//                     decoration: BoxDecoration(
//                       color: isSelected ? AppColors.iconBg : AppColors.surface,
//                       borderRadius:
//                       BorderRadius.circular(AppDimensions.borderRadiusCard),
//                       border: Border.all(color: AppColors.borderLight),
//                       boxShadow: [
//                         BoxShadow(
//                           color: AppColors.shadowLight,
//                           blurRadius: AppDimensions.blurRadiusSmall,
//                         ),
//                       ],
//                     ),
//                     child: Icon(item.icon,
//                         color: isSelected
//                             ? AppColors.textPrimary
//                             : AppColors.iconColor),
//                   ),
//                   SizedBox(height: AppDimensions.paddingS),
//                   Text(
//                     item.label,
//                     style: TextStyle(
//                       fontSize: AppDimensions.fontXS,
//                       color: isSelected
//                           ? AppColors.textPrimary
//                           : AppColors.textHint,
//                       fontWeight:
//                       isSelected ? FontWeight.w700 : FontWeight.w500,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }
// }
//
// class FeaturedBanner extends StatelessWidget {
//   const FeaturedBanner({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(
//           horizontal: AppDimensions.paddingL, vertical: AppDimensions.paddingS),
//       child: MinimalCard(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Row(
//               children: [
//                 Icon(Icons.auto_awesome, size: 12, color: AppColors.iconColor),
//                 SizedBox(width: 6),
//                 Text(
//                   "TODAY'S PICK",
//                   style: TextStyle(
//                     color: AppColors.textHint,
//                     fontSize: 10,
//                     letterSpacing: 1.5,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: AppDimensions.paddingS),
//             const Text(
//               'Your Style Score',
//               style: TextStyle(
//                 color: AppColors.textPrimary,
//                 fontSize: 20,
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//             SizedBox(height: AppDimensions.paddingXS),
//             const Text(
//               "AI analyzed your wardrobe - see what's trending",
//               style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
//             ),
//             SizedBox(height: AppDimensions.paddingM),
//             MinimalOutlineButton(
//               label: 'View Analysis',
//               icon: Icons.arrow_forward,
//               onPressed: () {},
//               isFilled: true,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class WeatherWidget extends StatefulWidget {
//   const WeatherWidget({super.key});
//
//   @override
//   State<WeatherWidget> createState() => _WeatherWidgetState();
// }
//
// class _WeatherWidgetState extends State<WeatherWidget> {
//   final IpStartupInfoService _service = IpStartupInfoService();
//   late Future<StartupInfo> _future;
//
//   @override
//   void initState() {
//     super.initState();
//     _future = _service.fetchStartupInfo();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<StartupInfo>(
//       future: _future,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Padding(
//             padding: EdgeInsets.all(16),
//             child: Center(child: CircularProgressIndicator()),
//           );
//         }
//         if (snapshot.hasError) {
//           return Padding(
//             padding: EdgeInsets.all(AppDimensions.paddingL),
//             child: MinimalCard(
//               child: Column(
//                 children: [
//                   Icon(Icons.error_outline, color: AppColors.textHint),
//                   SizedBox(height: AppDimensions.paddingS),
//                   Text('Could not load weather',
//                       style: TextStyle(color: AppColors.textSecondary)),
//                   SizedBox(height: AppDimensions.paddingM),
//                   MinimalOutlineButton(
//                     label: 'Retry',
//                     onPressed: () =>
//                         setState(() => _future = _service.fetchStartupInfo()),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         }
//         final info = snapshot.data!;
//         final hour = DateTime.now().hour;
//         final isDay = hour >= 6 && hour < 18;
//         final icon = isDay ? Icons.wb_sunny : Icons.nightlight_round;
//         final suggestion = _getOutfitSuggestion(info.temperature, isDay);
//
//         return Padding(
//           padding: EdgeInsets.symmetric(
//               horizontal: AppDimensions.paddingL,
//               vertical: AppDimensions.paddingS),
//           child: MinimalCard(
//             child: Row(
//               children: [
//                 Container(
//                   padding: EdgeInsets.all(AppDimensions.paddingS),
//                   decoration: BoxDecoration(
//                     color: AppColors.iconBg,
//                     borderRadius:
//                     BorderRadius.circular(AppDimensions.borderRadiusButton),
//                   ),
//                   child: Icon(icon, color: AppColors.iconColor, size: 28),
//                 ),
//                 SizedBox(width: AppDimensions.paddingM),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         '${info.city}, ${info.state}',
//                         style: const TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                           color: AppColors.textPrimary,
//                         ),
//                       ),
//                       SizedBox(height: AppDimensions.paddingXS),
//                       Text(
//                         '${info.temperature}°C • ${isDay ? 'Day' : 'Night'}',
//                         style: const TextStyle(
//                           fontSize: 14,
//                           color: AppColors.textSecondary,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   padding: EdgeInsets.symmetric(
//                       horizontal: AppDimensions.paddingM,
//                       vertical: AppDimensions.paddingS),
//                   decoration: BoxDecoration(
//                     color: AppColors.iconBg,
//                     borderRadius:
//                     BorderRadius.circular(AppDimensions.borderRadiusChip),
//                   ),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Icon(Icons.checkroom,
//                           size: 16, color: AppColors.iconColor),
//                       SizedBox(width: AppDimensions.paddingXS),
//                       Text(
//                         suggestion,
//                         style: TextStyle(
//                             color: AppColors.textSecondary, fontSize: 12),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   String _getOutfitSuggestion(String temperature, bool isDay) {
//     final temp = double.tryParse(temperature) ?? 25;
//     if (isDay) {
//       if (temp > 28) return 'Light & Breezy';
//       if (temp > 20) return 'Casual Comfort';
//       if (temp > 10) return 'Layer Up';
//       return 'Cozy & Warm';
//     } else {
//       if (temp > 22) return 'Evening Cool';
//       if (temp > 15) return 'Light Jacket';
//       return 'Bundle Up';
//     }
//   }
// }
//
// class PreBookingCard extends StatelessWidget {
//   const PreBookingCard({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(
//           horizontal: AppDimensions.paddingL, vertical: AppDimensions.paddingS),
//       child: MinimalCard(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Row(
//               children: [
//                 Icon(Icons.shopping_bag_outlined, color: AppColors.iconColor),
//                 SizedBox(width: 8),
//                 Text(
//                   'Pre-Booking',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w600,
//                     color: AppColors.textPrimary,
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: AppDimensions.paddingS),
//             const Text(
//               'Enabled by website. No price in this transaction. '
//                   'For shopping without a recommended goods.',
//               style: TextStyle(
//                 fontSize: 13,
//                 color: AppColors.textSecondary,
//                 height: 1.4,
//               ),
//             ),
//             SizedBox(height: AppDimensions.paddingL),
//             Row(
//               children: [
//                 Expanded(
//                   child: MinimalOutlineButton(
//                     label: 'Add to cart',
//                     icon: Icons.shopping_cart_outlined,
//                     onPressed: () {},
//                   ),
//                 ),
//                 SizedBox(width: AppDimensions.paddingM),
//                 Expanded(
//                   child: MinimalOutlineButton(
//                     label: 'Buy now',
//                     icon: Icons.flash_on_outlined,
//                     onPressed: () {},
//                     isFilled: true,
//                   ),
//                 ),
//                 SizedBox(width: AppDimensions.paddingM),
//                 Expanded(
//                   child: MinimalOutlineButton(
//                     label: 'Checkout',
//                     icon: Icons.payment_outlined,
//                     onPressed: () {},
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class ActivityItem {
//   final IconData icon;
//   final String title;
//   final String time;
//
//   const ActivityItem(
//       {required this.icon, required this.title, required this.time});
// }
//
// class ActivityList extends StatelessWidget {
//   const ActivityList({super.key});
//
//   final List<ActivityItem> _items = const [
//     ActivityItem(icon: Icons.message, title: 'Messages', time: '7:24'),
//     ActivityItem(icon: Icons.calendar_today, title: 'Calendars', time: '10:21'),
//     ActivityItem(icon: Icons.public, title: 'Browser', time: '11:12'),
//     ActivityItem(icon: Icons.note, title: 'Notes', time: '11:32'),
//     ActivityItem(icon: Icons.email, title: 'Mail', time: '11:42'),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(
//           horizontal: AppDimensions.paddingL, vertical: AppDimensions.paddingS),
//       child: MinimalCard(
//         padding: EdgeInsets.zero,
//         child: Column(
//           children: _items.asMap().entries.map((entry) {
//             final index = entry.key;
//             final item = entry.value;
//             return Column(
//               children: [
//                 _ActivityTile(item: item),
//                 if (index != _items.length - 1)
//                   Divider(height: 0, color: AppColors.divider),
//               ],
//             );
//           }).toList(),
//         ),
//       ),
//     );
//   }
// }
//
// class _ActivityTile extends StatelessWidget {
//   final ActivityItem item;
//
//   const _ActivityTile({required this.item});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(
//           horizontal: AppDimensions.paddingL, vertical: AppDimensions.paddingM),
//       child: Row(
//         children: [
//           Container(
//             width: 40,
//             height: 40,
//             decoration: BoxDecoration(
//               color: AppColors.iconBg,
//               borderRadius:
//               BorderRadius.circular(AppDimensions.borderRadiusButton),
//             ),
//             child: Icon(item.icon, color: AppColors.iconColor, size: 22),
//           ),
//           SizedBox(width: AppDimensions.paddingM),
//           Expanded(
//             child: Text(
//               item.title,
//               style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//                 color: AppColors.textPrimary,
//               ),
//             ),
//           ),
//           Text(
//             item.time,
//             style: const TextStyle(
//               fontSize: 14,
//               color: AppColors.textHint,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class OutfitItem {
//   final int id;
//   final String name;
//   final int itemCount;
//   final String emoji;
//   final String tag;
//
//   const OutfitItem(
//       {required this.id,
//         required this.name,
//         required this.itemCount,
//         required this.emoji,
//         required this.tag});
// }
//
// class OutfitPlannerSection extends StatefulWidget {
//   const OutfitPlannerSection({super.key});
//
//   @override
//   State<OutfitPlannerSection> createState() => _OutfitPlannerSectionState();
// }
//
// class _OutfitPlannerSectionState extends State<OutfitPlannerSection> {
//   final List<OutfitItem> _outfits = const [
//     OutfitItem(
//         id: 1,
//         name: 'Casual Friday',
//         itemCount: 3,
//         emoji: '☀️',
//         tag: 'Everyday'),
//     OutfitItem(
//         id: 2, name: 'Date Night', itemCount: 4, emoji: '🌙', tag: 'Special'),
//     OutfitItem(
//         id: 3, name: 'Office Ready', itemCount: 5, emoji: '💼', tag: 'Work'),
//     OutfitItem(
//         id: 4,
//         name: 'Weekend Brunch',
//         itemCount: 3,
//         emoji: '🥂',
//         tag: 'Leisure'),
//     OutfitItem(
//         id: 5, name: 'Gym Session', itemCount: 2, emoji: '🏋️', tag: 'Active'),
//   ];
//
//   final Set<int> _likedOutfits = <int>{};
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(top: AppDimensions.paddingXL),
//       child: Column(
//         children: [
//           _buildSectionHeader('Outfit Planner', 'See all'),
//           SizedBox(height: AppDimensions.paddingS),
//           SizedBox(
//             height: 165,
//             child: ListView.separated(
//               scrollDirection: Axis.horizontal,
//               padding: EdgeInsets.symmetric(horizontal: AppDimensions.paddingL),
//               itemCount: _outfits.length,
//               separatorBuilder: (_, __) =>
//                   SizedBox(width: AppDimensions.paddingM),
//               itemBuilder: (context, index) {
//                 final outfit = _outfits[index];
//                 final liked = _likedOutfits.contains(outfit.id);
//                 return _OutfitCard(
//                   outfit: outfit,
//                   liked: liked,
//                   onLikeToggle: () => setState(() {
//                     if (liked)
//                       _likedOutfits.remove(outfit.id);
//                     else
//                       _likedOutfits.add(outfit.id);
//                   }),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSectionHeader(String title, String actionText) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: AppDimensions.paddingL),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(title,
//               style: const TextStyle(
//                   fontSize: 17,
//                   fontWeight: FontWeight.w700,
//                   color: AppColors.textPrimary)),
//           TextButton(
//             onPressed: () {},
//             style: TextButton.styleFrom(foregroundColor: AppColors.iconColor),
//             child: Row(
//               children: [
//                 Text(actionText,
//                     style: const TextStyle(
//                         fontSize: 12, fontWeight: FontWeight.w600)),
//                 const SizedBox(width: 2),
//                 const Icon(Icons.chevron_right, size: 16),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _OutfitCard extends StatelessWidget {
//   final OutfitItem outfit;
//   final bool liked;
//   final VoidCallback onLikeToggle;
//
//   const _OutfitCard(
//       {required this.outfit, required this.liked, required this.onLikeToggle});
//
//   @override
//   Widget build(BuildContext context) {
//     return MinimalCard(
//       padding: EdgeInsets.all(AppDimensions.paddingM),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             height: 86,
//             decoration: BoxDecoration(
//               color: AppColors.background,
//               borderRadius:
//               BorderRadius.circular(AppDimensions.borderRadiusButton),
//               border: Border.all(color: AppColors.divider),
//             ),
//             child: Stack(
//               children: [
//                 Center(
//                     child: Text(outfit.emoji,
//                         style: const TextStyle(fontSize: 30))),
//                 Positioned(
//                   top: 6,
//                   left: 6,
//                   child: Container(
//                     padding: EdgeInsets.symmetric(
//                         horizontal: AppDimensions.paddingS, vertical: 2),
//                     decoration: BoxDecoration(
//                       color: AppColors.surface,
//                       borderRadius:
//                       BorderRadius.circular(AppDimensions.borderRadiusChip),
//                       border: Border.all(color: AppColors.borderLight),
//                     ),
//                     child: Text(outfit.tag,
//                         style: const TextStyle(
//                             color: AppColors.textSecondary,
//                             fontSize: 9,
//                             fontWeight: FontWeight.w600)),
//                   ),
//                 ),
//                 Positioned(
//                   top: 6,
//                   right: 6,
//                   child: InkWell(
//                     onTap: onLikeToggle,
//                     child: Icon(
//                       liked ? Icons.favorite : Icons.favorite_border,
//                       size: 16,
//                       color:
//                       liked ? const Color(0xFFE57373) : AppColors.iconColor,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: AppDimensions.paddingS),
//           Text(outfit.name,
//               style: const TextStyle(
//                   fontWeight: FontWeight.w600,
//                   fontSize: 13,
//                   color: AppColors.textPrimary)),
//           SizedBox(height: AppDimensions.paddingXS),
//           Text('${outfit.itemCount} items',
//               style: const TextStyle(color: AppColors.textHint, fontSize: 11)),
//         ],
//       ),
//     );
//   }
// }
//
// class CalendarPage extends StatelessWidget {
//   const CalendarPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.background,
//       appBar: AppBar(
//         title: const Text('Calendar'),
//         backgroundColor: AppColors.surface,
//       ),
//       body: Center(
//         child: MinimalCard(
//           child: Text(
//             'Your calendar content',
//             style: TextStyle(color: AppColors.textPrimary),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
// import 'package:flutter/material.dart';
//
// import '../../../config/theme/app_colors.dart';
// import '../../../config/theme/app_dimensions.dart';
// import 'home_header.dart';
//
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.background,
//       body: SafeArea(
//         bottom: false,
//         child: Column(
//           children: [
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: const [
//                     HomeHeader(),
//                     CategoriesSection(),
//                     FeaturedBanner(),
//                     WeatherWidget(),
//                     PreBookingCard(),
//                     ActivityList(),
//                     OutfitPlannerSection(),
//                     // TrendingSection(),
//                     // QuickTipsSection(),
//                     SizedBox(height: AppDimensions.paddingL),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // // /// lib/config/theme/app_theme.dart
// // // ///
// // // /// Complete theme configuration for the Authenticator app.
// // // /// Provides light and dark themes with yellow primary color.
// // // ///
// // //
// // // import 'package:flutter/material.dart';
// // // import 'app_colors.dart';
// // // import 'app_text_styles.dart';
// // //
// // // class AppTheme {
// // //   // Private constructor to prevent instantiation
// // //   AppTheme._();
// // //
// // //   // ============================================================================
// // //   // LIGHT THEME
// // //   // ============================================================================
// // //
// // //   /// Build light theme for the app
// // //   static ThemeData get lightTheme {
// // //     return ThemeData(
// // //       useMaterial3: true,
// // //       brightness: Brightness.light,
// // //
// // //       // Color scheme
// // //       colorScheme: AppColors.lightColorScheme,
// // //
// // //       // Primary colors
// // //       primaryColor: AppColors.primary,
// // //       primaryColorDark: AppColors.primaryDark,
// // //       primaryColorLight: AppColors.primaryLight,
// // //       scaffoldBackgroundColor: AppColors.background,
// // //
// // //       // ========================================================================
// // //       // APP BAR THEME
// // //       // ========================================================================
// // //       appBarTheme: AppBarTheme(
// // //         elevation: 0,
// // //         backgroundColor: AppColors.white,
// // //         foregroundColor: AppColors.textPrimary,
// // //         surfaceTintColor: AppColors.white,
// // //         centerTitle: true,
// // //         titleTextStyle: AppTextStyles.headlineLarge.copyWith(
// // //           color: AppColors.textPrimary,
// // //         ),
// // //         iconTheme: const IconThemeData(
// // //           color: AppColors.textPrimary,
// // //           size: 24,
// // //         ),
// // //         toolbarHeight: 56,
// // //       ),
// // //
// // //       // ========================================================================
// // //       // TEXT FIELD (INPUT DECORATION) THEME
// // //       // ========================================================================
// // //       inputDecorationTheme: InputDecorationTheme(
// // //         filled: true,
// // //         fillColor: AppColors.lightGray,
// // //         contentPadding: const EdgeInsets.symmetric(
// // //           horizontal: 16,
// // //           vertical: 14,
// // //         ),
// // //         isDense: false,
// // //
// // //         // Border styles
// // //         border: OutlineInputBorder(
// // //           borderRadius: BorderRadius.circular(12),
// // //           borderSide: const BorderSide(
// // //             color: AppColors.textHint,
// // //             width: 1,
// // //           ),
// // //         ),
// // //         enabledBorder: OutlineInputBorder(
// // //           borderRadius: BorderRadius.circular(12),
// // //           borderSide: const BorderSide(
// // //             color: AppColors.textHint,
// // //             width: 1,
// // //           ),
// // //         ),
// // //         focusedBorder: OutlineInputBorder(
// // //           borderRadius: BorderRadius.circular(12),
// // //           borderSide: const BorderSide(
// // //             color: AppColors.primary,
// // //             width: 2,
// // //           ),
// // //         ),
// // //         errorBorder: OutlineInputBorder(
// // //           borderRadius: BorderRadius.circular(12),
// // //           borderSide: const BorderSide(
// // //             color: AppColors.error,
// // //             width: 1,
// // //           ),
// // //         ),
// // //         focusedErrorBorder: OutlineInputBorder(
// // //           borderRadius: BorderRadius.circular(12),
// // //           borderSide: const BorderSide(
// // //             color: AppColors.error,
// // //             width: 2,
// // //           ),
// // //         ),
// // //         disabledBorder: OutlineInputBorder(
// // //           borderRadius: BorderRadius.circular(12),
// // //           borderSide: const BorderSide(
// // //             color: AppColors.mediumGray,
// // //             width: 1,
// // //           ),
// // //         ),
// // //
// // //         // Text styles
// // //         hintStyle: AppTextStyles.inputHint,
// // //         labelStyle: AppTextStyles.inputLabel,
// // //         errorStyle: AppTextStyles.errorMessage.copyWith(height: 1.2),
// // //         helperStyle: AppTextStyles.bodySmall.copyWith(
// // //           color: AppColors.textSecondary,
// // //         ),
// // //
// // //         // Prefix/Suffix icon colors
// // //         prefixIconColor: AppColors.textSecondary,
// // //         suffixIconColor: AppColors.textSecondary,
// // //         prefixStyle: AppTextStyles.bodyMedium,
// // //         suffixStyle: AppTextStyles.bodyMedium,
// // //
// // //         // Counter style
// // //         counterStyle: AppTextStyles.bodySmall,
// // //
// // //         // Floated label behavior
// // //         floatingLabelBehavior: FloatingLabelBehavior.auto,
// // //       ),
// // //
// // //       // ========================================================================
// // //       // ELEVATED BUTTON THEME
// // //       // ========================================================================
// // //       elevatedButtonTheme: ElevatedButtonThemeData(
// // //         style: ElevatedButton.styleFrom(
// // //           backgroundColor: AppColors.primary,
// // //           foregroundColor: AppColors.white,
// // //           disabledBackgroundColor: AppColors.mediumGray,
// // //           disabledForegroundColor: AppColors.white.withOpacity(0.5),
// // //           elevation: 2,
// // //           shadowColor: AppColors.primary.withOpacity(0.3),
// // //           padding: const EdgeInsets.symmetric(
// // //             horizontal: 24,
// // //             vertical: 14,
// // //           ),
// // //           shape: RoundedRectangleBorder(
// // //             borderRadius: BorderRadius.circular(12),
// // //           ),
// // //           textStyle: AppTextStyles.primaryButton,
// // //           animationDuration: const Duration(milliseconds: 200),
// // //         ),
// // //       ),
// // //
// // //       // ========================================================================
// // //       // OUTLINED BUTTON THEME
// // //       // ========================================================================
// // //       outlinedButtonTheme: OutlinedButtonThemeData(
// // //         style: OutlinedButton.styleFrom(
// // //           foregroundColor: AppColors.primary,
// // //           side: const BorderSide(
// // //             color: AppColors.primary,
// // //             width: 2,
// // //           ),
// // //           disabledForegroundColor: AppColors.mediumGray,
// // //           padding: const EdgeInsets.symmetric(
// // //             horizontal: 24,
// // //             vertical: 14,
// // //           ),
// // //           shape: RoundedRectangleBorder(
// // //             borderRadius: BorderRadius.circular(12),
// // //           ),
// // //           textStyle: AppTextStyles.secondaryButton,
// // //           animationDuration: const Duration(milliseconds: 200),
// // //         ),
// // //       ),
// // //
// // //       // ========================================================================
// // //       // TEXT BUTTON THEME
// // //       // ========================================================================
// // //       textButtonTheme: TextButtonThemeData(
// // //         style: TextButton.styleFrom(
// // //           foregroundColor: AppColors.primary,
// // //           padding: const EdgeInsets.symmetric(
// // //             horizontal: 16,
// // //             vertical: 8,
// // //           ),
// // //           textStyle: AppTextStyles.labelLarge,
// // //           animationDuration: const Duration(milliseconds: 200),
// // //         ),
// // //       ),
// // //
// // //       // ========================================================================
// // //       // FLOATING ACTION BUTTON THEME
// // //       // ========================================================================
// // //       floatingActionButtonTheme: FloatingActionButtonThemeData(
// // //         backgroundColor: AppColors.primary,
// // //         foregroundColor: AppColors.white,
// // //         elevation: 4,
// // //         focusElevation: 8,
// // //         hoverElevation: 8,
// // //         splashColor: AppColors.white.withOpacity(0.5),
// // //         shape: const RoundedRectangleBorder(
// // //           borderRadius: BorderRadius.all(Radius.circular(16)),
// // //         ),
// // //       ),
// // //
// // //       // ========================================================================
// // //       // CHECKBOX THEME
// // //       // ========================================================================
// // //       checkboxTheme: CheckboxThemeData(
// // //         fillColor: MaterialStateProperty.resolveWith((states) {
// // //           if (states.contains(MaterialState.selected)) {
// // //             return AppColors.primary;
// // //           }
// // //           return AppColors.lightGray;
// // //         }),
// // //         checkColor: MaterialStateProperty.all(AppColors.white),
// // //         shape: RoundedRectangleBorder(
// // //           borderRadius: BorderRadius.circular(4),
// // //         ),
// // //       ),
// // //
// // //       // ========================================================================
// // //       // RADIO BUTTON THEME
// // //       // ========================================================================
// // //       radioTheme: RadioThemeData(
// // //         fillColor: MaterialStateProperty.resolveWith((states) {
// // //           if (states.contains(MaterialState.selected)) {
// // //             return AppColors.primary;
// // //           }
// // //           return AppColors.textHint;
// // //         }),
// // //       ),
// // //
// // //       // ========================================================================
// // //       // SWITCH THEME
// // //       // ========================================================================
// // //       switchTheme: SwitchThemeData(
// // //         thumbColor: MaterialStateProperty.resolveWith((states) {
// // //           if (states.contains(MaterialState.selected)) {
// // //             return AppColors.white;
// // //           }
// // //           return AppColors.mediumGray;
// // //         }),
// // //         trackColor: MaterialStateProperty.resolveWith((states) {
// // //           if (states.contains(MaterialState.selected)) {
// // //             return AppColors.primary;
// // //           }
// // //           return AppColors.lightGray;
// // //         }),
// // //       ),
// // //
// // //       // ========================================================================
// // //       // DIALOG THEME
// // //       // ========================================================================
// // //       dialogTheme: DialogThemeData(
// // //         backgroundColor: AppColors.surface,
// // //         elevation: 8,
// // //         shape: RoundedRectangleBorder(
// // //           borderRadius: BorderRadius.circular(16),
// // //         ),
// // //         titleTextStyle: AppTextStyles.headlineMedium,
// // //         contentTextStyle: AppTextStyles.bodyMedium,
// // //       ),
// // //
// // //       // ========================================================================
// // //       // SNACK BAR THEME
// // //       // ========================================================================
// // //       snackBarTheme: SnackBarThemeData(
// // //         backgroundColor: AppColors.darkGray,
// // //         contentTextStyle: AppTextStyles.bodyMedium.copyWith(
// // //           color: AppColors.white,
// // //         ),
// // //         actionTextColor: AppColors.primary,
// // //         elevation: 4,
// // //         insetPadding: const EdgeInsets.all(16),
// // //         shape: RoundedRectangleBorder(
// // //           borderRadius: BorderRadius.circular(8),
// // //         ),
// // //         behavior: SnackBarBehavior.floating,
// // //       ),
// // //
// // //       // ========================================================================
// // //       // CARD THEME
// // //       // ========================================================================
// // //       cardTheme: CardThemeData(
// // //         color: AppColors.surface,
// // //         elevation: 2,
// // //         shape: RoundedRectangleBorder(
// // //           borderRadius: BorderRadius.circular(12),
// // //         ),
// // //         margin: EdgeInsets.zero,
// // //         surfaceTintColor: AppColors.primary.withOpacity(0.05),
// // //       ),
// // //
// // //       // ========================================================================
// // //       // DIVIDER THEME
// // //       // ========================================================================
// // //       dividerTheme: const DividerThemeData(
// // //         color: AppColors.lightGray,
// // //         thickness: 1,
// // //         space: 16,
// // //       ),
// // //
// // //       // ========================================================================
// // //       // CHIP THEME
// // //       // ========================================================================
// // //       chipTheme: ChipThemeData(
// // //         backgroundColor: AppColors.primaryVeryLight,
// // //         selectedColor: AppColors.primary,
// // //         disabledColor: AppColors.lightGray,
// // //         labelPadding: const EdgeInsets.symmetric(horizontal: 12),
// // //         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
// // //         shape: RoundedRectangleBorder(
// // //           borderRadius: BorderRadius.circular(20),
// // //         ),
// // //         labelStyle: AppTextStyles.labelMedium,
// // //         secondaryLabelStyle: AppTextStyles.labelMedium.copyWith(
// // //           color: AppColors.white,
// // //         ),
// // //         brightness: Brightness.light,
// // //         elevation: 2,
// // //       ),
// // //
// // //       // ========================================================================
// // //       // BOTTOM SHEET THEME
// // //       // ========================================================================
// // //       bottomSheetTheme: const BottomSheetThemeData(
// // //         backgroundColor: AppColors.surface,
// // //         elevation: 8,
// // //         shape: RoundedRectangleBorder(
// // //           borderRadius: BorderRadius.only(
// // //             topLeft: Radius.circular(20),
// // //             topRight: Radius.circular(20),
// // //           ),
// // //         ),
// // //         modalBackgroundColor: AppColors.surface,
// // //         modalElevation: 8,
// // //       ),
// // //
// // //       // ========================================================================
// // //       // NAVIGATION RAIL THEME
// // //       // ========================================================================
// // //       navigationRailTheme: NavigationRailThemeData(
// // //         backgroundColor: AppColors.white,
// // //         elevation: 2,
// // //         selectedIconTheme: const IconThemeData(
// // //           color: AppColors.primary,
// // //           size: 24,
// // //         ),
// // //         unselectedIconTheme: const IconThemeData(
// // //           color: AppColors.textSecondary,
// // //           size: 24,
// // //         ),
// // //         selectedLabelTextStyle: AppTextStyles.labelMedium.copyWith(
// // //           color: AppColors.primary,
// // //         ),
// // //         unselectedLabelTextStyle: AppTextStyles.labelMedium.copyWith(
// // //           color: AppColors.textSecondary,
// // //         ),
// // //       ),
// // //
// // //       // ========================================================================
// // //       // BOTTOM NAVIGATION BAR THEME
// // //       // ========================================================================
// // //       bottomNavigationBarTheme: BottomNavigationBarThemeData(
// // //         backgroundColor: AppColors.white,
// // //         elevation: 8,
// // //         selectedItemColor: AppColors.primary,
// // //         unselectedItemColor: AppColors.textSecondary,
// // //         selectedLabelStyle: AppTextStyles.labelSmall,
// // //         unselectedLabelStyle: AppTextStyles.labelSmall,
// // //       ),
// // //
// // //       // ========================================================================
// // //       // PROGRESS INDICATOR THEME
// // //       // ========================================================================
// // //       progressIndicatorTheme: const ProgressIndicatorThemeData(
// // //         color: AppColors.primary,
// // //         linearMinHeight: 4,
// // //         circularTrackColor: AppColors.lightGray,
// // //       ),
// // //
// // //       // ========================================================================
// // //       // TOOLTIP THEME
// // //       // ========================================================================
// // //       tooltipTheme: TooltipThemeData(
// // //         decoration: BoxDecoration(
// // //           color: AppColors.darkGray,
// // //           borderRadius: BorderRadius.circular(6),
// // //         ),
// // //         textStyle: AppTextStyles.bodySmall.copyWith(
// // //           color: AppColors.white,
// // //         ),
// // //         showDuration: const Duration(seconds: 3),
// // //       ),
// // //
// // //       // ========================================================================
// // //       // TEXT THEME
// // //       // ========================================================================
// // //       textTheme: TextTheme(
// // //         displayLarge: AppTextStyles.displayLarge,
// // //         displayMedium: AppTextStyles.displayMedium,
// // //         displaySmall: AppTextStyles.displaySmall,
// // //         headlineLarge: AppTextStyles.headlineLarge,
// // //         headlineMedium: AppTextStyles.headlineMedium,
// // //         headlineSmall: AppTextStyles.headlineSmall,
// // //         titleLarge: AppTextStyles.titleLarge,
// // //         titleMedium: AppTextStyles.titleMedium,
// // //         titleSmall: AppTextStyles.titleSmall,
// // //         bodyLarge: AppTextStyles.bodyLarge,
// // //         bodyMedium: AppTextStyles.bodyMedium,
// // //         bodySmall: AppTextStyles.bodySmall,
// // //         labelLarge: AppTextStyles.labelLarge,
// // //         labelMedium: AppTextStyles.labelMedium,
// // //         labelSmall: AppTextStyles.labelSmall,
// // //       ),
// // //
// // //       // ========================================================================
// // //       // EXTENSION COLORS
// // //       // ========================================================================
// // //       extensions: <ThemeExtension<dynamic>>[],
// // //
// // //       // Other properties
// // //       pageTransitionsTheme: const PageTransitionsTheme(
// // //         builders: <TargetPlatform, PageTransitionsBuilder>{
// // //           TargetPlatform.android: ZoomPageTransitionsBuilder(),
// // //           TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
// // //           TargetPlatform.linux: ZoomPageTransitionsBuilder(),
// // //           TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
// // //           TargetPlatform.windows: ZoomPageTransitionsBuilder(),
// // //         },
// // //       ),
// // //     );
// // //   }
// // //
// // //   // ============================================================================
// // //   // DARK THEME
// // //   // ============================================================================
// // //
// // //   /// Build dark theme for the app
// // //   static ThemeData get darkTheme {
// // //     return ThemeData(
// // //       useMaterial3: true,
// // //       brightness: Brightness.dark,
// // //       colorScheme: ColorScheme.dark(
// // //         primary: AppColors.primary,
// // //         onPrimary: AppColors.black,
// // //         primaryContainer: AppColors.primaryDark,
// // //         onPrimaryContainer: AppColors.primaryLight,
// // //         secondary: AppColors.secondary,
// // //         onSecondary: AppColors.black,
// // //         secondaryContainer: AppColors.secondaryDark,
// // //         onSecondaryContainer: AppColors.secondaryLight,
// // //         surface: const Color(0xFF1F1F1F),
// // //         onSurface: AppColors.white,
// // //         error: AppColors.error,
// // //         onError: AppColors.white,
// // //       ),
// // //       primaryColor: AppColors.primary,
// // //       scaffoldBackgroundColor: const Color(0xFF121212),
// // //       textTheme: TextTheme(
// // //         displayLarge: AppTextStyles.displayLarge.copyWith(
// // //           color: AppColors.white,
// // //         ),
// // //         displayMedium: AppTextStyles.displayMedium.copyWith(
// // //           color: AppColors.white,
// // //         ),
// // //         displaySmall: AppTextStyles.displaySmall.copyWith(
// // //           color: AppColors.white,
// // //         ),
// // //         headlineLarge: AppTextStyles.headlineLarge.copyWith(
// // //           color: AppColors.white,
// // //         ),
// // //         headlineMedium: AppTextStyles.headlineMedium.copyWith(
// // //           color: AppColors.white,
// // //         ),
// // //         headlineSmall: AppTextStyles.headlineSmall.copyWith(
// // //           color: AppColors.white,
// // //         ),
// // //         titleLarge: AppTextStyles.titleLarge.copyWith(
// // //           color: AppColors.white,
// // //         ),
// // //         titleMedium: AppTextStyles.titleMedium.copyWith(
// // //           color: AppColors.white,
// // //         ),
// // //         titleSmall: AppTextStyles.titleSmall.copyWith(
// // //           color: AppColors.white.withOpacity(0.7),
// // //         ),
// // //         bodyLarge: AppTextStyles.bodyLarge.copyWith(
// // //           color: AppColors.white,
// // //         ),
// // //         bodyMedium: AppTextStyles.bodyMedium.copyWith(
// // //           color: AppColors.white.withOpacity(0.7),
// // //         ),
// // //         bodySmall: AppTextStyles.bodySmall.copyWith(
// // //           color: AppColors.white.withOpacity(0.6),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }
// // //
// // // // ============================================================================
// // // // EXTENSION: ThemeData Extensions
// // // // ============================================================================
// // //
// // // /// Extension methods for ThemeData
// // // extension ThemeDataExtensions on ThemeData {
// // //   /// Check if theme is dark
// // //   bool get isDark => brightness == Brightness.dark;
// // //
// // //   /// Check if theme is light
// // //   bool get isLight => brightness == Brightness.light;
// // // }
// //
// // import 'package:flutter/material.dart';
// // import '../theme/app_colors.dart';
// // import 'app_colors.dart';
// //
// // class AppTheme {
// //   AppTheme._();
// //
// //   static ThemeData get lightTheme {
// //     const textTheme = TextTheme(
// //       titleLarge: TextStyle(
// //         fontSize: 28,
// //         fontWeight: FontWeight.w600,
// //         color: AppColors.textPrimary,
// //         letterSpacing: -0.5,
// //       ),
// //       titleMedium: TextStyle(
// //         fontSize: 14,
// //         fontWeight: FontWeight.w500,
// //         color: AppColors.textPrimary,
// //       ),
// //       bodyMedium: TextStyle(
// //         fontSize: 13,
// //         fontWeight: FontWeight.w400,
// //         color: AppColors.textPrimary,
// //       ),
// //       bodySmall: TextStyle(
// //         fontSize: 11,
// //         fontWeight: FontWeight.w400,
// //         color: AppColors.textSecondary,
// //       ),
// //       labelSmall: TextStyle(
// //         fontSize: 9,
// //         fontWeight: FontWeight.w500,
// //         color: AppColors.authHeroAccent,
// //         letterSpacing: 1.2,
// //       ),
// //     );
// //     return ThemeData(
// //       useMaterial3: true,
// //       scaffoldBackgroundColor: AppColors.authHeroAccent,
// //       colorScheme: const ColorScheme.light(
// //         surface: AppColors.authHeroAccent,
// //         primary: AppColors.authHeroAccent,
// //         onSurface: AppColors.textPrimary,
// //       ),
// //       textTheme: textTheme,
// //       dividerColor: AppColors.backgroundColor,
// //       splashFactory: NoSplash.splashFactory,
// //       appBarTheme: const AppBarTheme(
// //         backgroundColor: Colors.transparent,
// //         elevation: 0,
// //         scrolledUnderElevation: 0,
// //       ),
// //       inputDecorationTheme: InputDecorationTheme(
// //         filled: true,
// //         fillColor: AppColors.authCardSurface,
// //         border: OutlineInputBorder(
// //           borderRadius: BorderRadius.circular(4),
// //           borderSide: BorderSide.none,
// //         ),
// //         enabledBorder: OutlineInputBorder(
// //           borderRadius: BorderRadius.circular(4),
// //           borderSide: BorderSide.none,
// //         ),
// //         focusedBorder: OutlineInputBorder(
// //           borderRadius: BorderRadius.circular(4),
// //           borderSide: const BorderSide(color: AppColors.inputBorderColor),
// //         ),
// //         hintStyle: const TextStyle(
// //           fontSize: 12,
// //           color: AppColors.authInputBorder,
// //         ),
// //         contentPadding:
// //             const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
// //       ),
// //     );
// //   }
// // }
//
// // lib/config/theme/custom_theme.dart
// import 'package:flutter/material.dart';
//
// import 'app_colors.dart';
// import 'app_dimensions.dart';
//
// // import 'app_colors.dart' as AppColors;
// // import 'app_dimensions.dart' as AppDimens;
//
// class AppTheme {
//   // Replace with your actual AppColors
//   static const Color background = Color(0xFFF8F9FA); // very light grey
//   static const Color surface = Colors.white;
//   static const Color textPrimary = Color(0xFF424242);
//   static const Color textSecondary = Color(0xFF757575);
//   static const Color textHint = Color(0xFFBDBDBD);
//   static const Color borderLight = Color(0xFFE0E0E0);
//   static const Color divider = Color(0xFFF0F0F0);
//   static const Color iconBg = Color(0xFFF5F5F5);
//   static const Color iconColor = Color(0xFF9E9E9E);
//
//   // Replace with your actual AppDimensions
//   static const double paddingXS = 4;
//   static const double paddingS = 8;
//   static const double paddingM = 12;
//   static const double paddingL = 16;
//   static const double paddingXL = 20;
//   static const double borderRadiusCard = 16;
//   static const double borderRadiusButton = 12;
//   static const double borderRadiusChip = 30;
// }
//
// class CustomTheme {
//   static ThemeData light() {
//     return ThemeData(
//       scaffoldBackgroundColor: AppColors.background,
//       primaryColor: AppColors.surface,
//       colorScheme: const ColorScheme.light(
//         primary: AppColors.surface,
//         secondary: AppColors.iconBg,
//         surface: AppColors.surface,
//       ),
//       appBarTheme: AppBarTheme(
//         backgroundColor: AppColors.surface,
//         elevation: 0,
//         titleTextStyle: TextStyle(
//           color: AppColors.textPrimary,
//           fontSize: AppDimensions.fontL,
//           fontWeight: FontWeight.w600,
//         ),
//         iconTheme: IconThemeData(color: AppColors.iconColor),
//       ),
//       textTheme: const TextTheme(
//         bodyLarge: TextStyle(color: AppColors.textPrimary),
//         bodyMedium: TextStyle(color: AppColors.textSecondary),
//       ),
//       inputDecorationTheme: InputDecorationTheme(
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(AppDimensions.borderRadiusButton),
//           borderSide: BorderSide(color: AppColors.borderLight),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(AppDimensions.borderRadiusButton),
//           borderSide: BorderSide(color: AppColors.borderLight, width: 1.5),
//         ),
//       ),
//     );
//   }
// }
//
// class MinimalCard extends StatelessWidget {
//   final Widget child;
//   final EdgeInsets? padding;
//   final EdgeInsets? margin;
//   final VoidCallback? onTap;
//
//   const MinimalCard({
//     super.key,
//     required this.child,
//     this.padding,
//     this.margin,
//     this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(AppDimensions.borderRadiusCard),
//       child: Container(
//         margin: margin ?? const EdgeInsets.all(0),
//         padding: padding ?? EdgeInsets.all(AppDimensions.paddingM),
//         decoration: BoxDecoration(
//           color: AppColors.surface,
//           borderRadius: BorderRadius.circular(AppDimensions.borderRadiusCard),
//           border: Border.all(color: AppColors.borderLight),
//           boxShadow: [
//             BoxShadow(
//               color: AppColors.shadowLight,
//               blurRadius: AppDimensions.blurRadiusSmall,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: child,
//       ),
//     );
//   }
// }
//
// class MinimalOutlineButton extends StatelessWidget {
//   final String label;
//   final IconData? icon;
//   final VoidCallback onPressed;
//   final bool isFilled;
//
//   const MinimalOutlineButton({
//     super.key,
//     required this.label,
//     this.icon,
//     required this.onPressed,
//     this.isFilled = false,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return OutlinedButton.icon(
//       onPressed: onPressed,
//       icon: icon != null ? Icon(icon, size: 16) : null,
//       label: Text(label),
//       style: OutlinedButton.styleFrom(
//         foregroundColor: AppColors.textSecondary,
//         side: BorderSide(color: AppColors.borderLight),
//         backgroundColor: isFilled ? AppColors.iconBg : AppColors.surface,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(AppDimensions.borderRadiusButton),
//         ),
//         padding: EdgeInsets.symmetric(
//           vertical: AppDimensions.paddingM,
//           horizontal: AppDimensions.paddingS,
//         ),
//       ),
//     );
//   }
// }
//
//
//
//
//
//
//
