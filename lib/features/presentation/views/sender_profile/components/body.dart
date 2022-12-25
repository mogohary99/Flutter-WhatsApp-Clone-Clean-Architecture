import 'package:flutter/material.dart';

import 'status_container.dart';
import 'encryption_container.dart';
import 'notification_container.dart';

class Body extends StatelessWidget {
  final String status;

  const Body({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          const SizedBox(height: 20),
          StatusContainer(status: status),
          const NotificationContainer(),
          const EncryptionContainer(),
          // to fill up the rest of the space to enable scrolling
          const SizedBox(height: 550),
        ],
      ),
    );
  }
}





