import 'package:flutter/material.dart';

import '/core/extensions/extensions.dart';

class StatusContainer extends StatelessWidget {
  const StatusContainer({
    super.key,
    required this.status,
  });

  final String status;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.withOpacity(0.1),
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.white10,
              offset: Offset(0, 10),
              blurRadius: 20,
            ),
          ],
        ),
        child: Text(
          status,
          style: context.headlineMedium,
        ),
      ),
    );
  }
}
