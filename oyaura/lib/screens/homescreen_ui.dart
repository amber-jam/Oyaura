import 'package:flutter/material.dart';
import '../widgets/custom_bottom_nav.dart'; // Adjust path as needed

const _bg = Color(0xFFF3F4F6);
const _phoneShell = Colors.white;
const _panel = Color(0xFFF8F5E9);
const _accent = Color(0xFFF4A3A3);
const _mint = Color(0xFFCBE5E4);
const _ink = Color(0xFF2B2B2B);
const _muted = Color(0xFF7A8087);
const _g = 16.0;

class HomeScreenUI extends StatelessWidget {
  const HomeScreenUI({super.key});

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
                  color: _phoneShell,
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
                    child: Stack(
                      children: [
                        Positioned(
                          left: _g,
                          top: _g,
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 22),
                            color: _muted,
                            onPressed: () => Navigator.maybePop(context),
                          ),
                        ),
                        Positioned(
                          right: _g,
                          top: _g,
                          child: _ProfilePill(onTap: () {}),
                        ),
                        Positioned.fill(
                          top: 56,
                          bottom: 96,
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.fromLTRB(_g, _g, _g, _g * 2),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                _AvatarHero(onTap: () => Navigator.pushNamed(context, '/avatar')),
                                const SizedBox(height: _g * 1.5),
                                const _StatsAndMessageCard(),
                                const SizedBox(height: _g),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const CustomBottomNavBar(currentScreen: 'home'),
          ],
        ),
      ),
    );
  }
}

class _ProfilePill extends StatelessWidget {
  const _ProfilePill({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _mint,
      shape: const StadiumBorder(),
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        customBorder: const StadiumBorder(),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: Row(
            children: [
              Icon(Icons.person, size: 18, color: _ink),
              SizedBox(width: 6),
              Text('PROFILE', style: TextStyle(fontWeight: FontWeight.w700, letterSpacing: 1.1, color: _ink)),
            ],
          ),
        ),
      ),
    );
  }
}

class _AvatarHero extends StatelessWidget {
  const _AvatarHero({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 280,
            height: 280,
            decoration: BoxDecoration(color:  Colors.black12.withAlpha((0.05 * 255).round()), shape: BoxShape.circle),
          ),
          Container(
            width: 210,
            height: 210,
            decoration: BoxDecoration(color: Colors.black12.withAlpha((0.12 * 255).round()), borderRadius: BorderRadius.circular(16)),
            child: const Icon(Icons.image, size: 72, color: _muted),
          ),
        ],
      ),
    );
  }
}

class _StatsAndMessageCard extends StatelessWidget {
  const _StatsAndMessageCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(_g),
      decoration: BoxDecoration(
        color: _mint,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.black12, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('“INSPIRATIONAL MESSAGE”',
                    style: TextStyle(fontWeight: FontWeight.w800, letterSpacing: 1.0, color: _ink)),
                SizedBox(height: 12),
                _StatLine(label: '• STAT'),
                SizedBox(height: 8),
                _StatLine(label: '• STAT'),
                SizedBox(height: 8),
                _StatLine(label: '• STAT'),
              ],
            ),
          ),
          SizedBox(width: _g),
          _CircleChartPlaceholder(),
        ],
      ),
    );
  }
}

class _StatLine extends StatelessWidget {
  const _StatLine({required this.label});
  final String label;
  @override
  Widget build(BuildContext context) {
    return Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: _ink));
  }
}

class _CircleChartPlaceholder extends StatelessWidget {
  const _CircleChartPlaceholder();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 128,
      height: 128,
      decoration: BoxDecoration(
        color: _panel,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black12, width: 1),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))],
      ),
      child: Center(
        child: Text('CHART',
            style: TextStyle(color: _muted.withAlpha((0.9 * 255).round()), fontWeight: FontWeight.w800, letterSpacing: 1.0)),
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
      decoration:
          const BoxDecoration(color: _accent, borderRadius: BorderRadius.vertical(top: Radius.circular(18))),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: _g),
        child: Row(
          children: const [
            _NavDot(icon: Icons.home_rounded, semantic: 'Home', withAction: true),
            _NavDot(icon: Icons.emoji_emotions_rounded, semantic: 'Avatar', withAction: true),
            _NavDot(icon: Icons.flag_rounded, semantic: 'Goals', withAction: true),
            _NavDot(icon: Icons.bar_chart_rounded, semantic: 'Stats', withAction: true),
            _NavDot(icon: Icons.storefront_rounded, semantic: 'Store', withAction: true),
            _NavDot(icon: Icons.local_fire_department_rounded, semantic: 'Streaks', withAction: true),
          ],
        ),
      ),
    );
  }
}

class _NavDot extends StatelessWidget {
  const _NavDot({required this.icon, required this.semantic, this.withAction = false});
  final IconData icon;
  final String semantic;
  final bool withAction;

  @override
  Widget build(BuildContext context) {
    VoidCallback action = () {};
    switch (semantic) {
      case 'Home':
        action = () => Navigator.pushNamedAndRemoveUntil(context, '/', (r) => false);
        break;
      case 'Avatar':
        action = () => Navigator.pushNamed(context, '/avatar');
        break;
      case 'Goals':
        action = () => Navigator.pushNamed(context, '/goalmaker');
        break;
      case 'Stats':
        action = () {};
        break;
      case 'Store':
        action = () {};
        break;
      case 'Streaks':
        action = () {};
        break;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Semantics(
        label: semantic,
        button: true,
        child: InkResponse(
          onTap: withAction ? action : null,
          radius: 28,
          child: CircleAvatar(
            radius: 22,
            backgroundColor: Colors.white.withAlpha((0.85 * 255).round()),
            child: Icon(icon, color: _ink),
          ),
        ),
      ),
    );
  }
}