import 'package:flutter/material.dart';

import '/core/extensions/extensions.dart';
import '../../../../../core/utils/constants/strings_manager.dart';

class NotificationContainer extends StatelessWidget {
  const NotificationContainer({
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
                  AppStrings.muteNotification,
                  style: context.headlineMedium,
                ),
                leading: const Icon(Icons.notifications),
                trailing: Switch(
                  onChanged: (v) {},
                  value: false,
                ),
              ),
              ListTile(
                title: Text(
                  AppStrings.customNotification,
                  style: context.headlineMedium,
                ),
                leading: const Icon(Icons.music_note),
              ),
              ListTile(
                title: Text(
                  AppStrings.mediaVisibility,
                  style: context.headlineMedium,
                ),
                leading: const Icon(Icons.image),
              ),
            ],
          )),
    );
  }
}