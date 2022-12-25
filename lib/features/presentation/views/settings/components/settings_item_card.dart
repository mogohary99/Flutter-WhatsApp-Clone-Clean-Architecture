import 'package:flutter/material.dart';

import '/core/extensions/extensions.dart';

class SettingsItemCard extends StatelessWidget {
  const SettingsItemCard({
  super.key,
  required this.item,
  });

  final Map<String, dynamic> item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: item['onTab'],
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Row(
          children: [
            Icon(
              item['icon'],
              color: context.colorScheme.onSurface.withOpacity(0.6),
              size: 26,
            ),
            const SizedBox(
              width: 30,
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '${item['title']}\n',
                    style: context.headlineMedium,
                  ),
                  TextSpan(
                    text: item['subtitle'],
                    style: context.titleMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
