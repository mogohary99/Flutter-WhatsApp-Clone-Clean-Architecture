import 'package:flutter/material.dart';

import '../../../domain/entities/contact_chat.dart';
import '../../components/loader.dart';
import '../../controllers/chat_cubit/chat_cubit.dart';
import 'components/chat_contact_card.dart';

class ContactsChatPage extends StatelessWidget {
  const ContactsChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ContactChat>>(
      stream: ChatCubit.get(context).getContactsChat({}),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loader();
        }
        return ListView.builder(
          padding: const EdgeInsets.only(top: 10),
          itemCount: snapshot.data!.length,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return ChatContactCard(
              chatContact: snapshot.data![index],
            );
          },
        );
      },
    );
  }
}
