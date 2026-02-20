import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/custom_bottom_nav.dart';

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
    final month = DateTime.now();

    return Scaffold(
      backgroundColor: const Color(0xFFFFF5F5),
      bottomNavigationBar: const CustomBottomNavBar(currentScreen: 'streak'),
      appBar: AppBar(
        title: const Text('Streak Counter'),
        backgroundColor: const Color(0xFFFFF5F5),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Column(
          children: [
            // Top flame + numbers
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Number
                  Text(
                    '$_currentStreak',
                    style: GoogleFonts.playfairDisplay(fontSize: 40, fontWeight: FontWeight.bold, color: const Color(0xFFDC143C)),
                  ),
                  const SizedBox(width: 12),
                  // Flame
                  const Icon(Icons.local_fire_department_rounded, size: 44, color: Color(0xFFFF6B6B)),
                  const SizedBox(width: 12),
                  // Label
                  Text(
                    _currentStreak == 1 ? 'Day Streak' : 'Day Streaks',
                    style: GoogleFonts.playfairDisplay(fontSize: 18, color: Colors.grey[800]),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // Calendar
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6)],
              ),
              child: Column(
                children: [
                  Text(
                    '${month.year} — ${month.month}',
                    style: GoogleFonts.playfairDisplay(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 12),
                  GridView.count(
                    crossAxisCount: 7,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: _buildCalendar(month),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}