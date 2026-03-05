import 'package:flutter/material.dart';
import '../widgets/custom_bottom_nav.dart';

const _bg = Color(0xFFF3F4F6);
const _phone = Colors.white;
const _ink = Color(0xFF2B2B2B);
const _muted = Color(0xFF7A8087);
const _g = 16.0;

class AvatarUI extends StatefulWidget {
  const AvatarUI({super.key});
  @override
  State<AvatarUI> createState() => _AvatarUIState();
}

class _AvatarUIState extends State<AvatarUI> {
  // --- Master Data List (All 28 Avatars) ---
  final List<Map<String, dynamic>> _items = [
    {'name': 'Rickey', 'price': '100', 'image': 'assets/Avatar_2.0/avatar1.png', 'color': Color(0xFFE0F2F1)},
    {'name': 'Joy', 'price': '150', 'image': 'assets/Avatar_2.0/avatar2.jpg', 'color': Color(0xFFFFF9C4)},
    {'name': 'Alex', 'price': '200', 'image': 'assets/Avatar_2.0/avatar3.png', 'color': Color(0xFFF3E5F5)},
    {'name': 'Shawn', 'price': '250', 'image': 'assets/Avatar_2.0/avatar4.png', 'color': Color(0xFFE3F2FD)},
    {'name': 'Tony', 'price': '300', 'image': 'assets/Avatar_2.0/avatar5.png', 'color': Color(0xFFE8F5E9)},
    {'name': 'Wanda', 'price': '350', 'image': 'assets/Avatar_2.0/avatar6.png', 'color': Color(0xFFFCE4EC)},
    {'name': 'Lily', 'price': '400', 'image': 'assets/Avatar_2.0/avatar7.png', 'color': Color(0xFFE0F7FA)},
    {'name': 'Evan', 'price': '450', 'image': 'assets/Avatar_2.0/avatar8.png', 'color': Color(0xFFFFF3E0)},
    {'name': 'Happy Bot', 'price': '500', 'image': 'assets/Avatar_2.0/avatar9.png', 'color': Color(0xFFECEFF1)},
    {'name': 'Alien Overlord', 'price': '999', 'image': 'assets/Avatar_2.0/avatar10.png', 'color': Color(0xFFF1F8E9)},
    {'name': 'Grizzly Rage', 'price': '600', 'image': 'assets/Avatar_2.0/avatar11.png', 'color': Color(0xFFD7CCC8)},
    {'name': 'Bunny', 'price': '250', 'image': 'assets/Avatar_2.0/avatar12.png', 'color': Color(0xFFF8BBD0)},
    {'name': 'Pro Gamer', 'price': '400', 'image': 'assets/Avatar_2.0/avatar13.png', 'color': Color(0xFFC5CAE9)},
    {'name': 'MVP Sports', 'price': '300', 'image': 'assets/Avatar_2.0/avatar14.png', 'color': Color(0xFFFFCCBC)},
    {'name': 'Top Student', 'price': '200', 'image': 'assets/Avatar_2.0/avatar15.png', 'color': Color(0xFFDCEDC8)},
    {'name': 'T10-30', 'price': '850', 'image': 'assets/Avatar_2.0/avatar16.png', 'color': Color(0xFFCFD8DC)},
    {'name': 'Spring Vase', 'price': '150', 'image': 'assets/Avatar_2.0/avatar17.png', 'color': Color(0xFFB2EBF2)},
    {'name': 'Roach', 'price': '777', 'image': 'assets/Avatar_2.0/avatar18.png', 'color': Color(0xFFD1C4E9)},
    {'name': 'Shocked Corgi', 'price': '550', 'image': 'assets/Avatar_2.0/avatar19.png', 'color': Color(0xFFFFE0B2)},
    {'name': 'Worm', 'price': '420', 'image': 'assets/Avatar_2.0/avatar20.png', 'color': Color(0xFFC8E6C9)},
    {'name': 'Gambino', 'price': '300', 'image': 'assets/Avatar_2.0/avatar21.png', 'color': Color(0xFFF5F5F5)},
    {'name': 'Tiny Penguin', 'price': '350', 'image': 'assets/Avatar_2.0/avatar22.png', 'color': Color(0xFFBBDEFB)},
    {'name': 'Sci Fli', 'price': '200', 'image': 'assets/Avatar_2.0/avatar23.png', 'color': Color(0xFFE1BEE7)},
    {'name': 'Moon', 'price': '450', 'image': 'assets/Avatar_2.0/avatar24.png', 'color': Color(0xFFDCEDC8)},
    {'name': 'Fin', 'price': '700', 'image': 'assets/Avatar_2.0/avatar25.png', 'color': Color(0xFFB3E5FC)},
    {'name': 'Lazlo', 'price': '???', 'image': 'assets/Avatar_2.0/avatar26.png', 'color': Color(0xFFB2DFDB)},
    {'name': 'Sunny', 'price': '150', 'image': 'assets/Avatar_2.0/avatar27.png', 'color': Color(0xFFFFF9C4)},
    {'name': 'Chubs', 'price': '1000', 'image': 'assets/Avatar_2.0/avatar28.png', 'color': Color(0xFFFFECB3)},
  ];

  late String _selectedAvatar;
  late Color _selectedBgColor;

  @override
  void initState() {
    super.initState();
    _selectedAvatar = _items[0]['image']!;
    _selectedBgColor = _items[0]['color']!;
  }

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
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      top: 40,
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(_g),
                        child: Column(
                          children: [
                            // Big Preview Circle
                            Container(
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(
                                color: _selectedBgColor,
                                shape: BoxShape.circle,
                              ),
                              child: ClipOval(
                                child: Image.asset(
                                  _selectedAvatar,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            // The Grid
                            GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 0.8,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                              ),
                              itemCount: _items.length,
                              itemBuilder: (context, i) {
                                final item = _items[i];
                                final isSelected = _selectedAvatar == item['image'];
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedAvatar = item['image'];
                                      _selectedBgColor = item['color'];
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: _phone,
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                        color: isSelected ? _ink : Colors.black12,
                                        width: isSelected ? 2 : 1,
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            margin: const EdgeInsets.all(6),
                                            decoration: BoxDecoration(
                                              color: item['color'],
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(12),
                                              child: Image.asset(
                                                item['image'],
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Text(item['name'], style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                                        Text('\$${item['price']}', style: const TextStyle(fontSize: 9, color: _muted)),
                                        const SizedBox(height: 4),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const CustomBottomNavBar(currentScreen: 'avatar'),
          ],
        ),
      ),
    );
  }
}