import 'package:flutter/foundation.dart';

class AvatarPreviewData {
  const AvatarPreviewData({
    required this.baseBody,
    this.hairFront,
    this.hairBack,
    this.bangs,
    this.brows,
    this.lashes,
    this.eyes,
    this.mouth,
    this.beard,
    this.top,
    this.bottom,
    this.dress,
    this.gloves,
    this.shoes,
  });

  final String baseBody;
  final String? hairFront;
  final String? hairBack;
  final String? bangs;
  final String? brows;
  final String? lashes;
  final String? eyes;
  final String? mouth;
  final String? beard;
  final String? top;
  final String? bottom;
  final String? dress;
  final String? gloves;
  final String? shoes;
}

class AvatarPreviewStore {
  AvatarPreviewStore._();

  static final ValueNotifier<AvatarPreviewData> instance =
      ValueNotifier<AvatarPreviewData>(
    const AvatarPreviewData(
      baseBody: 'avatar_assets/assets/body/1.png',
      hairFront: 'avatar_assets/assets/hair/1.png',
      hairBack: 'avatar_assets/assets/hair_back/1.png',
      bangs: 'avatar_assets/assets/bangs/1.png',
      brows: 'avatar_assets/assets/EYEBROWS/1.png',
      lashes: 'avatar_assets/assets/EYELASHES/1.png',
      eyes: 'avatar_assets/assets/PUPILS/1.png',
      mouth: 'avatar_assets/assets/MOUTH/1.png',
      top: 'avatar_assets/assets/top/1.png',
      bottom: 'avatar_assets/assets/bottom/1.png',
      shoes: 'avatar_assets/assets/shoes/1.png',
    ),
  );

  static final ValueNotifier<int> coins = ValueNotifier<int>(500);
}