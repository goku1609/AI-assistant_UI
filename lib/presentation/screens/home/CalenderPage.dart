/* =========================================================
   COMPLETE UNIFIED CALENDAR PAGE
   FEATURES:
   ✅ Event + Trip planner
   ✅ Local cache persistence
   ✅ Auto delete expired plans
   ✅ Multiple plan colors
   ✅ Multiple plans on same date
   ✅ Calendar highlights
   ✅ Hover (Web/Desktop)
   ✅ Long press (Mobile)
   ✅ Delete confirmation
   ✅ Dynamic sizing
   ✅ SOLID + Modular structure
========================================================= */

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

class UnifiedCalendarPage extends StatefulWidget {
  const UnifiedCalendarPage({super.key});

  @override
  State<UnifiedCalendarPage> createState() => _UnifiedCalendarPageState();
}

class _UnifiedCalendarPageState extends State<UnifiedCalendarPage> {
  /* =========================================================
     CALENDAR STATE
  ========================================================= */

  DateTime focusedDay = DateTime.now();

  DateTime? selectedDay;

  DateTime? startDate;
  DateTime? endDate;

  String selectedType = "Event";

  /* =========================================================
     CONTROLLERS
  ========================================================= */

  final titleCtrl = TextEditingController();
  final locationCtrl = TextEditingController();
  final themeCtrl = TextEditingController();

  /* =========================================================
     LOCAL CACHE STORAGE
  ========================================================= */

  static const String storageKey = "planned_items";

  List<Map<String, dynamic>> plannedItems = [];

  /* =========================================================
     INIT
  ========================================================= */

  @override
  void initState() {
    super.initState();

    _loadPlans();
  }

  /* =========================================================
     LOAD SAVED PLANS
  ========================================================= */

  Future<void> _loadPlans() async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getString(storageKey);

    if (data == null) return;

    final List decoded = jsonDecode(data);

    plannedItems = decoded.map<Map<String, dynamic>>((e) {
      final map = Map<String, dynamic>.from(e);

      return {
        ...map,
        "date": DateTime.parse(map["date"]),
        "endDate":
            map["endDate"] != null ? DateTime.parse(map["endDate"]) : null,
      };
    }).toList();

    /// REMOVE EXPIRED EVENTS/TRIPS
    plannedItems.removeWhere((item) {
      final DateTime? end = item["endDate"];

      final DateTime compareDate = end ?? item["date"];

      return DateTime.now().isAfter(
        compareDate.add(
          const Duration(days: 1),
        ),
      );
    });

    await _savePlans();

    setState(() {});
  }

  /* =========================================================
     SAVE TO CACHE
  ========================================================= */

  Future<void> _savePlans() async {
    final prefs = await SharedPreferences.getInstance();

    final encoded = jsonEncode(
      plannedItems.map((e) {
        return {
          ...e,
          "date": (e["date"] as DateTime).toIso8601String(),
          "endDate": e["endDate"] != null
              ? (e["endDate"] as DateTime).toIso8601String()
              : null,
        };
      }).toList(),
    );

    await prefs.setString(storageKey, encoded);
  }

  /* =========================================================
     DATE SELECTION
  ========================================================= */

  void onDaySelected(
    DateTime selected,
    DateTime focused,
  ) {
    setState(() {
      focusedDay = focused;

      /// EVENT MODE
      if (selectedType == "Event") {
        selectedDay = selected;
        return;
      }

      /// TRIP MODE
      if (startDate == null || (startDate != null && endDate != null)) {
        startDate = selected;
        endDate = null;
      } else if (selected.isAfter(startDate!)) {
        endDate = selected;
      } else {
        startDate = selected;
        endDate = null;
      }
    });
  }

  /* =========================================================
     RANGE CHECK
  ========================================================= */

  bool isRange(DateTime day) {
    if (startDate == null || endDate == null) {
      return false;
    }

    return day.isAfter(startDate!) && day.isBefore(endDate!);
  }

  /// =======================================================
  /// GET ALL PLANS FOR A SPECIFIC DATE
  /// Used for:
  /// - calendar indicators
  /// - tooltips
  /// - bottom sheet details
  /// - multi event support
  /// =======================================================

  List<Map<String, dynamic>> _getPlansForDate(
    DateTime day,
  ) {
    return plannedItems.where((item) {
      final DateTime start = item["date"] as DateTime;

      final DateTime? end = item["endDate"] as DateTime?;

      /// normalize dates
      final normalizedDay = DateTime(day.year, day.month, day.day);

      final normalizedStart = DateTime(
        start.year,
        start.month,
        start.day,
      );

      final normalizedEnd = end != null
          ? DateTime(
              end.year,
              end.month,
              end.day,
            )
          : null;

      /// EVENT
      if (item["type"] == "Event") {
        return normalizedDay == normalizedStart;
      }

      /// TRIP RANGE
      if (normalizedEnd != null) {
        return !normalizedDay.isBefore(normalizedStart) &&
            !normalizedDay.isAfter(normalizedEnd);
      }

      return false;
    }).toList();
  }

  /* =========================================================
     CURRENT SELECTION CHECK
  ========================================================= */

  bool isSelected(DateTime day) {
    if (selectedType == "Event") {
      return isSameDay(selectedDay, day);
    }

    return isSameDay(startDate, day) || isSameDay(endDate, day);
  }

  /* =========================================================
     SAVE PLAN
  ========================================================= */

  /* =========================================================
   SAVE PLAN
========================================================= */

  Future<void> savePlan() async {
    /// VALIDATION
    if (titleCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter title"),
        ),
      );
      return;
    }

    if (selectedType == "Event" && selectedDay == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select date"),
        ),
      );
      return;
    }

    if (selectedType == "Trip") {
      if (startDate == null || endDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Please select trip range"),
          ),
        );
        return;
      }
    }

    /// CREATE ITEM
    final item = {
      "id": DateTime.now().millisecondsSinceEpoch.toString(),
      "type": selectedType,
      "title": titleCtrl.text.trim(),
      "theme": themeCtrl.text.trim(),
      "location": locationCtrl.text.trim(),
      "date": selectedType == "Event" ? selectedDay : startDate,
      "endDate": selectedType == "Trip" ? endDate : null,
    };

    /// ADD TO LIST
    plannedItems.add(item);

    /// SAVE LOCAL
    await _savePlans();

    /// CLEAR INPUTS
    titleCtrl.clear();
    locationCtrl.clear();
    themeCtrl.clear();

    selectedDay = null;
    startDate = null;
    endDate = null;

    setState(() {});

    /// SUCCESS MESSAGE
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFF6C63FF),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        content: Text(
          "$selectedType saved successfully",
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );

    /// CLOSE BOTTOM SHEET
    Navigator.pop(context);
  }

  /* =========================================================
     DELETE PLAN
  ========================================================= */

  Future<void> deletePlan(String id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Delete Plan"),
          content: const Text(
            "Are you sure you want to delete this plan?",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );

    if (confirm != true) return;

    plannedItems.removeWhere(
      (e) => e["id"] == id,
    );

    await _savePlans();

    setState(() {});
  }

  /* =========================================================
     GET ALL PLANS FOR DATE
  ========================================================= */

  /* =========================================================
   GET EVENTS/TRIPS FOR SPECIFIC DATE
   FIXED TYPE ISSUE
========================================================= */

  List<Map<String, dynamic>> getPlansForDate(DateTime day) {
    return plannedItems.where((item) {
      final DateTime start = DateTime.parse(item["date"].toString());

      final DateTime? end = item["endDate"] != null
          ? DateTime.parse(item["endDate"].toString())
          : null;

      /// normalize dates
      final normalizedDay = DateTime(day.year, day.month, day.day);

      final normalizedStart = DateTime(start.year, start.month, start.day);

      final normalizedEnd =
          end != null ? DateTime(end.year, end.month, end.day) : null;

      /// EVENT
      if (item["type"] == "Event") {
        return normalizedDay == normalizedStart;
      }

      /// TRIP RANGE
      if (normalizedEnd != null) {
        return !normalizedDay.isBefore(normalizedStart) &&
            !normalizedDay.isAfter(normalizedEnd);
      }

      return false;
    }).map<Map<String, dynamic>>((e) {
      /// IMPORTANT FIX
      return Map<String, dynamic>.from(e);
    }).toList();
  }

  /* =========================================================
     DATE COLOR LOGIC
  ========================================================= */

  Color _getDateColor({
    required DateTime day,
    required bool selected,
    required bool range,
  }) {
    final plans = _getPlansForDate(day);

    if (selected) {
      return const Color(0xFF6C63FF);
    }

    if (range) {
      return const Color(0xFFD9D6FF);
    }

    /// MULTIPLE EVENTS/TRIPS
    if (plans.length >= 2) {
      return const Color(0xFFB39DDB);
    }

    /// SINGLE PLAN
    if (plans.isNotEmpty) {
      return _planColor(plans.first["type"]).withOpacity(0.35);
    }

    return Colors.transparent;
  }

  /* =========================================================
     PLAN TYPE COLOR
  ========================================================= */

  Color _planColor(String type) {
    if (type == "Trip") {
      return Colors.blue;
    }

    return Colors.purple;
  }

  /* =========================================================
     WEB/DESKTOP HOVER TOOLTIP
  ========================================================= */

  void _showHoverTooltip(
    BuildContext context,
    DateTime day,
    List<Map<String, dynamic>> plans,
  ) {
    final overlay = Overlay.of(context);

    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (_) => Positioned(
        top: 120,
        left: 30,
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 240,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.12),
                  blurRadius: 12,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  DateFormat.yMMMMd().format(day),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 10),
                ...plans.map(
                  (plan) => Padding(
                    padding: const EdgeInsets.only(
                      bottom: 8,
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                            color: _planColor(
                              plan["type"],
                            ),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            plan["title"],
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(
      const Duration(seconds: 2),
      () {
        overlayEntry.remove();
      },
    );
  }

  /* =========================================================
     MOBILE DETAILS BOTTOM SHEET
  ========================================================= */

  void _showPlanBottomSheet(
    List<Map<String, dynamic>> plans,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(28),
        ),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Planned Events",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 18),
              ...plans.map(
                (plan) => Container(
                  margin: const EdgeInsets.only(
                    bottom: 14,
                  ),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: _planColor(
                      plan["type"],
                    ).withOpacity(0.12),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        plan["type"] == "Trip" ? Icons.luggage : Icons.event,
                        color: _planColor(
                          plan["type"],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              plan["title"],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              plan["location"],
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /* =========================================================
     UI
  ========================================================= */

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFE9E7FF),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFE9E7FF),
        centerTitle: true,
        title: const Text(
          "Planner",
          style: TextStyle(
            color: Color(0xFF1F1F39),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /* =========================================================
                 TOP CARD
              ========================================================= */

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFC8C4FF),
                  borderRadius: BorderRadius.circular(36),
                ),
                child: Column(
                  children: [
                    /* =========================================================
                       CALENDAR
                    ========================================================= */

                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.55),
                        borderRadius: BorderRadius.circular(28),
                      ),
                      child: TableCalendar(
                        firstDay: DateTime.now(),
                        lastDay: DateTime(2035),
                        focusedDay: focusedDay,
                        selectedDayPredicate: isSelected,
                        onDaySelected: onDaySelected,
                        rangeStartDay: startDate,
                        rangeEndDay: endDate,
                        headerStyle: const HeaderStyle(
                          titleCentered: true,
                          formatButtonVisible: false,
                        ),
                        calendarStyle: CalendarStyle(
                          todayDecoration: BoxDecoration(
                            color: Colors.deepPurple.shade200,
                            shape: BoxShape.circle,
                          ),
                          selectedDecoration: const BoxDecoration(
                            color: Color(0xFF6C63FF),
                            shape: BoxShape.circle,
                          ),
                        ),
                        calendarBuilders: CalendarBuilders(
                          defaultBuilder: (
                            context,
                            day,
                            focusedDay,
                          ) {
                            final selected = isSelected(day);

                            final range =
                                selectedType == "Trip" && isRange(day);

                            final plans = _getPlansForDate(day);

                            return GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: null,
                              onLongPress: plans.isEmpty
                                  ? null
                                  : () {
                                      _showPlanBottomSheet(plans);
                                    },
                              child: MouseRegion(
                                onHover: (_) {
                                  if (plans.isNotEmpty && kIsWeb) {
                                    _showHoverTooltip(
                                      context,
                                      day,
                                      plans,
                                    );
                                  }
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: _getDateColor(
                                      day: day,
                                      selected: selected,
                                      range: range,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  alignment: Alignment.center,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Text(
                                        "${day.day}",
                                        style: TextStyle(
                                          color: selected
                                              ? Colors.white
                                              : Colors.black,
                                          fontWeight: selected
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                        ),
                                      ),
                                      if (plans.isNotEmpty)
                                        Positioned(
                                          bottom: 4,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: plans
                                                .take(3)
                                                .map(
                                                  (
                                                    e,
                                                  ) =>
                                                      Container(
                                                    margin: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 1,
                                                    ),
                                                    height: 5,
                                                    width: 5,
                                                    decoration: BoxDecoration(
                                                      color: _planColor(
                                                        e["type"],
                                                      ),
                                                      shape: BoxShape.circle,
                                                    ),
                                                  ),
                                                )
                                                .toList(),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    /* =========================================================
                       EVENT / TRIP SELECTOR
                    ========================================================= */

                    Row(
                      children: [
                        Expanded(
                          child: _typeButton("Event"),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _typeButton("Trip"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),

              /* =========================================================
                 SELECTED DATES
              ========================================================= */

              const SizedBox(height: 18),

              /* =========================================================
                   CREATE BUTTON
                =========================================================
========================================= */

              /* =========================================
   SHOW BUTTON ONLY AFTER:
   ✅ EVENT DATE SELECTED
   ✅ OR TRIP START DATE SELECTED
   (trip can also be one-day)
========================================= */

              if (selectedType == "Event"
                  ? selectedDay != null
                  : startDate != null)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      /// FOR ONE-DAY TRIP
                      /// if endDate not selected
                      /// use startDate as endDate
                      if (selectedType == "Trip" && endDate == null) {
                        endDate = startDate;
                      }

                      _showCreatePlanBottomSheet();
                    },
                    label: Text(
                      selectedType == "Trip" ? "Plan Trip" : "Plan Event",
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6C63FF),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  /* =========================================================
     TYPE BUTTON
  ========================================================= */

  Widget _typeButton(String type) {
    final selected = selectedType == type;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedType = type;

          selectedDay = null;
          startDate = null;
          endDate = null;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(
          vertical: 14,
        ),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF6C63FF) : Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Center(
          child: Text(
            type,
            style: TextStyle(
              color: selected ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  /* =========================================================
     INPUT FIELD
  ========================================================= */

  /* =========================================================
   MODERN INPUT FIELD UI
   FEATURES:
   ✅ Glassmorphism style
   ✅ Better focus animation feeling
   ✅ Rounded premium UI
   ✅ Icons support
   ✅ Better padding
   ✅ Blue theme matching
========================================================= */

  Widget _inputField({
    required TextEditingController controller,
    required String hint,
    IconData? icon,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: [
            Colors.white,
            const Color(0xFFF8F8FF),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.grey.shade500,
            fontSize: 14,
          ),

          /* =========================================
           PREFIX ICON
        ========================================= */

          prefixIcon: icon != null
              ? Icon(
                  icon,
                  color: const Color(0xFF6C63FF),
                  size: 22,
                )
              : null,

          /* =========================================
           SPACING
        ========================================= */

          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 18,
          ),

          /* =========================================
           FILLED BACKGROUND
        ========================================= */

          filled: true,
          fillColor: Colors.transparent,

          /* =========================================
           ENABLED BORDER
        ========================================= */

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide(
              color: Colors.grey.shade200,
              width: 1.2,
            ),
          ),

          /* =========================================
           FOCUSED BORDER
        ========================================= */

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: const BorderSide(
              color: Color(0xFF6C63FF),
              width: 1.8,
            ),
          ),

          /* =========================================
           DEFAULT BORDER
        ========================================= */

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  /* =========================================================
   CREATE PLAN FORM BOTTOM SHEET
========================================================= */

  void _showCreatePlanBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 22,
                bottom: MediaQuery.of(context).viewInsets.bottom + 25,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(32),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /* =========================================
                     TOP HANDLE
                  ========================================= */

                    Center(
                      child: Container(
                        width: 55,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    /* =========================================
                     TITLE
                  ========================================= */

                    Text(
                      selectedType == "Trip"
                          ? "Create New Trip"
                          : "Create New Event",
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),

                    /* =========================================
                     SELECTED DATE
                  ========================================= */

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5FF),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Selected Dates",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            selectedType == "Event"
                                ? selectedDay == null
                                    ? "Tap a date on calendar"
                                    : DateFormat.yMMMMd().format(selectedDay!)
                                : startDate == null
                                    ? "Select trip range"
                                    : endDate == null
                                        ? DateFormat.yMMMMd().format(startDate!)
                                        : "${DateFormat.yMMMd().format(startDate!)} → ${DateFormat.yMMMd().format(endDate!)}",
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),

                    /* =========================================
                     INPUTS
                  ========================================= */

                    _inputField(
                      controller: titleCtrl,
                      hint:
                          selectedType == "Trip" ? "Trip Name" : "Event Title",
                      icon: Icons.title_rounded,
                    ),
                    const SizedBox(height: 16),
                    _inputField(
                      controller: locationCtrl,
                      hint: "Location",
                      icon: Icons.location_on_outlined,
                    ),
                    const SizedBox(height: 16),
                    _inputField(
                      controller: themeCtrl,
                      hint: "Theme / Notes",
                      icon: Icons.palette_outlined,
                    ),
                    const SizedBox(height: 24),

                    /* =========================================
                     SAVE BUTTON
                  ========================================= */

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (selectedType == "Event" && selectedDay == null) {
                            return;
                          }

                          if (selectedType == "Trip" &&
                              (startDate == null || endDate == null)) {
                            return;
                          }

                          await savePlan();

                          if (mounted) {
                            Navigator.pop(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6C63FF),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22),
                          ),
                        ),
                        child: Text(
                          selectedType == "Trip" ? "Save Trip" : "Save Event",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

/// This widget can be placed inside any Column/ListView.
/// It shows:
/// - a list of plan cards if any exist
/// - an empty state with a "Plan your trip/event" message and a calendar button
/// It also notifies the parent when the list becomes empty or non‑empty.
/// ===============================================================
/// PLANNER WIDGET
/// ===============================================================
/// RESPONSIBILITIES:
///
/// ✅ Load cached plans
/// ✅ Remove expired plans
/// ✅ Show empty state
/// ✅ Show plan cards
/// ✅ Open calendar page
/// ✅ Notify parent if plans exist
/// ===============================================================

/// ===============================================================
/// PLANNER PAGE
/// ===============================================================
/// FLOW:
///
/// IF NO EVENTS/TRIPS:
///    → show empty state
///    → show planner button
///
/// IF EVENTS/TRIPS EXIST:
///    → show all cards
///    → show floating action button
///
/// BUTTON CLICK:
///    → opens UnifiedCalendarPage
///
/// AFTER RETURN:
///    → auto refresh
/// ===============================================================

/// ===============================================================
/// PLANNER PAGE
/// ===============================================================
/// UPDATED:
/// ✅ Calendar icon moved to TOP RIGHT CORNER
/// ✅ Bigger cards
/// ✅ 3 cards visible per screen
/// ✅ Scrollable list
/// ✅ Dynamic sizing
/// ===============================================================

class PlannerPage extends StatefulWidget {
  const PlannerPage({super.key});

  @override
  State<PlannerPage> createState() => _PlannerPageState();
}

class _PlannerPageState extends State<PlannerPage> {
  /// ===========================================================
  /// STORAGE KEY
  /// ===========================================================

  static const String storageKey = "planned_items";

  /// ===========================================================
  /// STORED PLANS
  /// ===========================================================

  List<Map<String, dynamic>> plans = [];

  /// ===========================================================
  /// INIT
  /// ===========================================================

  @override
  void initState() {
    super.initState();

    _loadPlans();
  }

  /// ===========================================================
  /// LOAD PLANS
  /// ===========================================================

  Future<void> _loadPlans() async {

    final prefs =
    await SharedPreferences.getInstance();

    final String? data =
    prefs.getString(storageKey);

    if (data == null) {

      setState(() {
        plans = [];
      });

      return;
    }

    final List decoded =
    jsonDecode(data);

    List<Map<String, dynamic>> loaded =
    decoded.map<Map<String, dynamic>>((e) {

      final map =
      Map<String, dynamic>.from(e);

      return {

        ...map,

        "date":
        DateTime.parse(map["date"]),

        "endDate":
        map["endDate"] != null
            ? DateTime.parse(
          map["endDate"],
        )
            : null,
      };

    }).toList();

    /// REMOVE EXPIRED
    loaded.removeWhere((item) {

      final DateTime? end =
      item["endDate"];

      final DateTime compareDate =
          end ?? item["date"];

      return DateTime.now().isAfter(
        compareDate.add(
          const Duration(days: 1),
        ),
      );
    });

    /// SORT BY NEAREST UPCOMING DATE
    loaded.sort((a, b) {

      final DateTime aDate =
      a["date"];

      final DateTime bDate =
      b["date"];

      return aDate.compareTo(bDate);
    });

    setState(() {
      plans = loaded;
    });
  }

  /// ===========================================================
  /// OPEN CALENDAR PAGE
  /// ===========================================================

  Future<void> _openCalendar() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const UnifiedCalendarPage(),
      ),
    );

    _loadPlans();
  }

  /// ===========================================================
  /// PLAN TYPE COLOR
  /// ===========================================================

  Color _planColor(String type) {
    if (type == "Trip") {
      return Colors.blue;
    }

    return Colors.purple;
  }

  /// ===========================================================
  /// DELETE PLAN
  /// ===========================================================

  Future<void> _deletePlan(
    String id,
  ) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Delete Plan"),
          content: const Text(
            "Are you sure you want to delete this plan?",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  false,
                );
              },
              child: const Text(
                "Cancel",
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  true,
                );
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );

    if (confirm != true) return;

    final prefs = await SharedPreferences.getInstance();

    plans.removeWhere(
      (e) => e["id"] == id,
    );

    final encoded = jsonEncode(
      plans.map((e) {
        return {
          ...e,
          "date": (e["date"] as DateTime).toIso8601String(),
          "endDate": e["endDate"] != null
              ? (e["endDate"] as DateTime).toIso8601String()
              : null,
        };
      }).toList(),
    );

    await prefs.setString(
      storageKey,
      encoded,
    );

    setState(() {});
  }

  /// ===========================================================
  /// BIG CARD UI
  /// ===========================================================

  Widget _planCard(
      Map<String, dynamic> plan,
      ) {

    final bool isTrip =
        plan["type"] == "Trip";

    final String dateText = isTrip
        ? "${DateFormat.yMMMd().format(plan["date"])} → ${DateFormat.yMMMd().format(plan["endDate"])}"
        : DateFormat.yMMMd().format(
      plan["date"],
    );

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PlanDetailsPage(plan: plan),
          ),
        );
      },

      child: Container(
        margin: const EdgeInsets.only(bottom: 20),

        padding: const EdgeInsets.all(22),

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius: BorderRadius.circular(34),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// TOP ROW
            Row(
              children: [
                Container(
                  height: 68,
                  width: 68,

                  decoration: BoxDecoration(
                    color: _planColor(
                      plan["type"],
                    ).withOpacity(0.12),

                    borderRadius: BorderRadius.circular(24),
                  ),

                  child: Icon(
                    isTrip
                        ? Icons.luggage_rounded
                        : Icons.event_rounded,

                    color: _planColor(plan["type"]),

                    size: 34,
                  ),
                ),

                const Spacer(),

                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(16),
                  ),

                  child: IconButton(
                    onPressed: () {
                      _deletePlan(plan["id"]);
                    },

                    icon: const Icon(
                      Icons.delete_outline_rounded,
                      size: 28,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            /// TITLE
            Text(
              plan["title"],

              maxLines: 2,

              overflow: TextOverflow.ellipsis,

              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                height: 1.2,
              ),
            ),

            const SizedBox(height: 16),

            /// LOCATION
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 12,
              ),

              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(18),
              ),

              child: Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    size: 20,
                    color: Colors.grey,
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: Text(
                      plan["location"],

                      maxLines: 2,

                      overflow: TextOverflow.ellipsis,

                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            /// DATE
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 12,
              ),

              decoration: BoxDecoration(
                color: _planColor(
                  plan["type"],
                ).withOpacity(0.08),

                borderRadius: BorderRadius.circular(18),
              ),

              child: Row(
                children: [
                  Icon(
                    Icons.calendar_today_rounded,
                    size: 18,
                    color: _planColor(plan["type"]),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: Text(
                      dateText,

                      maxLines: 2,

                      overflow: TextOverflow.ellipsis,

                      style: TextStyle(
                        color: _planColor(plan["type"]),
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ===========================================================
  /// UI
  /// ===========================================================

  @override
  Widget build(BuildContext context) {
    final bool hasPlans = plans.isNotEmpty;

    return Scaffold(
      backgroundColor: const Color(0xFFE9E7FF),

      /// =======================================================
      /// APP BAR
      /// =======================================================

      appBar: AppBar(
        backgroundColor: const Color(0xFFE9E7FF),

        elevation: 0,

        title: const Text(
          "Planner",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),

        /// ===================================================
        /// TOP RIGHT CALENDAR BUTTON
        /// ===================================================

        actions: [
          IconButton(
            onPressed: _openCalendar,
            icon: const Icon(
              Icons.calendar_month_rounded,
              color: Colors.black,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),

      /// =======================================================
      /// BODY
      /// =======================================================

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: hasPlans

              /// =================================================
              /// SHOW BIG SCROLLABLE CARDS
              /// =================================================

              ? ListView.builder(
                  itemCount: plans.length,
                  itemBuilder: (context, index) {
                    return _planCard(
                      plans[index],
                    );
                  },
                )

              /// =================================================
              /// EMPTY STATE
              /// =================================================

              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(
                                0.05,
                              ),
                              blurRadius: 12,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.event_note,
                          size: 55,
                          color: Color(0xFF6C63FF),
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        "No trips or events planned",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Start planning your schedule",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: _openCalendar,
                        icon: const Icon(
                          Icons.calendar_month,
                        ),
                        label: const Text(
                          "Open Planner",
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(
                            0xFF6C63FF,
                          ),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 15,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              22,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}



class PlanDetailsPage extends StatelessWidget {
  final Map<String, dynamic> plan;

  const PlanDetailsPage({
    super.key,
    required this.plan,
  });

  @override
  Widget build(BuildContext context) {
    final bool isTrip = plan["type"] == "Trip";

    final DateTime startDate = plan["date"];

    final DateTime endDate =
        plan["endDate"] ?? plan["date"];

    /// =======================================================
    /// GENERATE ALL DATES
    /// =======================================================

    final List<DateTime> days = [];

    DateTime current = startDate;

    while (!current.isAfter(endDate)) {
      days.add(current);

      current = current.add(
        const Duration(days: 1),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFE9E7FF),

      appBar: AppBar(
        backgroundColor: const Color(0xFFE9E7FF),
        elevation: 0,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),

          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,

            children: [

              /// ===================================================
              /// DETAILS CARD
              /// ===================================================

              Container(
                width: double.infinity,

                padding: const EdgeInsets.all(18),

                decoration: BoxDecoration(
                  color: Colors.white,

                  borderRadius:
                  BorderRadius.circular(28),

                  boxShadow: [
                    BoxShadow(
                      color:
                      Colors.black.withOpacity(0.04),

                      blurRadius: 12,

                      offset: const Offset(0, 5),
                    ),
                  ],
                ),

                child: Row(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,

                  children: [

                    /// ICON

                    Container(
                      height: 56,
                      width: 56,

                      decoration: BoxDecoration(
                        color: (isTrip
                            ? Colors.blue
                            : Colors.purple)
                            .withOpacity(0.10),

                        borderRadius:
                        BorderRadius.circular(18),
                      ),

                      child: Icon(
                        isTrip
                            ? Icons.luggage_rounded
                            : Icons.event_rounded,

                        color: isTrip
                            ? Colors.blue
                            : Colors.purple,

                        size: 28,
                      ),
                    ),

                    const SizedBox(width: 16),

                    /// DETAILS

                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,

                        children: [

                          /// TITLE + LOCATION

                          Row(
                            children: [

                              Expanded(
                                flex: 2,

                                child: Text(
                                  plan["title"],

                                  maxLines: 1,

                                  overflow:
                                  TextOverflow
                                      .ellipsis,

                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight:
                                    FontWeight.w800,
                                  ),
                                ),
                              ),

                              const SizedBox(width: 10),

                              Flexible(
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.end,

                                  children: [

                                    const Icon(
                                      Icons
                                          .location_on_outlined,
                                      size: 16,
                                      color: Colors.grey,
                                    ),

                                    const SizedBox(width: 4),

                                    Flexible(
                                      child: Text(
                                        plan["location"],

                                        maxLines: 1,

                                        overflow:
                                        TextOverflow
                                            .ellipsis,

                                        textAlign:
                                        TextAlign.end,

                                        style: TextStyle(
                                          color: Colors
                                              .grey.shade700,

                                          fontSize: 13,

                                          fontWeight:
                                          FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 12),

                          /// DATE

                          Row(
                            children: [

                              const Icon(
                                Icons
                                    .calendar_today_outlined,
                                size: 16,
                                color: Colors.grey,
                              ),

                              const SizedBox(width: 6),

                              Expanded(
                                child: Text(
                                  isTrip
                                      ? "${DateFormat.yMMMd().format(startDate)} → ${DateFormat.yMMMd().format(endDate)}"
                                      : DateFormat.yMMMMd()
                                      .format(startDate),

                                  style: TextStyle(
                                    color: Colors
                                        .grey.shade700,

                                    fontSize: 13,

                                    fontWeight:
                                    FontWeight.w600,
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
              ),

              const SizedBox(height: 28),

              /// ===================================================
              /// TITLE
              /// ===================================================

              Text(
                isTrip
                    ? "Trip Days"
                    : "Event Schedule",

                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 18),

              /// ===================================================
              /// DAY CARDS
              /// ===================================================

              ListView.builder(
                shrinkWrap: true,

                physics:
                const NeverScrollableScrollPhysics(),

                itemCount: days.length,

                itemBuilder: (context, index) {
                  final day = days[index];

                  return Container(
                    margin:
                    const EdgeInsets.only(
                      bottom: 18,
                    ),

                    padding:
                    const EdgeInsets.all(18),

                    decoration: BoxDecoration(
                      color:
                      Colors.white.withOpacity(0.35),

                      borderRadius:
                      BorderRadius.circular(
                        30,
                      ),

                      border: Border.all(
                        color: Colors.white
                            .withOpacity(0.45),
                      ),
                    ),

                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,

                      children: [

                        /// DATE ON TOP

                        Row(
                          children: [

                            Container(
                              padding:
                              const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),

                              decoration:
                              BoxDecoration(
                                color: (isTrip
                                    ? Colors.blue
                                    : Colors.purple)
                                    .withOpacity(
                                    0.10),

                                borderRadius:
                                BorderRadius
                                    .circular(
                                  14,
                                ),
                              ),

                              child: Text(
                                "Day ${index + 1}",

                                style: TextStyle(
                                  color: isTrip
                                      ? Colors.blue
                                      : Colors.purple,

                                  fontWeight:
                                  FontWeight.bold,
                                ),
                              ),
                            ),

                            const Spacer(),

                            Text(
                              DateFormat("EEEE")
                                  .format(day),

                              style: TextStyle(
                                color: Colors
                                    .grey.shade700,

                                fontWeight:
                                FontWeight.w600,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 18),

                        /// DATE

                        Text(
                          DateFormat("d MMMM")
                              .format(day),

                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 20),

                        /// ===================================================
                        /// RECOMMENDATION CARD
                        /// ===================================================

                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,

                              backgroundColor:
                              Colors.transparent,

                              isScrollControlled: true,

                              builder: (_) {
                                return Container(
                                  padding:
                                  const EdgeInsets
                                      .all(20),

                                  decoration:
                                  const BoxDecoration(
                                    color: Colors.white,

                                    borderRadius:
                                    BorderRadius
                                        .vertical(
                                      top: Radius
                                          .circular(
                                        32,
                                      ),
                                    ),
                                  ),

                                  child: Column(
                                    mainAxisSize:
                                    MainAxisSize.min,

                                    crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,

                                    children: [

                                      /// HANDLE

                                      Center(
                                        child: Container(
                                          width: 55,
                                          height: 5,

                                          decoration:
                                          BoxDecoration(
                                            color: Colors
                                                .grey
                                                .shade300,

                                            borderRadius:
                                            BorderRadius.circular(
                                              20,
                                            ),
                                          ),
                                        ),
                                      ),

                                      const SizedBox(
                                          height: 24),

                                      /// TITLE

                                      const Text(
                                        "Recommended Outfit",

                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight:
                                          FontWeight
                                              .bold,
                                        ),
                                      ),

                                      const SizedBox(
                                          height: 18),

                                      /// FULL IMAGE

                                      ClipRRect(
                                        borderRadius:
                                        BorderRadius
                                            .circular(
                                          24,
                                        ),

                                        child:
                                        Image.network(
                                          "https://images.unsplash.com/photo-1515886657613-9f3515b0c78f",

                                          height: 340,

                                          width: double
                                              .infinity,

                                          fit:
                                          BoxFit.cover,
                                        ),
                                      ),

                                      const SizedBox(
                                          height: 22),

                                      /// DESCRIPTION

                                      Container(
                                        width:
                                        double.infinity,

                                        padding:
                                        const EdgeInsets
                                            .all(18),

                                        decoration:
                                        BoxDecoration(
                                          color:
                                          const Color(
                                            0xFFF5F5FF,
                                          ),

                                          borderRadius:
                                          BorderRadius
                                              .circular(
                                            22,
                                          ),
                                        ),

                                        child: Text(
                                          "This outfit is recommended for today because it balances comfort, layering, and style. It works well for movement throughout the day while maintaining a polished aesthetic suitable for casual and social settings.",

                                          style:
                                          TextStyle(
                                            color: Colors
                                                .grey
                                                .shade800,

                                            fontSize:
                                            15,

                                            height:
                                            1.5,

                                            fontWeight:
                                            FontWeight
                                                .w500,
                                          ),
                                        ),
                                      ),

                                      const SizedBox(
                                          height: 24),
                                    ],
                                  ),
                                );
                              },
                            );
                          },

                          child: Container(
                            width: double.infinity,

                            padding:
                            const EdgeInsets.all(
                              16,
                            ),

                            decoration: BoxDecoration(
                              color: Colors.white
                                  .withOpacity(0.45),

                              borderRadius:
                              BorderRadius.circular(
                                24,
                              ),
                            ),

                            child: Row(
                              children: [

                                /// LEFT SIDE

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,

                                    children: [

                                      Text(
                                        "Today's Outfit",

                                        style:
                                        TextStyle(
                                          color: Colors
                                              .grey
                                              .shade800,

                                          fontSize: 20,

                                          fontWeight:
                                          FontWeight
                                              .bold,
                                        ),
                                      ),

                                      const SizedBox(
                                          height: 10),

                                      Text(
                                        "Minimal layered fit with clean aesthetic and comfortable styling for the day.",

                                        maxLines: 3,

                                        overflow:
                                        TextOverflow
                                            .ellipsis,

                                        style:
                                        TextStyle(
                                          color: Colors
                                              .grey
                                              .shade700,

                                          fontSize: 14,

                                          height: 1.5,
                                        ),
                                      ),

                                      const SizedBox(
                                          height: 18),

                                      Container(
                                        padding:
                                        const EdgeInsets
                                            .symmetric(
                                          horizontal:
                                          14,
                                          vertical: 8,
                                        ),

                                        decoration:
                                        BoxDecoration(
                                          color: (isTrip
                                              ? Colors
                                              .blue
                                              : Colors
                                              .purple)
                                              .withOpacity(
                                              0.10),

                                          borderRadius:
                                          BorderRadius
                                              .circular(
                                            14,
                                          ),
                                        ),

                                        child: Text(
                                          "View Full Recommendation",

                                          style:
                                          TextStyle(
                                            color: isTrip
                                                ? Colors
                                                .blue
                                                : Colors
                                                .purple,

                                            fontWeight:
                                            FontWeight
                                                .bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(width: 16),

                                /// IMAGE PREVIEW

                                ClipRRect(
                                  borderRadius:
                                  BorderRadius
                                      .circular(
                                    22,
                                  ),

                                  child: Image.network(
                                    "https://images.unsplash.com/photo-1515886657613-9f3515b0c78f",

                                    height: 140,
                                    width: 110,

                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}





class DayRecommendationPage extends StatelessWidget {
  final DateTime day;
  final bool isTrip;
  final int dayNumber;

  const DayRecommendationPage({
    super.key,
    required this.day,
    required this.isTrip,
    required this.dayNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9E7FF),

      appBar: AppBar(
        backgroundColor: const Color(0xFFE9E7FF),
        elevation: 0,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              /// ===================================================
              /// HEADER
              /// ===================================================

              Row(
                children: [

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),

                    decoration: BoxDecoration(
                      color: (isTrip
                          ? Colors.blue
                          : Colors.purple)
                          .withOpacity(0.10),

                      borderRadius:
                      BorderRadius.circular(16),
                    ),

                    child: Text(
                      "Day $dayNumber",

                      style: TextStyle(
                        color: isTrip
                            ? Colors.blue
                            : Colors.purple,

                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const Spacer(),

                  Text(
                    DateFormat("d MMM")
                        .format(day),

                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              /// ===================================================
              /// IMAGE CARD
              /// ===================================================

              Container(
                height: 420,
                width: double.infinity,

                decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.circular(32),

                  image: const DecorationImage(
                    image: NetworkImage(
                      "https://images.unsplash.com/photo-1521572267360-ee0c2909d518",
                    ),

                    fit: BoxFit.cover,
                  ),

                  boxShadow: [
                    BoxShadow(
                      color:
                      Colors.black.withOpacity(0.08),

                      blurRadius: 16,

                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              /// ===================================================
              /// DESCRIPTION BOX
              /// ===================================================

              Container(
                width: double.infinity,

                padding: const EdgeInsets.all(22),

                decoration: BoxDecoration(
                  color: Colors.white,

                  borderRadius:
                  BorderRadius.circular(28),

                  boxShadow: [
                    BoxShadow(
                      color:
                      Colors.black.withOpacity(0.04),

                      blurRadius: 12,

                      offset: const Offset(0, 5),
                    ),
                  ],
                ),

                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,

                  children: [

                    const Text(
                      "Why this outfit works",

                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 18),

                    Text(
                      "This outfit is recommended for the day because it balances comfort, weather suitability, occasion styling, and layering compatibility. The color palette and fit make it versatile for both daytime activities and evening plans.",

                      style: TextStyle(
                        height: 1.7,
                        fontSize: 15,
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}