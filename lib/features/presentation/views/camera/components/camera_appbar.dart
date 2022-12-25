import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../core/functions/navigator.dart';

class CameraAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onFlashPressed;
  final bool isFlashOn;

  const CameraAppBar({
    super.key,
    required this.onFlashPressed,
    required this.isFlashOn,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.black,
      ),
      leading: IconButton(
        // iconSize: 30,
        onPressed: () {
          navigatePop(context);
        },
        icon: const Icon(Icons.clear),
      ),
      actions: [
        IconButton(
          onPressed: onFlashPressed,
          icon: Icon(
            isFlashOn ? Icons.flash_on : Icons.flash_off,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
