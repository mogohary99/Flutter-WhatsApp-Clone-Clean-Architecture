import 'package:flutter/material.dart';

import '../../../../../core/utils/constants/strings_manager.dart';
import '/core/extensions/extensions.dart';

class SenderProfileIcons extends StatelessWidget {
   const SenderProfileIcons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        ButtonWidget(text: AppStrings.call,icon: Icons.call),
        SizedBox(width: 20),
        ButtonWidget(text: AppStrings.video,icon: Icons.videocam),
        SizedBox(width: 20),
        ButtonWidget(text: AppStrings.search,icon: Icons.search),

      ],
    );
  }
}

class ButtonWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  const ButtonWidget({
    super.key, required this.icon, required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children:  [
        Icon(
          icon,
          size: 30,
          color: context.colorScheme.secondary,
        ),
        const SizedBox(height: 5),
        Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            color: Color.fromARGB(255, 8, 141, 125),
          ),
        ),
      ],
    );
  }
}