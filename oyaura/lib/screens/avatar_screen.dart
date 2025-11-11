import 'package:flutter/material.dart';
import '../widgets/custom_bottom_nav.dart'; // Adjust path as needed

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
  final _items = List.generate(30, (i) => {'name': 'Item ${i + 1}', 'price': '\$\$\$'});

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
                                  child: const Icon(Icons.image, size: 90, color: _muted),
                                ),
                              ),
                              const SizedBox(height: _g * 1.5),
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
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
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