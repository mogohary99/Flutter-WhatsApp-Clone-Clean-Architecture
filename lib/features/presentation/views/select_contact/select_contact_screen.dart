import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/constants/strings_manager.dart';
import '../../controllers/select_contact_cubit/select_contact_cubit.dart';
import 'components/contacts_not_on_whatsapp_list.dart';
import 'components/contacts_on_whatsapp_list.dart';
import 'components/select_contact_appbar.dart';
import 'components/new_group_contact_community_buttons_List.dart';

class SelectContactScreen extends StatelessWidget {
  const SelectContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      SelectContactCubit.get(context).getAllContacts().then((value) {
        SelectContactCubit.get(context).getContactsOnWhatsApp();
        SelectContactCubit.get(context).getContactsNotOnWhatsApp();
      });
      return BlocConsumer<SelectContactCubit, SelectContactState>(
        listener: (context, state) {},
        builder: (context, state) {
          SelectContactCubit cubit = SelectContactCubit.get(context);
          return Scaffold(
            appBar: SelectContactAppBar(
              numOfContacts:
                  cubit.contactOnWhats.length + cubit.contactNotOnWhats.length,
              state: state,
            ),
            body: SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const NewGroupContactCommunityButtonsList(),
                  const SmallText(AppStrings.contactsOnWhatsApp),
                  ContactsOnWhatsAppList(
                    contactOnWhats: cubit.contactOnWhats,
                  ),
                  const SmallText(AppStrings.inviteToWhatsApp),
                  ContactsNotOnWhatsAppList(
                    contactNotOnWhats: cubit.contactNotOnWhats,
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}




class SmallText extends StatelessWidget {
  final String text;

  const SmallText(
    this.text, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Text(text),
    );
  }
}
