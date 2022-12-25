import 'package:flutter/material.dart';

import '/core/extensions/extensions.dart';
import '../../../core/utils/constants/assets_manager.dart';

class CustomListTile extends StatelessWidget {
  final Widget? leading;
  final String title;
  final String? subTitle;
  final String? time;
  final Widget? titleButton;
  final int numOfMessageNotSeen;
  final VoidCallback onTap;
  final VoidCallback? onLeadingTap;

  const CustomListTile({
    super.key,
    this.leading,
    required this.title,
    this.subTitle,
    this.time,
    this.numOfMessageNotSeen = 0,
    this.titleButton,
    required this.onTap,
    this.onLeadingTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: leading ??
          InkWell(
            onTap: onLeadingTap,
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              child: Image.asset(AppImage.genericProfileImage),
            ),
          ),
      title: Row(
        children: [
          Expanded(
            child: Text(
              title,
              //style: context.headlineSmall,
              style: context.headlineMedium,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          if (time != null)
            Text(
              time!,
              style: numOfMessageNotSeen>0
                  ? context.labelLarge!.copyWith(color: context.colorScheme.onPrimaryContainer)
                  : context.bodyMedium,
            ),
          if (titleButton != null)
            SizedBox(
              height: 40,
              child: titleButton!,
            ),
        ],
      ),
      subtitle: subTitle != null
          ? Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Row(
                children: [
                  //Icon(Icons.done_all,size: 20,),
                  Expanded(
                    child: Text(
                      subTitle!,
                      style: context.bodyMedium,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  if ( numOfMessageNotSeen >0 )
                    CircleAvatar(
                      minRadius: 12,
                      backgroundColor: context.colorScheme.onPrimaryContainer,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          numOfMessageNotSeen.toString(),
                          style: context.labelLarge,
                        ),
                      ),
                    ),
                ],
              ),
            )
          : null,
    );
  }
}
