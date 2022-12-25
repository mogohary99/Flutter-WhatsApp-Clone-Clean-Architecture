import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/constants/assets_manager.dart';

class MyCachedNetImage extends StatelessWidget {
  final String imageUrl;
  final double radius;

  const MyCachedNetImage({
    super.key,
    required this.imageUrl,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: radius * 2,
        height: radius * 2,
        placeholder: (context, url) => Stack(
          children: [
            Image.asset(AppImage.genericProfileImage),
            const Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            )
          ],
        ),
        errorWidget: (context, url, error) =>
            Image.asset(AppImage.genericProfileImage),
        //height: 180.0,
        fit: BoxFit.cover,
      ),
    );
  }
}
