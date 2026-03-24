import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; 
import 'package:shared_preferences/shared_preferences.dart'; 
import '../widgets/mobile_layout.dart'; // <-- Brought your layout wrapper back!

class StreakScreen extends StatefulWidget {
  const StreakScreen({super.key});

  @override
  State<StreakScreen> createState() => _StreakScreenState();
}

class _StreakScreenState extends State<StreakScreen> {
  Set<DateTime> _loggedDates = {};
  int _currentStreak = 0;

  @override
  void initState() {
    super.initState();
    _loadLoggedDates();
  }

  Future<void> _loadLoggedDates() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList('mood_dates') ?? <String>[];
    final parsed = list.map((s) {
      try {
        final parts = s.split('T')[0];
        return DateTime.parse(parts);
      } catch (_) {
        return null;
      }
    }).whereType<DateTime>().map((d) => DateTime(d.year, d.month, d.day)).toSet();

    setState(() {
      _loggedDates = parsed;
      _currentStreak = _computeStreak(_loggedDates);
    });
  }

  int _computeStreak(Set<DateTime> dates) {
    if (dates.isEmpty) return 0;
    DateTime day = DateTime.now();
    int streak = 0;
    while (true) {
      final check = DateTime(day.year, day.month, day.day);
      if (dates.contains(check)) {
        streak += 1;
        day = day.subtract(const Duration(days: 1));
      } else {
        break;
      }
    }
    return streak;
  }

  List<Widget> _buildCalendar(DateTime month) {
    final firstOfMonth = DateTime(month.year, month.month, 1);
    final daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    final firstWeekday = firstOfMonth.weekday % 7; // Make Sunday=0

    final widgets = <Widget>[];
    // Weekday headers
    const weekdayNames = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
    for (final w in weekdayNames) {
      widgets.add(Center(child: Text(w, style: GoogleFonts.playfairDisplay(fontWeight: FontWeight.w600))));
    }

    // Empty leading cells
    for (int i = 0; i < firstWeekday; i++) {
      widgets.add(const SizedBox.shrink());
    }

    for (int d = 1; d <= daysInMonth; d++) {
      final date = DateTime(month.year, month.month, d);
      final key = DateTime(date.year, date.month, date.day);
      final logged = _loggedDates.contains(key);

      widgets.add(Container(
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: logged ? const Color(0xFFFFA4A4) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFF0DADA)),
        ),
        alignment: Alignment.center,
        child: Text(d.toString(), style: GoogleFonts.playfairDisplay(color: logged ? Colors.white : Colors.black)),
      ));
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    // Replaced Scaffold with MobileLayout and built the actual UI!
    return MobileLayout(
      currentScreen: 'streak',
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Your Consistency',
              textAlign: TextAlign.center,
              style: GoogleFonts.playfairDisplay(
                fontSize: 28,
                fontWeight: FontWeight.w600,
                color: const Color(0xFFDC143C),
              ),
            ),
            const SizedBox(height: 24),
            
            // The Streak Counter Box
            Container(
              padding: const EdgeInsets.symmetric(vertical: 32),
              decoration: BoxDecoration(
                color: const Color(0xFFFFE5E5),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFFFA4A4)),
              ),
              child: Column(
                children: [
                  Text(
                    '$_currentStreak', // Using the actual calculated streak variable
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 72,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFDC143C),
                    ),
                  ),
                  Text(
                    'Day Streak!',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            
            Text(
              'This Month',
              style: GoogleFonts.playfairDisplay(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 16),

            // The Calendar Grid
            GridView.count(
              shrinkWrap: true, // Needed inside SingleChildScrollView
              physics: const NeverScrollableScrollPhysics(), // Disables inner scrolling
              crossAxisCount: 7, // 7 days in a week
              children: _buildCalendar(now), // Calling your teammate's calendar function!
            ),
          ],
        ),
      ),
    );
  }
}