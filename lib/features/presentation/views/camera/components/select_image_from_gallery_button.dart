import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../../core/functions/navigator.dart';
import '../../../../../core/shared/commen.dart';
import '../../../../../core/utils/routes/routes_manager.dart';

class SelectImageFromGalleryButton extends StatelessWidget {
  final String receiverId;

  const SelectImageFromGalleryButton({
    super.key,
    required this.receiverId,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        selectImageFromGallery(context);
      },
      child: const CircleAvatar(
        radius: 30,
        backgroundColor: Colors.black38,
        child: Icon(
          Icons.photo,
          size: 30,
        ),
      ),
    );
  }

  void selectImageFromGallery(BuildContext context) async {
    File? image = await pickImageFromGallery(context);
    //if (!mounted) return;
    if (image != null) {
      // ignore: use_build_context_synchronously
      navigateTo(
        context,
        Routes.sendingImageViewRoute,
        arguments: {
          'path': image.path,
          'uId': receiverId,
        },
      );
    }
  }
}
