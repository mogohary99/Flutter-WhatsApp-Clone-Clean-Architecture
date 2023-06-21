import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_flutter_clone/features/presentation/views/calls/call_pickup_screen.dart';

import '../../controllers/chat_background_cubit/chat_background_cubit.dart';
import 'components/bottom_field/bottom_chat_with_icon.dart';
import 'components/chat_appbar.dart';
import 'components/message/messages_list.dart';
import 'components/bottom_field/recording_mic.dart';

class ChatScreen extends StatelessWidget {
  final String name;
  final String uId;

  const ChatScreen({super.key, required this.name, required this.uId});

  @override
  Widget build(BuildContext context) {
    return CallPickupScreen(
      scaffold: Scaffold(
        appBar: ChatAppBar(name: name, receiverId: uId),
        body: Stack(
          children: [
            BlocBuilder<ChatBackgroundCubit, ChatBackgroundState>(
              builder: ((context, state) {
                return Image.asset(
                  ChatBackgroundCubit.get(context).backgroundImage,
                  fit: BoxFit.fill,
                  width: double.infinity,
                  height: double.infinity,
                );
              }),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MessagesList(receiverId: uId),
                BottomChatWithIcon(receiverId: uId),
              ],
            ),
            RecordingMic(receiverId: uId),
          ],
        ),
      ),
    );
  }
}
