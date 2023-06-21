import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_flutter_clone/core/enums/messge_type.dart';
import 'package:whatsapp_flutter_clone/features/presentation/controllers/chat_cubit/chat_cubit.dart';
import 'recording_mic_widget.dart';

import '../../../../controllers/bottom_chat_cubit/bottom_chat_cubit.dart';

class RecordingMic extends StatefulWidget {
  final String receiverId;
  const RecordingMic({super.key, required this.receiverId,});

  @override
  State<RecordingMic> createState() => _RecordingMicState();
}

class _RecordingMicState extends State<RecordingMic> {
  late final RecorderController recorderController;

  @override
  void initState() {
    super.initState();
    recorderController = RecorderController();
  }

  @override
  Widget build(BuildContext context)
{
    return BlocBuilder<BottomChatCubit, BottomChatState>(
      builder: (context, state) {
        BottomChatCubit cubit = BottomChatCubit.get(context);
        return Visibility(
          visible: !cubit.isShownSendButton,
          child: RecordingMicWidget(
            onVerticalScrollComplete: () {},
            onHorizontalScrollComplete: () {
              cancelRecord();
            },
            onLongPress: () {
              startRecording();
            },
            onLongPressCancel: () {
              stopRecording();
            },
            onSend: () {
              stopRecording();
            },
            onTapCancel: () {
              cancelRecord();
            },
          ),
        );
      },
    );
  }


  void startRecording() async {
    if (await recorderController.checkPermission()) {
      await recorderController.record();
    }
  }

  void cancelRecord() async {
    await recorderController.stop();
  }

  void stopRecording() async {
    final path = await recorderController.stop();
    ChatCubit.get(context).sendFileMessage(
      receiverId: widget.receiverId,
      messageType: MessageType.audio,
      file: File(path!),
    );
  }

  @override
  void dispose() {
    super.dispose();
    recorderController.dispose();
  }
}
