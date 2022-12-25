import 'package:flutter/material.dart';

import '/core/extensions/extensions.dart';
import '../../../../../core/utils/constants/strings_manager.dart';

class EncryptionContainer extends StatelessWidget {
  const EncryptionContainer({
  super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.withOpacity(0.1),
      child: Container(
        color: Colors.white,
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ListTile(
              title: Text(
                AppStrings.encryption,
                style: context.headlineMedium,
              ),
              leading: const Icon(Icons.lock),
              subtitle: Text(
                AppStrings.messagesAndCallsAre,
                style: context.titleMedium,
              ),
            ),
            ListTile(
              title: Text(
                AppStrings.disappearingMessage,
                style: context.headlineMedium,
              ),
              leading: const Icon(Icons.timelapse),
              subtitle:  Text(
                AppStrings.off,
                style: context.titleMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}