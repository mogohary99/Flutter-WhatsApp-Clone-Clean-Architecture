import 'package:flutter/material.dart';

import '/core/extensions/extensions.dart';
import '../../../../../core/utils/constants/strings_manager.dart';
import '../../../../domain/entities/user.dart';

class AboutCard extends StatelessWidget {
  const AboutCard({
  super.key,
  required this.user,
  });

  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: ListTile(
        leading: const Icon(Icons.info_outline_rounded),
        title: const Text(AppStrings.about),
        subtitle: Text(
          user.status,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: context.headlineMedium,
        ),
        trailing: Icon(
          Icons.edit,
          color: context.colorScheme.secondary,
        ),
      ),
    );
  }
}