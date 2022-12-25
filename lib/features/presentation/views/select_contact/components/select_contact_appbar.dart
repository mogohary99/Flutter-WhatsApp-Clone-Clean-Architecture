import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

import '/core/extensions/extensions.dart';
import '../../../../../core/shared/pop_up_menu_item_model.dart';
import '../../../../../core/utils/constants/strings_manager.dart';
import '../../../components/custom_pop_up_menu_button.dart';
import '../../../controllers/select_contact_cubit/select_contact_cubit.dart';

class SelectContactAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final int numOfContacts;
  final SelectContactState state;

  const SelectContactAppBar({
    super.key,
    required this.numOfContacts,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.selectContact,
            style: context.headlineLarge,
          ),
          const SizedBox(height: 3),
          Text(
            '$numOfContacts ${AppStrings.contacts}',
            style: context.bodySmall,
          ),
        ],
      ),
      actions: [
        if (state is GetAllContactsLoadingState ||
            state is GetContactsOnWhatsLoadingState)
           FittedBox(
            fit: BoxFit.scaleDown,
            child: SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                color: context.colorScheme.onPrimary,
                strokeWidth: 2,
              ),
            ),
          ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search),
        ),
        CustomPopUpMenuButton(buttons: _buttons(context)),
      ],
    );
  }

  List<PopUpMenuItemModel> _buttons(context) => [
        PopUpMenuItemModel(
          name: AppStrings.inviteAFriend,
          onTap: () {},
        ),
        PopUpMenuItemModel(
          name: AppStrings.contacts,
          onTap: () {
            FlutterContacts.openExternalPick().then((value) {
              if (kDebugMode) {
                print(value!.displayName);
              }
            });
          },
        ),
        PopUpMenuItemModel(
          name: AppStrings.refresh,
          onTap: () {
            SelectContactCubit.get(context).getAllContacts().then((value) {
              SelectContactCubit.get(context).getContactsOnWhatsApp();
              SelectContactCubit.get(context).getContactsNotOnWhatsApp();
            });
          },
        ),
        PopUpMenuItemModel(
          name: AppStrings.help,
          onTap: () {},
        ),
      ];

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
