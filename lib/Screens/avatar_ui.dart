import 'package:flutter/material.dart';

const _bg = Color(0xFFF3F4F6);
const _phone = Colors.white;
const _panel = Color(0xFFF8F5E9);
const _mint = Color(0xFFCBE5E4);
const _accent = Color(0xFFF4A3A3);
const _pink = Color(0xFFFAD3D6);
const _ink = Color(0xFF2B2B2B);
const _muted = Color(0xFF7A8087);
const _g = 16.0;

class AvatarUI extends StatefulWidget {
  const AvatarUI({super.key});
  @override
  State<AvatarUI> createState() => _AvatarUIState();
}

class _AvatarUIState extends State<AvatarUI> {
  final _items = List.generate(30, (i) => {'name': 'Item ${i + 1}', 'price': '\$\$\$'});

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
                              padding: const EdgeInsets.symmetric(vertical: _g),
                              child: Container(
                                width: 220,
                                height: 220,
                                decoration: BoxDecoration(
                                  color: Colors.black12.withOpacity(0.05),
                                  shape: BoxShape.circle,
                                ),
                                child: Container(
                                  margin: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Colors.black12.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: const Icon(Icons.image, size: 90, color: _muted),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                color: _pink.withOpacity(0.35),
                                padding: const EdgeInsets.all(_g),
                                child: GridView.builder(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, kBottomNavigationBarHeight + _g * 2),
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    childAspectRatio: 0.88,
                                    crossAxisSpacing: 14,
                                    mainAxisSpacing: 14,
                                  ),
                                  itemCount: _items.length,
                                  itemBuilder: (context, i) => _ShopTile(
                                    name: _items[i]['name'] as String,
                                    price: _items[i]['price'] as String,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    _BottomRoundNav(
                      onHome: () => Navigator.pushNamedAndRemoveUntil(context, '/', (r) => false),
                      onAvatar: () {},
                      onGoals: () => Navigator.pushNamed(context, '/goalmaker'),
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

class _ShopTile extends StatelessWidget {
  const _ShopTile({required this.name, required this.price});
  final String name;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _phone,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.image, size: 36, color: _muted),
          const SizedBox(height: 6),
          Text(name, style: const TextStyle(fontWeight: FontWeight.w700, color: _ink)),
          const SizedBox(height: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('💵', style: TextStyle(fontSize: 12)),
              const SizedBox(width: 4),
              Text(price, style: const TextStyle(color: _muted, fontSize: 12)),
            ],
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
  final VoidCallback onAvatar;
  final VoidCallback onGoals;
  final VoidCallback onStats;
  final VoidCallback onStore;
  final VoidCallback onStreaks;

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
            _NavDot(icon: Icons.home_rounded, onTap: onHome, semantic: 'Home'),
            _NavDot(icon: Icons.emoji_emotions_rounded, onTap: onAvatar, semantic: 'Avatar'),
            _NavDot(icon: Icons.flag_rounded, onTap: onGoals, semantic: 'Goals'),
            _NavDot(icon: Icons.bar_chart_rounded, onTap: onStats, semantic: 'Stats'),
            _NavDot(icon: Icons.storefront_rounded, onTap: onStore, semantic: 'Store'),
            _NavDot(icon: Icons.local_fire_department_rounded, onTap: onStreaks, semantic: 'Streaks'),
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