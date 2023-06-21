import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_flutter_clone/config/agora_config.dart';
import 'package:whatsapp_flutter_clone/features/domain/entities/call.dart';
import 'package:whatsapp_flutter_clone/features/presentation/components/loader.dart';

class CallScreen extends StatefulWidget {
  final String channelId;
  final Call call;

  const CallScreen({super.key, required this.channelId, required this.call});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  AgoraClient? client;
  String baseUrl = '';

  @override
  void initState() {
    super.initState();
    client = AgoraClient(
      agoraConnectionData: AgoraConnectionData(
        appId: AgoraConfig.appId,
        channelName: widget.channelId,
        //tokenUrl: baseUrl,
      ),
    );
    initAgora();
  }

  void initAgora()async{
    await client!.initialize();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: client ==null ? Loader(): SafeArea(child: Stack(
        children: [
          AgoraVideoViewer(client: client!),
          AgoraVideoButtons(client: client!),
        ],
      )),
    );
  }
}
