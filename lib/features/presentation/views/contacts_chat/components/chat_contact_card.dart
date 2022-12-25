import 'package:flutter/material.dart';

import '/core/extensions/time_extension.dart';
import '../../../../../core/functions/navigator.dart';
import '../../../../../core/utils/routes/routes_manager.dart';
import '../../../../domain/entities/contact_chat.dart';
import '../../../components/contact_profile_pic_dialog.dart';
import '../../../components/custom_list_tile.dart';
import '../../../components/my_cached_net_image.dart';
import '../../../controllers/chat_cubit/chat_cubit.dart';

class ChatContactCard extends StatelessWidget {
  final ContactChat chatContact;

  //final String? name;

  const ChatContactCard({
    super.key,
    required this.chatContact,
  });

  @override
  Widget build(BuildContext context) {
    // this stream to get num of message not seen
    return StreamBuilder<int>(
      stream: ChatCubit.get(context).numOfMessageNotSeen(chatContact.contactId),
      builder: (context, snapshot) {
        return CustomListTile(
          title: chatContact.name,
          onTap: () {
            navigateTo(context, Routes.chatRoute, arguments: {
              'name': chatContact.name,
              'uId': chatContact.contactId,
            });
          },
          subTitle: chatContact.lastMessage,
          time: chatContact.timeSent.chatContactTime,
          numOfMessageNotSeen: snapshot.data ?? 0,
          leading: Hero(
            tag: chatContact.contactId,
            child: InkWell(
              borderRadius: BorderRadius.circular(25),
              onTap: () {
                showContactProfilePicDialog(context, contact: chatContact,);
              },
              child: MyCachedNetImage(
                imageUrl: chatContact.profilePic,
                radius: 30,
              ),
            ),
          ),
        );
      },
    );
  }
}
