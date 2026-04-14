import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

import '../services/avatar_preview_store.dart';
import '../widgets/mobile_layout.dart';

const _phoneShell = Colors.white;
const _pinkBg = Color(0xFFFAD3D6);
const _greenCard = Color(0xFFBFE1D7);
const _mint = Color(0xFFCBE5E4);
const _panel = Color(0xFFF8F5E9);
const _ink = Color(0xFF2B2B2B);
const _muted = Color(0xFF7A8087);
const _textPink = Color(0xFFF3B6C4);
const _gold = Color(0xFFF6D66B);
const _g = 16.0;

class HomeScreenUI extends StatefulWidget {
  const HomeScreenUI({super.key});

  @override
  State<HomeScreenUI> createState() => _HomeScreenUIState();
}

class _HomeScreenUIState extends State<HomeScreenUI> {
  String _quote = 'Loading inspiration...';

  @override
  void initState() {
    super.initState();
    _fetchQuote();
  }

  Future<void> _fetchQuote() async {
    try {
      final response = await http.get(
        Uri.parse('https://api.quotable.io/random?maxLength=90'),
      );

      if (!mounted) return;

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        final content = (data['content'] ?? '').toString().trim();
        setState(() {
          _quote = content.isNotEmpty
              ? content
              : 'Stay focused. You are doing better than you think.';
        });
      } else {
        setState(() {
          _quote = 'Stay focused. You are doing better than you think.';
        });
      }
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _quote = 'Stay focused. You are doing better than you think.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MobileLayout(
      currentScreen: 'home',
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: _phoneShell,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(28),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12.withAlpha(13),
                      blurRadius: 24,
                      offset: const Offset(0, 12),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(28),
                  ),
                  child: Container(
                    color: _pinkBg,
                    child: Stack(
                      children: [
                        Positioned(
                          left: _g,
                          top: _g,
                          child: IconButton(
                            icon: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              size: 22,
                            ),
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
                            padding: const EdgeInsets.fromLTRB(12, 8, 12, 34),
                            child: Column(
                              children: [
                                ValueListenableBuilder<AvatarPreviewData>(
                                  valueListenable: AvatarPreviewStore.instance,
                                  builder: (context, avatar, _) {
                                    return _AvatarHero(
                                      avatar: avatar,
                                      onTap: () =>
                                          Navigator.pushNamed(context, '/avatar'),
                                    );
                                  },
                                ),
                                const SizedBox(height: 10),
                                ValueListenableBuilder<int>(
                                  valueListenable: AvatarPreviewStore.coins,
                                  builder: (context, coins, _) {
                                    return _StatsAndMessageCard(
                                      quote: _quote,
                                      coins: coins,
                                    );
                                  },
                                ),
                                const SizedBox(height: 18),
                                const _CircleChartSection(),
                                const SizedBox(height: 28),
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: Row(
            children: [
              const Icon(Icons.person, size: 18, color: _ink),
              const SizedBox(width: 6),
              Text(
                'PROFILE',
                style: GoogleFonts.dancingScript(
                  fontSize: 23,
                  fontWeight: FontWeight.w700,
                  color: _textPink,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AvatarHero extends StatelessWidget {
  const _AvatarHero({
    required this.avatar,
    required this.onTap,
  });

  final AvatarPreviewData avatar;
  final VoidCallback onTap;

  Widget _layer(String? path) {
    if (path == null) return const SizedBox.shrink();

    return Positioned.fill(
      child: Image.asset(
        path,
        fit: BoxFit.contain,
        errorBuilder: (_, __, ___) => const SizedBox.shrink(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: double.infinity,
        height: 255,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                color: Colors.black12.withAlpha(13),
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                color: Colors.black12.withAlpha(18),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    _layer(avatar.hairBack),
                    _layer(avatar.baseBody),
                    _layer(avatar.eyes),
                    _layer(avatar.brows),
                    _layer(avatar.lashes),
                    _layer(avatar.mouth),
                    _layer(avatar.dress),
                    _layer(avatar.top),
                    _layer(avatar.bottom),
                    _layer(avatar.shoes),
                    _layer(avatar.gloves),
                    _layer(avatar.beard),
                    _layer(avatar.hairFront),
                    _layer(avatar.bangs),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatsAndMessageCard extends StatelessWidget {
  const _StatsAndMessageCard({
    required this.quote,
    required this.coins,
  });

  final String quote;
  final int coins;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
      decoration: BoxDecoration(
        color: _greenCard,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.black54, width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            quote,
            textAlign: TextAlign.center,
            style: GoogleFonts.dancingScript(
              fontSize: 27,
              height: 1.2,
              fontWeight: FontWeight.w700,
              color: _textPink,
            ),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 20),
          _StatRow(
            label: 'Streak Count :\nDay 1/7',
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.star_rounded, color: _gold, size: 28),
                SizedBox(width: 8),
                Text(
                  'Good Job!',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                    color: _textPink,
                  ),
                ),
                SizedBox(width: 8),
                Icon(Icons.star_rounded, color: _gold, size: 28),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _StatRow(
            label: 'Currency Count : $coins coins 💵',
          ),
        ],
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  const _StatRow({
    required this.label,
    this.trailing,
  });

  final String label;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            label,
            style: GoogleFonts.dancingScript(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: _textPink,
            ),
          ),
        ),
        if (trailing != null) ...[
          const SizedBox(width: 10),
          Flexible(child: trailing!),
        ],
      ],
    );
  }
}

class _CircleChartSection extends StatelessWidget {
  const _CircleChartSection();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 175,
        height: 175,
        decoration: BoxDecoration(
          color: _panel,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.black87, width: 1.5),
        ),
        child: CustomPaint(
          painter: _PieChartPainter(),
          child: Center(
            child: Text(
              'CHART',
              style: GoogleFonts.dancingScript(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: _textPink,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PieChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 18
      ..strokeCap = StrokeCap.round;

    stroke.color = const Color(0xFFF3B6C4).withAlpha(210);
    canvas.drawArc(rect.deflate(20), -1.4, 1.7, false, stroke);

    stroke.color = const Color(0xFFBFE1D7).withAlpha(230);
    canvas.drawArc(rect.deflate(20), 0.4, 2.0, false, stroke);

    stroke.color = const Color(0xFFF6D66B).withAlpha(230);
    canvas.drawArc(rect.deflate(20), 2.7, 1.1, false, stroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}