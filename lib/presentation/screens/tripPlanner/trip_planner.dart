import 'package:Kaivon/presentation/widgets/ripple_background_layer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../config/theme/app_colors.dart';

class TripPlanner extends StatefulWidget {
  const TripPlanner({super.key});

  @override
  State<TripPlanner> createState() => _TripPlannerState();
}

class _TripPlannerState extends State<TripPlanner> {
  DateTime focusedDay = DateTime.now();
  DateTime? startDate;
  DateTime? endDate;

  final TextEditingController locationCtrl = TextEditingController();

  final List<String> options = [
    "Mountains",
    "Beach",
    "City",
    "Desert",
    "Forest",
    "Snow",
  ];

  final Set<String> selected = {};

  /* ================= DATE RANGE LOGIC ================= */

  void onDaySelected(DateTime selectedDay, DateTime focused) {
    setState(() {
      focusedDay = focused;

      if (startDate == null || (startDate != null && endDate != null)) {
        startDate = selectedDay;
        endDate = null;
      } else if (selectedDay.isAfter(startDate!)) {
        endDate = selectedDay;
      } else {
        startDate = selectedDay;
        endDate = null;
      }
    });
  }

  bool isInRange(DateTime day) {
    if (startDate == null || endDate == null) return false;
    return day.isAfter(startDate!) && day.isBefore(endDate!);
  }

  /* ================= MULTI SELECT ================= */

  void toggle(String val) {
    setState(() {
      selected.contains(val)
          ? selected.remove(val)
          : selected.add(val);
    });
  }

  /* ================= UI ================= */

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const RippleBackgroundLayer(),
    Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Plan Your Trip"),
      ),
        backgroundColor: Colors.transparent,
    body:
    SingleChildScrollView(
    padding: const EdgeInsets.all(16),

    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    /* ================= CALENDAR ================= */

    Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
    gradient: const LinearGradient(
    colors: [
    AppColors.softTeal700,
    AppColors.softTeal300,
    ],
    ),
    borderRadius: BorderRadius.circular(20),
    ),
    child: TableCalendar(
    firstDay: DateTime.now(),
    lastDay: DateTime(2035),
    focusedDay: focusedDay,

    headerStyle: HeaderStyle(
    formatButtonVisible: false,
    titleCentered: true,
    titleTextStyle: const TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    ),
    leftChevronIcon:
    const Icon(Icons.chevron_left, color: Colors.white),
    rightChevronIcon:
    const Icon(Icons.chevron_right, color: Colors.white),
    ),

    daysOfWeekStyle: const DaysOfWeekStyle(
    weekdayStyle: TextStyle(color: Colors.white70),
    weekendStyle: TextStyle(color: Colors.white70),
    ),

    calendarStyle: const CalendarStyle(
    outsideDaysVisible: false,
    defaultTextStyle: TextStyle(color: Colors.white),
    weekendTextStyle: TextStyle(color: Colors.white),
    ),

    selectedDayPredicate: (day) =>
    isSameDay(startDate, day) ||
    isSameDay(endDate, day),

    onDaySelected: onDaySelected,

    calendarBuilders: CalendarBuilders(
    defaultBuilder: (context, day, focusedDay) {
    final isStart = isSameDay(day, startDate);
    final isEnd = isSameDay(day, endDate);
    final inRange = isInRange(day);

    return Container(
    margin: const EdgeInsets.all(4),
    decoration: BoxDecoration(
    color: isStart || isEnd
    ? Colors.white
        : inRange
    ? Colors.white24
        : Colors.transparent,
    shape: BoxShape.circle,
    ),
    alignment: Alignment.center,
    child: Text(
    '${day.day}',
    style: TextStyle(
    color: isStart || isEnd
    ? Colors.black
        : Colors.white,
    fontWeight:
    isStart || isEnd ? FontWeight.bold : null,
    fontSize: 20
    ),
    ),
    );
    },
    ),
    ),
    ),

    const SizedBox(height: 20),

    /* ================= SELECTED RANGE ================= */

    if (startDate != null)
    Text(
    endDate == null
    ? "From: ${DateFormat.yMMMd().format(startDate!)}"
        : "From: ${DateFormat.yMMMd().format(startDate!)}  →  To: ${DateFormat.yMMMd().format(endDate!)}",
    style: const TextStyle(fontWeight: FontWeight.w500),
    ),

    const SizedBox(height: 25),

    /* ================= MULTI SELECT ================= */

    const Text(
    "Where are you going?",
    style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 20),
    ),

    const SizedBox(height: 10),

    Wrap(
    spacing: 10,
    runSpacing: 10,
    children: options.map((e) {
    final isSelected = selected.contains(e);

    return GestureDetector(
    onTap: () => toggle(e),
    child: AnimatedContainer(
    duration: const Duration(milliseconds: 200),
    padding: const EdgeInsets.symmetric(
    horizontal: 14, vertical: 8),
    decoration: BoxDecoration(
    color: isSelected
    ? Colors.black
        : Colors.grey.shade200,
    borderRadius: BorderRadius.circular(20),
    ),
    child: Text(
    e,
    style: TextStyle(
    color:
    isSelected ? Colors.white : Colors.black,
    ),
    ),
    ),
    );
    }).toList(),
    ),

    const SizedBox(height: 25),

    /* ================= LOCATION ================= */

    const Text(
    "Location",
    style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 20),
    ),

    const SizedBox(height: 10),

    TextField(
    controller: locationCtrl,
    decoration: InputDecoration(
    hintText: "Enter location",
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(14),
    borderSide: BorderSide.none,
    ),
    ),
    ),

    const SizedBox(height: 30),

    /* ================= SUBMIT ================= */

    SizedBox(
    width: double.infinity,
    child: ElevatedButton(
    onPressed: () {
    final data = {
    "from": startDate,
    "to": endDate,
    "types": selected.toList(),
    "location": locationCtrl.text,
    };

    print(data);

    ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text("Trip Planned!")),
    );
    },
    style: ElevatedButton.styleFrom(
    backgroundColor: Colors.black,
    padding:
    const EdgeInsets.symmetric(vertical: 14),
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(14),
    ),
    ),
    child: const Text("Plan Trip",
    style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 20),
    ),
    ),
    ),
    ],
    ),
    )

    ),
    ],
    );
  }
}