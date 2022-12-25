import 'package:flutter/material.dart';

import '../../../../../core/extensions/extensions.dart';
import '../../../../../core/utils/constants/assets_manager.dart';

class LandingImage extends StatelessWidget {
  const LandingImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppImage.landingImg,
      width: context.width(0.65),
      color: context.colorScheme.onSecondaryContainer,
    );
  }
}
