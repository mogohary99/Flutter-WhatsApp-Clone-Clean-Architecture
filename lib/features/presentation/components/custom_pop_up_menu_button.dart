import 'package:flutter/material.dart';

import '../../../../../core/shared/pop_up_menu_item_model.dart';

class CustomPopUpMenuButton extends StatelessWidget {
  final List<PopUpMenuItemModel> buttons;
  const CustomPopUpMenuButton({
  super.key, required this.buttons,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(Icons.more_vert),
      onSelected: (value){
        buttons[value].onTap();
      },
      itemBuilder: (context) {
        return buttons.map((e) {
          int index = buttons.indexOf(e);
          return PopupMenuItem(
            value: index,
            child: FittedBox(
              fit: BoxFit.fill,
              child: Text(e.name),
            ),
          );
        }).toList();
      },
    );
  }
}
