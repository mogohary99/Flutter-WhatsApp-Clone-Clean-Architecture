import 'package:flutter/material.dart';

import '/core/extensions/extensions.dart';
import '../../../components/update_profile_pic_model_bottom_sheet.dart';


class LoginProfilePic extends StatelessWidget {
  const LoginProfilePic({
  super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showUpdateProfilePicModelBottomSheet(context);
      },
      child: CircleAvatar(
        radius: 60,
        backgroundColor: context.colorScheme.onSurface,
        child: const Icon(
          Icons.add_a_photo,
          color: Colors.grey,
          size: 45,
        ),
      ),
    );
  }
}

