import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';

import '../../../../../core/extensions/extensions.dart';
import '../../../../../core/utils/constants/font_manager.dart';
import '../../../../../core/utils/constants/strings_manager.dart';
import '../../../components/custom_list_tile.dart';

class ContactsNotOnWhatsAppList extends StatelessWidget {
  final List<Contact> contactNotOnWhats;

  const ContactsNotOnWhatsAppList({
  super.key,
  required this.contactNotOnWhats,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: contactNotOnWhats.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return CustomListTile(
          title: contactNotOnWhats[index].displayName,
          onTap: () {},
          titleButton: TextButton(
            onPressed: () {},
            child: Text(
              AppStrings.invite,
              style: TextStyle(
                color: context.colorScheme.secondary,
                fontWeight: FontWeightManager.medium,
              ),
            ),
          ),
          onLeadingTap: () {},
        );
      },
    );
  }
}