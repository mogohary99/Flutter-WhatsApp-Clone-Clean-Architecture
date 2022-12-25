import 'package:flutter/material.dart';

import '/core/extensions/extensions.dart';

class SettingBottomText extends StatelessWidget {
  const SettingBottomText({
  super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30, top: 10),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: 'from\n',
              style: context.titleMedium,
            ),
            TextSpan(
              text: 'Mohamed Elgohary',
              style: context.headlineMedium,
            ),
          ],
        ),
      ),
    );
  }
}