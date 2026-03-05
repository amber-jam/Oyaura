import '../widgets/mobile_layout.dart';
import 'package:flutter/material.dart';

const _bg = Color(0xFFF3F4F6);
const _phone = Colors.white;
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
  // --- Master Data List (28 Unique Avatars) ---
  final List<Map<String, String>> _items = [
    {'name': 'Rickey', 'price': '100', 'image': 'assets/avatars/avatar1.png'},
    {'name': 'Joy', 'price': '150', 'image': 'assets/avatars/avatar2.jpg'},
    {'name': 'Alex', 'price': '200', 'image': 'assets/avatars/avatar3.png'},
    {'name': 'Shawn', 'price': '250', 'image': 'assets/avatars/avatar4.png'},
    {'name': 'Tony', 'price': '300', 'image': 'assets/avatars/avatar5.png'},
    {'name': 'Wanda', 'price': '350', 'image': 'assets/avatars/avatar6.png'},
    {'name': 'Lily', 'price': '400', 'image': 'assets/avatars/avatar7.png'},
    {'name': 'Evan', 'price': '450', 'image': 'assets/avatars/avatar8.png'},
    {'name': 'Happy Bot', 'price': '500', 'image': 'assets/avatars/avatar9.png'},
    {'name': 'Alien Overlord', 'price': '999', 'image': 'assets/avatars/avatar10.png'},
    {'name': 'Grizzly Rage', 'price': '600', 'image': 'assets/avatars/avatar11.png'},
    {'name': 'Sleepy Bunny', 'price': '250', 'image': 'assets/avatars/avatar12.png'},
    {'name': 'Pro Gamer', 'price': '400', 'image': 'assets/avatars/avatar13.png'},
    {'name': 'MVP Sports', 'price': '300', 'image': 'assets/avatars/avatar14.png'},
    {'name': 'Top Student', 'price': '200', 'image': 'assets/avatars/avatar15.png'},
    {'name': 'Cyber Soldier', 'price': '850', 'image': 'assets/avatars/avatar16.png'},
    {'name': 'Spring Vase', 'price': '150', 'image': 'assets/avatars/avatar17.png'},
    {'name': 'Cool Roach', 'price': '777', 'image': 'assets/avatars/avatar18.png'},
    {'name': 'Shocked Corgi', 'price': '550', 'image': 'assets/avatars/avatar19.png'},
    {'name': 'Ninja Worm', 'price': '420', 'image': 'assets/avatars/avatar20.png'},
    {'name': 'Calico Cat', 'price': '300', 'image': 'assets/avatars/avatar21.png'},
    {'name': 'Tiny Penguin', 'price': '350', 'image': 'assets/avatars/avatar22.png'},
    {'name': 'Sushi Roll', 'price': '200', 'image': 'assets/avatars/avatar23.png'},
    {'name': 'Dino Friend', 'price': '450', 'image': 'assets/avatars/avatar24.png'},
    {'name': 'Space Rocket', 'price': '700', 'image': 'assets/avatars/avatar25.png'},
    {'name': 'Magic Potion', 'price': '500', 'image': 'assets/avatars/avatar26.png'},
    {'name': 'Sunny Flower', 'price': '150', 'image': 'assets/avatars/avatar27.png'},
    {'name': 'Golden Crown', 'price': '1000', 'image': 'assets/avatars/avatar28.png'},
  ];

  late String _selectedAvatar;

  @override
  void initState() {
    super.initState();
    _selectedAvatar = _items[0]['image']!; // Default to first avatar
  }

  @override
  Widget build(BuildContext context) {
    return MobileLayout(
      currentScreen: 'avatar',
      child: SafeArea(
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
                  child: Stack(
                    children: [
                      Positioned(
                        left: _g,
                        top: _g,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 22),
                          color: _muted.withAlpha((0.9 * 255).round()),
                          onPressed: () => Navigator.maybePop(context),
                        ),
                      ),
                      Positioned.fill(
                        top: 56,
                        bottom: 96,
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.fromLTRB(_g, _g, _g, _g * 2),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // --- MAIN AVATAR PREVIEW ---
                              Container(
                                width: 220,
                                height: 220,
                                decoration: BoxDecoration(
                                  color: Colors.black12.withAlpha((0.05 * 255).round()),
                                  shape: BoxShape.circle,
                                ),
                                child: Container(
                                  margin: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Colors.black12.withAlpha((0.1 * 255).round()),
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(18),
                                    child: Image.asset(
                                      _selectedAvatar,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) =>
                                          const Icon(Icons.person, size: 90, color: _muted),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: _g * 1.5),
                              // --- AVATAR SELECTION GRID ---
                              Container(
                                decoration: BoxDecoration(
                                  color: _pink.withAlpha((0.35 * 255).round()),
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                padding: const EdgeInsets.all(_g),
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    childAspectRatio: 0.82,
                                    crossAxisSpacing: 14,
                                    mainAxisSpacing: 14,
                                  ),
                                  itemCount: _items.length,
                                  itemBuilder: (context, i) {
                                    final item = _items[i];
                                    return _ShopTile(
                                      name: item['name']!,
                                      price: item['price']!,
                                      image: item['image']!,
                                      isSelected: _selectedAvatar == item['image'],
                                      onTap: () {
                                        setState(() {
                                          _selectedAvatar = item['image']!;
                                        });
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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

class _ShopTile extends StatelessWidget {
  const _ShopTile({
    required this.name,
    required this.price,
    required this.image,
    required this.isSelected,
    required this.onTap,
  });

  final String name;
  final String price;
  final String image;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? _pink.withAlpha((0.3 * 255).round()) : _phone,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isSelected ? _pink : Colors.black12,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    image,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.person, size: 36, color: _muted),
                  ),
                ),
              ),
            ),
            Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.w700, color: _ink, fontSize: 12),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('💵', style: TextStyle(fontSize: 10)),
                const SizedBox(width: 4),
                Text(price, style: const TextStyle(color: _muted, fontSize: 10)),
              ],
            ),
            const SizedBox(height: 6),
          ],
        ),
      ),
    );
  }
}