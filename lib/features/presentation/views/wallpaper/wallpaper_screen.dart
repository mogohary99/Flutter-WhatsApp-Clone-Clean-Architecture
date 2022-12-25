import 'package:flutter/material.dart';
import 'package:whatsapp_flutter_clone/core/functions/navigator.dart';
import 'package:whatsapp_flutter_clone/core/utils/constants/assets_manager.dart';
import 'package:whatsapp_flutter_clone/features/presentation/controllers/chat_background_cubit/chat_background_cubit.dart';

class WallpaperScreen extends StatelessWidget {
  const WallpaperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Custom Wallpaper',
        ),
      ),
      body: GridView(
        physics: const BouncingScrollPhysics(),
        // if you want IOS bouncing effect, otherwise remove this line
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        children: wallpapers.map((name) {
          return InkWell(
            onTap: (){
              ChatBackgroundCubit.get(context).changeBackground(name);
              navigatePop(context);
            },
            child: Card(
              child: Image.asset(
                name,
                fit: BoxFit.cover,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

List<String> wallpapers = [
  AppImage.chatBackground,
  AppImage.chatBackground2,
  AppImage.chatBackground3,
  AppImage.chatBackgroundDark,
];
