import 'package:flutter/material.dart';

import '../../../../../core/functions/navigator.dart';
import '../../../../../core/shared/pop_up_menu_item_model.dart';
import '../../../../../core/utils/constants/strings_manager.dart';
import '../../../../../core/utils/routes/routes_manager.dart';
import '../../../components/custom_pop_up_menu_button.dart';

List<Widget> buildMainLayoutSliverAppBarActions(
  BuildContext context, {
  required int index,
}) {
  //this to change pop up for chats calls status
  switch (index) {
    case 0:
      return actionButtons(
        context,
        onSearchPressed: () {},
        popUpMenuItems: _chatPopUpMenuItem(context),
      );
    case 1:
      return actionButtons(
        context,
        onSearchPressed: () {},
        popUpMenuItems: _statusPopUpMenuItem(context),
      );
    case 2:
      return actionButtons(
        context,
        onSearchPressed: () {},
        popUpMenuItems: _callPopUpMenuItem(context),
      );
    default:
      return actionButtons(
        context,
        onSearchPressed: () {},
        popUpMenuItems: _callPopUpMenuItem(context),
      );
  }
}

List<Widget> actionButtons(
  BuildContext context, {
  required VoidCallback onSearchPressed,
  required List<PopUpMenuItemModel> popUpMenuItems,
}) {
  return <Widget>[
    IconButton(
      onPressed: () {},
      icon: const Icon(Icons.camera_alt_outlined),
    ),
    IconButton(
      onPressed: () {},
      icon: const Icon(Icons.search),
    ),
    CustomPopUpMenuButton(buttons: popUpMenuItems),
  ];
}

List<PopUpMenuItemModel> _chatPopUpMenuItem(BuildContext context) => [
      PopUpMenuItemModel(
        name: AppStrings.newGroup,
        onTap: () {},
      ),
      PopUpMenuItemModel(
        name: AppStrings.newBroadcast,
        onTap: () {},
      ),
      PopUpMenuItemModel(
        name: AppStrings.linkedDevices,
        onTap: () {},
      ),
      PopUpMenuItemModel(
        name: AppStrings.starredMessage,
        onTap: () {},
      ),
      PopUpMenuItemModel(
        name: AppStrings.settings,
        onTap: () => navigateTo(context, Routes.settingsRoute),
      ),
    ];

List<PopUpMenuItemModel> _statusPopUpMenuItem(BuildContext context) => [
      PopUpMenuItemModel(
        name: AppStrings.statusPrivacy,
        onTap: () {},
      ),
      PopUpMenuItemModel(
        name: AppStrings.settings,
        onTap: () {},
      ),
    ];

List<PopUpMenuItemModel> _callPopUpMenuItem(BuildContext context) => [
      PopUpMenuItemModel(
        name: AppStrings.clearCallLog,
        onTap: () {
        },
      ),
      PopUpMenuItemModel(
        name: AppStrings.settings,
        onTap: () {},
      ),
    ];
