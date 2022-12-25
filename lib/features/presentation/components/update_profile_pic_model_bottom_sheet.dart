import 'dart:io';

import 'package:flutter/material.dart';

import '../controllers/auth_cubit/auth_cubit.dart';
import '/core/extensions/extensions.dart';
import '../../../core/functions/navigator.dart';
import '../../../core/shared/commen.dart';
import '../../../core/utils/constants/font_manager.dart';
import '../../../core/utils/constants/strings_manager.dart';

Future<void> showUpdateProfilePicModelBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.profilePhoto,
              style: context.titleLarge,
            ),
            Row(
              children: [
                PickProfileImage(
                  onTap: () {},
                  icon: Icons.photo_camera,
                  name: AppStrings.camera,
                ),
                const SizedBox(width: 40),
                PickProfileImage(
                  onTap: () {
                    selectImageFromGallery(context);
                  },
                  icon: Icons.photo,
                  name: AppStrings.gallery,
                ),
              ],
            )
          ],
        ),
      );
    },
  );
}

void selectImageFromGallery(BuildContext context) async {
  File? image = await pickImageFromGallery(context);
  if(image != null){
    cropImage(image.path).then((value) {
      if(value != null) {
        AuthCubit.get(context).updateProfilePic(value.path);
      }
      navigatePop(context);
    });
  }
}

class PickProfileImage extends StatelessWidget {
  final VoidCallback onTap;
  final String name;
  final IconData icon;

  const PickProfileImage({
  super.key,
  required this.onTap,
  required this.name,
  required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.only(
              bottom: 10,
              top: 30,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.grey.shade200,
              ),
            ),
            child: Icon(
              icon,
              color: context.colorScheme.secondary,
            ),
          ),
        ),
        Text(
          name,
          style: context.titleMedium!.copyWith(
            fontWeight: FontWeightManager.regular,
          ),
        ),
      ],
    );
  }
}
