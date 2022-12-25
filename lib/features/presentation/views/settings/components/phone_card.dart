import 'package:flutter/material.dart';

import '/core/extensions/extensions.dart';
import '../../../../../core/utils/constants/strings_manager.dart';
import '../../../../domain/entities/user.dart';

class PhoneCard extends StatelessWidget {
  const PhoneCard({
  super.key,
  required this.user,
  });

  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: ListTile(
        leading: const Icon(Icons.phone),
        title: const Text(AppStrings.phone),
        subtitle: Text(
          user.phoneNumber,
          style: context.headlineMedium,
        ),
      ),
    );
  }
}
