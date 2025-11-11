import 'package:flutter/material.dart';

const _bg = Color(0xFFF3F4F6);
const _phone = Colors.white;
const _panel = Color(0xFFF8F5E9);
const _pink = Color(0xFFFAD3D6);
const _accent = Color(0xFFF4A3A3);
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
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Container(
              margin: const EdgeInsets.all(_g),
              decoration: BoxDecoration(
                color: _phone,
                borderRadius: BorderRadius.circular(28),
                boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 24, offset: Offset(0, 12))],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(28),
                child: Column(
                  children: [
                    Container(height: 24, color: _phone),
                    Expanded(
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
                                  color: _ink.withOpacity(0.85),
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
                                        color: _muted.withOpacity(0.9),
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
                                separatorBuilder: (_, __) => const SizedBox(height: 12),
                                itemBuilder: (context, i) {
                                  return _GoalRow(label: _goals[i], onCheck: () => _removeGoal(i));
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    _BottomRoundNav(
                      onHome: () => Navigator.pushNamedAndRemoveUntil(context, '/', (r) => false),
                      onAvatar: () => Navigator.pushNamed(context, '/avatar'),   // ← fixed here
                      onGoals: () {},                                            // already here
                      onStats: () {},
                      onStore: () {},
                      onStreaks: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
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

class _BottomRoundNav extends StatelessWidget {
  const _BottomRoundNav({
    required this.onHome,
    required this.onAvatar,
    required this.onGoals,
    required this.onStats,
    required this.onStore,
    required this.onStreaks,
  });

  final VoidCallback onHome;
  final VoidCallback onAvatar; // 2nd
  final VoidCallback onGoals;  // 3rd
  final VoidCallback onStats;  // 4th
  final VoidCallback onStore;  // 5th
  final VoidCallback onStreaks; // 6th

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        color: _accent,
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: _g),
        child: Row(
          children: [
            _NavDot(icon: Icons.home_rounded, semantic: 'Home', onTap: onHome),
            _NavDot(icon: Icons.emoji_emotions_rounded, semantic: 'Avatar', onTap: onAvatar),
            _NavDot(icon: Icons.flag_rounded, semantic: 'Goals', onTap: onGoals),
            _NavDot(icon: Icons.bar_chart_rounded, semantic: 'Stats', onTap: onStats),
            _NavDot(icon: Icons.storefront_rounded, semantic: 'Store', onTap: onStore),
            _NavDot(icon: Icons.local_fire_department_rounded, semantic: 'Streaks', onTap: onStreaks),
          ],
        ),
      ),
    );
  }
}

class _NavDot extends StatelessWidget {
  const _NavDot({required this.icon, required this.semantic, required this.onTap});
  final IconData icon;
  final String semantic;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Semantics(
        label: semantic,
        button: true,
        child: InkResponse(
          onTap: onTap,
          radius: 28,
          child: CircleAvatar(
            radius: 22,
            backgroundColor: Colors.white.withOpacity(0.85),
            child: Icon(icon, color: _ink),
          ),
        ),
      ),
    );
  }
}