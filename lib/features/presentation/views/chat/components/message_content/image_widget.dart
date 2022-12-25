import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_flutter_clone/features/presentation/views/chat/components/message_content/time_sent_widget.dart';

import '../../../../../domain/entities/message.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({
  super.key,
  required this.message,
  required this.isMe,
  });

  final Message message;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: [
            CachedNetworkImage(
              imageUrl: message.text,
              fit: BoxFit.cover,
              maxHeightDiskCache: 390,
              placeholder: (context, url) => const SizedBox(),
            ),
            Positioned(
              bottom: 4,
              right: 8,
              child: TimeSentWidget(
                message: message,
                isMe: isMe,
                textColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}