import 'package:flutter/material.dart';

import '../../../../../core/functions/navigator.dart';
import '../../../../../core/utils/routes/routes_manager.dart';
import '../../../components/custom_list_tile.dart';
import '../../../components/my_cached_net_image.dart';

class ContactsOnWhatsAppList extends StatelessWidget {
  final Map<String, dynamic> contactOnWhats;

  const ContactsOnWhatsAppList({
  super.key,
  required this.contactOnWhats,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: contactOnWhats.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        var contact = contactOnWhats.values.toList()[index];
        return CustomListTile(
          title: contact['name'],
          onTap: () {
            navigateAndRemove(
              context,
              Routes.chatRoute,
              arguments: {
                'uId': contact['uId'],
                'name': contact['name'],
              },
            );
          },
          onLeadingTap: () {},
          subTitle: contact['status'],
          leading: MyCachedNetImage(
            imageUrl: contact['profilePic'],
            radius: 22,
          ),
        );
      },
    );
  }
}