import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/mobile_layout.dart';

const _phone = Colors.white;
const _pink = Color(0xFFFAD3D6);
const _darkPink = Color(0xFFE6A7B3);
const _ink = Color(0xFF2B2B2B);
const _muted = Color(0xFF7A8087);
const _green = Color(0xFF57B65F);
const _g = 16.0;

class AvatarUI extends StatefulWidget {
  const AvatarUI({super.key});

  @override
  State<AvatarUI> createState() => _AvatarUIState();
}

class _AvatarUIState extends State<AvatarUI> {
  int _coins = 500;

  late final Map<_AvatarCategory, List<_AvatarItem>> _shopItems;
  _AvatarCategory _selectedCategory = _AvatarCategory.hairFront;

  final ScrollController _categoryScrollController = ScrollController();

  final Set<String> _ownedItemIds = {
    'hair_front_1',
    'hair_back_1',
    'bangs_1',
    'brows_1',
    'lashes_1',
    'eyes_1',
    'mouth_1',
    'tops_1',
    'bottoms_1',
    'shoes_1',
  };

  final String _baseBody = 'avatar_assets/assets/body/1.png';

  String? _equippedHairFront = 'avatar_assets/assets/hair/1.png';
  String? _equippedHairBack = 'avatar_assets/assets/hair_back/1.png';
  String? _equippedBangs = 'avatar_assets/assets/bangs/1.png';
  String? _equippedBrows = 'avatar_assets/assets/EYEBROWS/1.png';
  String? _equippedLashes = 'avatar_assets/assets/EYELASHES/1.png';
  String? _equippedEyes = 'avatar_assets/assets/PUPILS/1.png';
  String? _equippedMouth = 'avatar_assets/assets/MOUTH/1.png';
  String? _equippedBeard;
  String? _equippedTop = 'avatar_assets/assets/top/1.png';
  String? _equippedBottom = 'avatar_assets/assets/bottom/1.png';
  String? _equippedDress;
  String? _equippedGloves;
  String? _equippedShoes = 'avatar_assets/assets/shoes/1.png';

  @override
  void initState() {
    super.initState();

    _shopItems = {
      _AvatarCategory.hairFront: _buildItems(
        category: _AvatarCategory.hairFront,
        folder: 'avatar_assets/assets/hair',
        count: 12,
        basePrice: 120,
      ),
      _AvatarCategory.hairBack: _buildItems(
        category: _AvatarCategory.hairBack,
        folder: 'avatar_assets/assets/hair_back',
        count: 12,
        basePrice: 110,
      ),
      _AvatarCategory.bangs: _buildItems(
        category: _AvatarCategory.bangs,
        folder: 'avatar_assets/assets/bangs',
        count: 13,
        basePrice: 95,
      ),
      _AvatarCategory.brows: _buildItems(
        category: _AvatarCategory.brows,
        folder: 'avatar_assets/assets/EYEBROWS',
        count: 5,
        basePrice: 50,
      ),
      _AvatarCategory.lashes: _buildItems(
        category: _AvatarCategory.lashes,
        folder: 'avatar_assets/assets/EYELASHES',
        count: 5,
        basePrice: 50,
      ),
      _AvatarCategory.eyes: _buildItems(
        category: _AvatarCategory.eyes,
        folder: 'avatar_assets/assets/PUPILS',
        count: 16,
        basePrice: 60,
      ),
      _AvatarCategory.mouth: _buildItems(
        category: _AvatarCategory.mouth,
        folder: 'avatar_assets/assets/MOUTH',
        count: 20,
        basePrice: 55,
      ),
      _AvatarCategory.beard: _buildItems(
        category: _AvatarCategory.beard,
        folder: 'avatar_assets/assets/BEARD',
        count: 5,
        basePrice: 80,
      ),
      _AvatarCategory.tops: _buildItems(
        category: _AvatarCategory.tops,
        folder: 'avatar_assets/assets/top',
        count: 12,
        basePrice: 140,
      ),
      _AvatarCategory.bottoms: _buildItems(
        category: _AvatarCategory.bottoms,
        folder: 'avatar_assets/assets/bottom',
        count: 8,
        basePrice: 125,
      ),
      _AvatarCategory.dresses: _buildItems(
        category: _AvatarCategory.dresses,
        folder: 'avatar_assets/assets/dress',
        count: 7,
        basePrice: 180,
      ),
      _AvatarCategory.gloves: _buildItems(
        category: _AvatarCategory.gloves,
        folder: 'avatar_assets/assets/gloves',
        count: 6,
        basePrice: 75,
      ),
      _AvatarCategory.shoes: _buildItems(
        category: _AvatarCategory.shoes,
        folder: 'avatar_assets/assets/shoes',
        count: 4,
        basePrice: 95,
      ),
    };
  }

  @override
  void dispose() {
    _categoryScrollController.dispose();
    super.dispose();
  }

  List<_AvatarItem> _buildItems({
    required _AvatarCategory category,
    required String folder,
    required int count,
    required int basePrice,
  }) {
    return List.generate(count, (index) {
      final number = index + 1;
      return _AvatarItem(
        id: '${category.id}_$number',
        name: '${category.label} $number',
        price: basePrice + (index * 15),
        imagePath: '$folder/$number.png',
        category: category,
      );
    });
  }

  List<_AvatarItem> get _visibleItems => _shopItems[_selectedCategory] ?? [];

  void _scrollCategoriesLeft() {
    if (!_categoryScrollController.hasClients) return;

    final newOffset = (_categoryScrollController.offset - 180).clamp(
      0.0,
      _categoryScrollController.position.maxScrollExtent,
    );

    _categoryScrollController.animateTo(
      newOffset,
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOut,
    );
  }

  void _scrollCategoriesRight() {
    if (!_categoryScrollController.hasClients) return;

    final newOffset = (_categoryScrollController.offset + 180).clamp(
      0.0,
      _categoryScrollController.position.maxScrollExtent,
    );

    _categoryScrollController.animateTo(
      newOffset,
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOut,
    );
  }

  String? _equippedPathForCategory(_AvatarCategory category) {
    switch (category) {
      case _AvatarCategory.hairFront:
        return _equippedHairFront;
      case _AvatarCategory.hairBack:
        return _equippedHairBack;
      case _AvatarCategory.bangs:
        return _equippedBangs;
      case _AvatarCategory.brows:
        return _equippedBrows;
      case _AvatarCategory.lashes:
        return _equippedLashes;
      case _AvatarCategory.eyes:
        return _equippedEyes;
      case _AvatarCategory.mouth:
        return _equippedMouth;
      case _AvatarCategory.beard:
        return _equippedBeard;
      case _AvatarCategory.tops:
        return _equippedTop;
      case _AvatarCategory.bottoms:
        return _equippedBottom;
      case _AvatarCategory.dresses:
        return _equippedDress;
      case _AvatarCategory.gloves:
        return _equippedGloves;
      case _AvatarCategory.shoes:
        return _equippedShoes;
    }
  }

  void _setEquippedPathForCategory(_AvatarCategory category, String? path) {
    switch (category) {
      case _AvatarCategory.hairFront:
        _equippedHairFront = path;
        break;
      case _AvatarCategory.hairBack:
        _equippedHairBack = path;
        break;
      case _AvatarCategory.bangs:
        _equippedBangs = path;
        break;
      case _AvatarCategory.brows:
        _equippedBrows = path;
        break;
      case _AvatarCategory.lashes:
        _equippedLashes = path;
        break;
      case _AvatarCategory.eyes:
        _equippedEyes = path;
        break;
      case _AvatarCategory.mouth:
        _equippedMouth = path;
        break;
      case _AvatarCategory.beard:
        _equippedBeard = path;
        break;
      case _AvatarCategory.tops:
        _equippedTop = path;
        break;
      case _AvatarCategory.bottoms:
        _equippedBottom = path;
        break;
      case _AvatarCategory.dresses:
        _equippedDress = path;
        break;
      case _AvatarCategory.gloves:
        _equippedGloves = path;
        break;
      case _AvatarCategory.shoes:
        _equippedShoes = path;
        break;
    }
  }

  String _baseNumberFromPath(String path) {
    final filename = path.split('/').last.replaceAll('.png', '');
    final match = RegExp(r'^(\d+)').firstMatch(filename);
    return match?.group(1) ?? filename;
  }

  bool _sameBaseAsset(String a, String b) {
    return _baseNumberFromPath(a) == _baseNumberFromPath(b);
  }

  bool _isEquipped(_AvatarItem item) {
    final current = _equippedPathForCategory(item.category);
    if (current == null) return false;
    return _sameBaseAsset(current, item.imagePath);
  }

  void _equipItem(_AvatarItem item) {
    setState(() {
      switch (item.category) {
        case _AvatarCategory.hairFront:
          _equippedHairFront = item.imagePath;
          break;
        case _AvatarCategory.hairBack:
          _equippedHairBack = item.imagePath;
          break;
        case _AvatarCategory.bangs:
          _equippedBangs = item.imagePath;
          break;
        case _AvatarCategory.brows:
          _equippedBrows = item.imagePath;
          break;
        case _AvatarCategory.lashes:
          _equippedLashes = item.imagePath;
          break;
        case _AvatarCategory.eyes:
          _equippedEyes = item.imagePath;
          break;
        case _AvatarCategory.mouth:
          _equippedMouth = item.imagePath;
          break;
        case _AvatarCategory.beard:
          _equippedBeard = item.imagePath;
          break;
        case _AvatarCategory.tops:
          _equippedTop = item.imagePath;
          _equippedDress = null;
          break;
        case _AvatarCategory.bottoms:
          _equippedBottom = item.imagePath;
          break;
        case _AvatarCategory.dresses:
          _equippedDress = item.imagePath;
          _equippedTop = null;
          _equippedBottom = null;
          break;
        case _AvatarCategory.gloves:
          _equippedGloves = item.imagePath;
          break;
        case _AvatarCategory.shoes:
          _equippedShoes = item.imagePath;
          break;
      }
    });
  }

  void _unequipItem(_AvatarItem item) {
    setState(() {
      switch (item.category) {
        case _AvatarCategory.hairFront:
          _equippedHairFront = null;
          break;
        case _AvatarCategory.hairBack:
          _equippedHairBack = null;
          break;
        case _AvatarCategory.bangs:
          _equippedBangs = null;
          break;
        case _AvatarCategory.brows:
          _equippedBrows = null;
          break;
        case _AvatarCategory.lashes:
          _equippedLashes = null;
          break;
        case _AvatarCategory.eyes:
          _equippedEyes = null;
          break;
        case _AvatarCategory.mouth:
          _equippedMouth = null;
          break;
        case _AvatarCategory.beard:
          _equippedBeard = null;
          break;
        case _AvatarCategory.tops:
          _equippedTop = null;
          break;
        case _AvatarCategory.bottoms:
          _equippedBottom = null;
          break;
        case _AvatarCategory.dresses:
          _equippedDress = null;
          break;
        case _AvatarCategory.gloves:
          _equippedGloves = null;
          break;
        case _AvatarCategory.shoes:
          _equippedShoes = null;
          break;
      }
    });
  }

  Future<bool?> _showPurchaseDialog(_AvatarItem item) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Buy item?'),
          content: Text(
            'Do you want to purchase ${item.name} for ${item.price} coins?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('No'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  Future<bool?> _showRemoveDialog(_AvatarItem item) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Remove item?'),
          content: Text('Do you want to remove ${item.name} from your avatar?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('No'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _handleItemTap(_AvatarItem item) async {
    final isOwned = _ownedItemIds.contains(item.id);
    final isEquipped = _isEquipped(item);

    if (isEquipped) {
      final shouldRemove = await _showRemoveDialog(item);
      if (shouldRemove == true) {
        _unequipItem(item);
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${item.name} removed.')),
        );
      }
      return;
    }

    if (isOwned) {
      _equipItem(item);
      return;
    }

    if (_coins < item.price) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Not enough coins for this item yet.')),
      );
      return;
    }

    final shouldBuy = await _showPurchaseDialog(item);
    if (shouldBuy != true) return;

    setState(() {
      _coins -= item.price;
      _ownedItemIds.add(item.id);
    });

    _equipItem(item);

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${item.name} purchased and equipped.')),
    );
  }

  bool _categoryHasColorOptions(_AvatarCategory category) {
    return category == _AvatarCategory.hairFront ||
        category == _AvatarCategory.bangs ||
        category == _AvatarCategory.tops ||
        category == _AvatarCategory.dresses;
  }

  Future<bool> _assetExists(String path) async {
    try {
      await rootBundle.load(path);
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<List<String>> _getColorVariantPaths(
    _AvatarCategory category,
    String currentPath,
  ) async {
    final baseNumber = _baseNumberFromPath(currentPath);
    final variants = <String>{currentPath};

    if (category == _AvatarCategory.hairFront) {
      const suffixes = ['', 'b', 'c', 'd', 'e', 'f', 'g', 'h'];
      for (final suffix in suffixes) {
        final candidate =
            'avatar_assets/assets/hair_bonus/COLOR/$baseNumber$suffix.png';
        if (await _assetExists(candidate)) {
          variants.add(candidate);
        }
      }
    } else if (category == _AvatarCategory.bangs) {
      const suffixes = ['', 'b', 'c', 'd', 'e', 'f', 'g', 'h'];
      for (final suffix in suffixes) {
        final candidate =
            'avatar_assets/assets/bangs/COLOR/$baseNumber$suffix.png';
        if (await _assetExists(candidate)) {
          variants.add(candidate);
        }
      }
    } else if (category == _AvatarCategory.tops) {
      final baseCandidate = 'avatar_assets/assets/top/colors/$baseNumber.png';
      if (await _assetExists(baseCandidate)) {
        variants.add(baseCandidate);
      }

      const suffixes = ['b', 'c', 'd', 'e', 'f', 'g', 'h'];
      for (final suffix in suffixes) {
        final candidate =
            'avatar_assets/assets/top/colors/$baseNumber$suffix.png';
        if (await _assetExists(candidate)) {
          variants.add(candidate);
        }
      }
    } else if (category == _AvatarCategory.dresses) {
      final baseCandidate = 'avatar_assets/assets/dress/COLORS/$baseNumber.png';
      if (await _assetExists(baseCandidate)) {
        variants.add(baseCandidate);
      }

      const suffixes = ['b', 'c', 'd', 'e', 'f', 'g', 'h'];
      for (final suffix in suffixes) {
        final candidate =
            'avatar_assets/assets/dress/COLORS/$baseNumber$suffix.png';
        if (await _assetExists(candidate)) {
          variants.add(candidate);
        }
      }
    }

    return variants.toList()..sort();
  }

  Future<void> _openColorPicker() async {
    if (!_categoryHasColorOptions(_selectedCategory)) return;

    final currentPath = _equippedPathForCategory(_selectedCategory);
    if (currentPath == null) return;

    final options = await _getColorVariantPaths(_selectedCategory, currentPath);

    if (!mounted) return;

    if (options.length <= 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No extra color options for this item.')),
      );
      return;
    }

    final picked = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Choose a color'),
          content: SizedBox(
            width: 320,
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: options.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, index) {
                final optionPath = options[index];
                final isCurrent = optionPath == currentPath;

                return GestureDetector(
                  onTap: () => Navigator.pop(context, optionPath),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: isCurrent ? _darkPink : Colors.black12,
                        width: isCurrent ? 2 : 1,
                      ),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Image.asset(
                      optionPath,
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) =>
                          const Icon(Icons.palette_outlined, color: _muted),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );

    if (picked == null || !mounted) return;

    setState(() {
      _setEquippedPathForCategory(_selectedCategory, picked);
    });
  }

  Widget _avatarLayer(String? path) {
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
    final showColorButton =
        _categoryHasColorOptions(_selectedCategory) &&
        _equippedPathForCategory(_selectedCategory) != null;

    return MobileLayout(
      currentScreen: 'avatar',
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: _phone,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                  child: Column(
                    children: [
                      _BalancePill(coins: _coins),
                      const SizedBox(height: 14),
                      Container(
                        width: 240,
                        height: 320,
                        decoration: BoxDecoration(
                          color: Colors.black12.withAlpha(24),
                          borderRadius: BorderRadius.circular(28),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(14),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(24),
                                ),
                              ),
                              _avatarLayer(_equippedHairBack),
                              _avatarLayer(_baseBody),
                              _avatarLayer(_equippedEyes),
                              _avatarLayer(_equippedBrows),
                              _avatarLayer(_equippedLashes),
                              _avatarLayer(_equippedMouth),
                              _avatarLayer(_equippedDress),
                              _avatarLayer(_equippedTop),
                              _avatarLayer(_equippedBottom),
                              _avatarLayer(_equippedShoes),
                              _avatarLayer(_equippedGloves),
                              _avatarLayer(_equippedBeard),
                              _avatarLayer(_equippedHairFront),
                              _avatarLayer(_equippedBangs),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      if (showColorButton)
                        Align(
                          alignment: Alignment.centerRight,
                          child: OutlinedButton.icon(
                            onPressed: _openColorPicker,
                            style: OutlinedButton.styleFrom(
                              backgroundColor: _pink,
                              side: const BorderSide(
                                color: _darkPink,
                                width: 2,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(999),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                            ),
                            icon: const Icon(
                              Icons.palette_outlined,
                              color: _ink,
                              size: 18,
                            ),
                            label: const Text(
                              'Colors',
                              style: TextStyle(
                                color: _ink,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      const SizedBox(height: 6),
                      SizedBox(
                        height: 78,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: _scrollCategoriesLeft,
                                  child: Container(
                                    width: 34,
                                    height: 34,
                                    decoration: const BoxDecoration(
                                      color: _pink,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.arrow_back_ios_new_rounded,
                                      size: 16,
                                      color: _ink,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: _scrollCategoriesRight,
                                  child: Container(
                                    width: 34,
                                    height: 34,
                                    decoration: const BoxDecoration(
                                      color: _pink,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 16,
                                      color: _ink,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Expanded(
                              child: ListView.separated(
                                controller: _categoryScrollController,
                                scrollDirection: Axis.horizontal,
                                itemCount: _AvatarCategory.values.length,
                                separatorBuilder: (_, __) =>
                                    const SizedBox(width: 8),
                                itemBuilder: (context, index) {
                                  final category = _AvatarCategory.values[index];
                                  final isSelected =
                                      _selectedCategory == category;

                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _selectedCategory = category;
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 14,
                                        vertical: 11,
                                      ),
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? _pink
                                            : Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(999),
                                        border: Border.all(
                                          color: isSelected
                                              ? _pink
                                              : Colors.black12,
                                        ),
                                      ),
                                      child: Text(
                                        category.label,
                                        style: TextStyle(
                                          color: _ink,
                                          fontWeight: isSelected
                                              ? FontWeight.w700
                                              : FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: _pink.withAlpha(89),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        padding: const EdgeInsets.all(_g),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 0.8,
                                crossAxisSpacing: 14,
                                mainAxisSpacing: 14,
                              ),
                          itemCount: _visibleItems.length,
                          itemBuilder: (context, i) {
                            final item = _visibleItems[i];
                            final isOwned = _ownedItemIds.contains(item.id);
                            final isEquipped = _isEquipped(item);

                            return _ShopTile(
                              name: item.name,
                              price: item.price,
                              image: item.imagePath,
                              isOwned: isOwned,
                              isEquipped: isEquipped,
                              onTap: () => _handleItemTap(item),
                            );
                          },
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

enum _AvatarCategory {
  hairFront('Hair', 'hair_front'),
  hairBack('Back Hair', 'hair_back'),
  bangs('Bangs', 'bangs'),
  brows('Brows', 'brows'),
  lashes('Lashes', 'lashes'),
  eyes('Eyes', 'eyes'),
  mouth('Mouth', 'mouth'),
  beard('Beard', 'beard'),
  tops('Tops', 'tops'),
  bottoms('Bottoms', 'bottoms'),
  dresses('Dresses', 'dresses'),
  gloves('Gloves', 'gloves'),
  shoes('Shoes', 'shoes');

  const _AvatarCategory(this.label, this.id);

  final String label;
  final String id;
}

class _AvatarItem {
  const _AvatarItem({
    required this.id,
    required this.name,
    required this.price,
    required this.imagePath,
    required this.category,
  });

  final String id;
  final String name;
  final int price;
  final String imagePath;
  final _AvatarCategory category;
}

class _BalancePill extends StatelessWidget {
  const _BalancePill({required this.coins});

  final int coins;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: _pink.withAlpha(128),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        'Coins: $coins',
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          color: _ink,
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
    required this.isOwned,
    required this.isEquipped,
    required this.onTap,
  });

  final String name;
  final int price;
  final String image;
  final bool isOwned;
  final bool isEquipped;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isSelected = isEquipped;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? _pink.withAlpha(64) : _phone,
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
                padding: const EdgeInsets.all(8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    image,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) =>
                        const Icon(Icons.checkroom, size: 36, color: _muted),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: _ink,
                  fontSize: 11,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              isEquipped
                  ? 'Equipped'
                  : isOwned
                  ? 'Owned'
                  : '💵 $price',
              style: TextStyle(
                color: isEquipped
                    ? _ink
                    : isOwned
                    ? _green
                    : _muted,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
          ],
        ),
      ),
    );
  }
}