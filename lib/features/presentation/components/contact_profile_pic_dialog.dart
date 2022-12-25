import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '/core/extensions/extensions.dart';
import '../../../core/utils/constants/assets_manager.dart';
import '../../domain/entities/contact_chat.dart';

Future<void> showContactProfilePicDialog(
  BuildContext context, {
  required ContactChat contact,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        scrollable: true,
        contentPadding: EdgeInsets.zero,
        alignment: Alignment.topCenter,
        content: Stack(
          children: [
            Hero(
              tag: contact.contactId,
              child: CachedNetworkImage(
                width: 400,
                height: 300,
                imageUrl: contact.profilePic,
                placeholder: (context, url) => Stack(
                  children: [
                    Image.asset(AppImage.genericProfileImage),
                    const Align(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(),
                    )
                  ],
                ),
                errorWidget: (context, url, error) => Image.asset(
                  AppImage.genericProfileImage,
                ),
                //height: 180.0,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 8,
                ),
                color: Colors.black26,
                child: Text(
                  contact.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            )
          ],
        ),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actionsPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.message,
              color: context.colorScheme.secondary,
              size: 25,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.call,
              color: context.colorScheme.primary,
              size: 25,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.videocam,
              color: context.colorScheme.primary,
              size: 25,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.info_outline_rounded,
              color: context.colorScheme.primary,
              size: 25,
            ),
          ),
        ],
      );
    },
  );
}
