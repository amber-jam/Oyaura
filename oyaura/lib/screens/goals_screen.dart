import 'package:flutter/material.dart';
import '../widgets/custom_bottom_nav.dart'; // Adjust path as needed

const _bg = Color(0xFFF3F4F6);
const _phone = Colors.white;
const _panel = Color(0xFFF8F5E9);
const _pink = Color(0xFFFAD3D6);
const _ink = Color(0xFF2B2B2B);
const _muted = Color(0xFF7A8087);
const _g = 16.0;

class GoalMakerUI extends StatefulWidget {
  const GoalMakerUI({super.key});
  @override
  State<GoalMakerUI> createState() => _GoalMakerUIState();
}

class _GoalMakerUIState extends State<GoalMakerUI> {
  final TextEditingController _wantCtrl = TextEditingController();
  final List<String> _goals = ['10  "GOAL"', '6   "GOAL"', '3   "GOAL"', '1   "GOAL"'];

  void _removeGoal(int i) => setState(() => _goals.removeAt(i));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: _phone,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12.withAlpha((0.05 * 255).round()),
                      blurRadius: 24,
                      offset: const Offset(0, 12),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
                  child: Container(
                    color: _panel,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(_g, _g, _g, 12),
                          child: Text(
                            'ACHIEVE YOUR GOALS!',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: _ink.withAlpha((0.85 * 255).round()),
                              letterSpacing: 1.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(_g, 0, _g, 12),
                          child: Container(
                            decoration: BoxDecoration(
                              color: _panel,
                              borderRadius: BorderRadius.circular(22),
                              border: Border.all(color: Colors.black12),
                            ),
                            padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'I WANT TO . . .',
                                  style: TextStyle(
                                    color: _muted.withAlpha((0.9 * 255).round()),
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.6,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                ConstrainedBox(
                                  constraints: const BoxConstraints(minHeight: 110, maxHeight: 160),
                                  child: Scrollbar(
                                    child: TextField(
                                      controller: _wantCtrl,
                                      maxLines: null,
                                      decoration: const InputDecoration(
                                        hintText: 'Write your intention here...',
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView.separated(
                            padding: const EdgeInsets.fromLTRB(_g, 8, _g, _g * 2.5),
                            itemCount: _goals.length,
                            separatorBuilder: (_, _) => const SizedBox(height: 12),
                            itemBuilder: (context, i) => _GoalRow(
                              label: _goals[i],
                              onCheck: () => _removeGoal(i),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const CustomBottomNavBar(currentScreen: 'goals'),
          ],
        ),
      ),
    );
  }
}

class _GoalRow extends StatelessWidget {
  const _GoalRow({required this.label, required this.onCheck});
  final String label;
  final VoidCallback onCheck;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: _pink,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.black12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Row(
        children: [
          const Icon(Icons.star_rounded, color: Colors.amber, size: 24),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w700, color: _ink, letterSpacing: 0.8),
            ),
          ),
          Material(
            color: Colors.green.shade500,
            shape: const StadiumBorder(),
            child: InkWell(
              onTap: onCheck,
              customBorder: const StadiumBorder(),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: Icon(Icons.check_rounded, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}