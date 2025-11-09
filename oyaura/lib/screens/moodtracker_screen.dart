import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MoodEntry {
  final String emoji;
  final String note;
  final DateTime date;
  final double intensity;
  final List<String> activities;

  MoodEntry({
    required this.emoji,
    required this.note,
    required this.date,
    required this.intensity,
    required this.activities,
  });

  Map<String, dynamic> toJson() => {
    'emoji': emoji,
    'note': note,
    'date': date.toIso8601String(),
    'intensity': intensity,
    'activities': activities,
  };
}

class MoodTrackerScreen extends StatefulWidget {
  const MoodTrackerScreen({super.key});

  @override
  State<MoodTrackerScreen> createState() => _MoodTrackerScreenState();
}

class _MoodTrackerScreenState extends State<MoodTrackerScreen> {
  String? selectedEmoji;
  DateTime selectedDate = DateTime.now();
  double intensity = 3;
  final TextEditingController _noteController = TextEditingController();
  final List<String> activityOptions = ['Work', 'Social', 'Rest', 'Exercise', 'Creative', 'Family'];
  final List<String> selectedActivities = [];
  final List<MoodEntry> moodLog = [];

  Future<void> pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void handleSubmit() {
    if (selectedEmoji == null || _noteController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a mood and enter a note.')),
      );
      return;
    }

    final entry = MoodEntry(
      emoji: selectedEmoji!,
      note: _noteController.text.trim(),
      date: selectedDate,
      intensity: intensity,
      activities: List.from(selectedActivities),
    );

    setState(() {
      moodLog.add(entry);
      selectedEmoji = null;
      _noteController.clear();
      intensity = 3;
      selectedActivities.clear();
      selectedDate = DateTime.now();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Mood saved!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final emojis = ['😂', '😊', '😐', '😢', '😠'];

    return Scaffold(
      backgroundColor: const Color(0xFFFFF5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF5F5),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.home, color: Color(0xFFDC143C)),
            onPressed: () {
              Navigator.pushNamed(context, '/');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'How do you feel?',
              style: GoogleFonts.playfairDisplay(
                fontSize: 28,
                fontWeight: FontWeight.w600,
                color: const Color(0xFFDC143C),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: emojis.map((emoji) {
                final isSelected = selectedEmoji == emoji;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedEmoji = emoji;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected ? const Color(0xFFDC143C) : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: Text(
                      emoji,
                      style: const TextStyle(fontSize: 32),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 32),
            TextField(
              controller: _noteController,
              decoration: InputDecoration(
                labelText: 'I feel...',
                labelStyle: GoogleFonts.playfairDisplay(
                  fontSize: 18,
                  color: Colors.grey[700],
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: const Color(0xFFFFE5E5),
              ),
              maxLines: 3,
              style: GoogleFonts.playfairDisplay(fontSize: 16),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Text(
                  'Date:',
                  style: GoogleFonts.playfairDisplay(fontSize: 16),
                ),
                const SizedBox(width: 12),
                Text(
                  '${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}',
                  style: GoogleFonts.playfairDisplay(fontSize: 16),
                ),
                const SizedBox(width: 12),
                TextButton(
                  onPressed: pickDate,
                  child: const Text('Change'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mood Intensity:',
                  style: GoogleFonts.playfairDisplay(fontSize: 16),
                ),
                Slider(
                  value: intensity,
                  min: 1,
                  max: 5,
                  divisions: 4,
                  label: intensity.toStringAsFixed(0),
                  activeColor: const Color(0xFFDC143C),
                  onChanged: (value) {
                    setState(() {
                      intensity = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Activities:',
                  style: GoogleFonts.playfairDisplay(fontSize: 16),
                ),
                Wrap(
                  spacing: 8,
                  children: activityOptions.map((activity) {
                    final isSelected = selectedActivities.contains(activity);
                    return ChoiceChip(
                      label: Text(activity),
                      selected: isSelected,
                      selectedColor: const Color(0xFFFFA4A4),
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            selectedActivities.add(activity);
                          } else {
                            selectedActivities.remove(activity);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
            const SizedBox(height: 32),
            OutlinedButton(
              onPressed: handleSubmit,
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFFDC143C),
                side: const BorderSide(color: Color(0xFFDC143C), width: 2),
                padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                'Submit',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFFDC143C),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}