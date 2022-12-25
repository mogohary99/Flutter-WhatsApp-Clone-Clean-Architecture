import 'package:flutter/material.dart';

import '../../../core/utils/constants/assets_manager.dart';

class CustomNetworkImage extends StatelessWidget {
  final String imageUrl;

  const CustomNetworkImage({super.key, required this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: CircleAvatar(
        backgroundColor: Colors.white,
        backgroundImage: const AssetImage(AppImage.genericProfileImage),
        child: Image.network(
          imageUrl ?? '',
          errorBuilder: ((context, error, stackTrace) => const SizedBox()),
        ),
      ),
    );
  }
}
