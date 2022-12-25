import 'package:flutter/material.dart';

import '../../../../../core/utils/constants/strings_manager.dart';
import '/core/extensions/extensions.dart';
import '../../../../domain/entities/user.dart';


class NameCard extends StatelessWidget {
  const NameCard({
  super.key,
  required this.user,
  });

  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text(AppStrings.name),
            subtitle: Text(
              user.name,
              style: context.headlineMedium,
            ),
            trailing: Icon(
              Icons.edit,
              color: context.colorScheme.secondary,
            ),
          ),
          Padding(
            padding:
            const EdgeInsets.only(left: 70, right: 20, bottom: 10),
            child: Text(
              AppStrings.thisIsNotYourUser,
              style: context.titleMedium,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 70),
            child: Divider(
              color:
              context.colorScheme.onSurfaceVariant.withOpacity(0.2),
            ),
          ),
        ],
      ),
    );
  }
}