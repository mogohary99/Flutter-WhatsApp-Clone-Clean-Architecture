import 'package:flutter/material.dart';

import '../../../../../core/utils/constants/assets_manager.dart';

class SplashIcon extends StatelessWidget {
  const SplashIcon({
  super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Image.asset(
          AppImage.splashLightImg,
          width: 300,
        ),
      ),
    );
  }
}
