import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_flutter_clone/features/presentation/controllers/call_cubit/call_cubit.dart';

import '../../../components/custom_network_image.dart';
import '/core/extensions/time_extension.dart';
import '/core/functions/navigator.dart';
import '/core/shared/pop_up_menu_item_model.dart';
import '/core/utils/constants/strings_manager.dart';
import '/core/utils/routes/routes_manager.dart';
import '../../../../domain/entities/user.dart';
import '../../../components/custom_pop_up_menu_button.dart';
import '../../../components/loader.dart';
import '../../../controllers/auth_cubit/auth_cubit.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String name;
  final String receiverId;

  const ChatAppBar({
    super.key,
    required this.name,
    required this.receiverId,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserEntity>(
        stream: AuthCubit.get(context).getUserById(receiverId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loader();
          }
          UserEntity userdata = snapshot.data!;
          return AppBar(
            leadingWidth: 70,
            titleSpacing: 0,
            leading: Container(
              margin: const EdgeInsets.only(bottom: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(50),
                onTap: () {
                  navigateAndRemove(context, Routes.mainLayoutRoute);
                },
                child: Row(
                  children: [
                    const Icon(Icons.arrow_back_rounded),
                    Hero(
                      tag: userdata.uId,
                      child: CustomNetworkImage(imageUrl: userdata.profilePic),
                    ),
                  ],
                ),
              ),
            ),
            title: SizedBox(
              width: double.infinity,
              height: kToolbarHeight,
              child: InkWell(
                onTap: () {
                  navigateTo(
                    context,
                    Routes.senderUserProfileRoute,
                    arguments: userdata,
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name),
                      Text(
                        userdata.isOnline
                            ? 'Online'
                            : userdata.lastSeen.lastSeen,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            actions: [
              BlocConsumer<CallCubit,CallState>(
                listener: (context,state){
                  if(state is MakeCallSuccessState){
                    navigateTo(
                      context,
                      Routes.callRoute,
                      arguments: {
                        'call': state.call,
                        'channelId': state.call.callId,
                      },
                    );
                  }
                },
                builder: (context,state){
                  return IconButton(
                    onPressed: () {
                      CallCubit.get(context).makeCall(
                        receiverId: receiverId,
                        receiverName: name,
                        receiverPic: userdata.profilePic,
                      );
                    },
                    splashRadius: 20,
                    icon: const Icon(Icons.videocam),
                  );
                },
              ),
              IconButton(
                onPressed: () {},
                splashRadius: 20,
                icon: const Icon(Icons.call),
              ),
              CustomPopUpMenuButton(
                buttons: _buttons(context),
              ),
            ],
          );
        });
  }

  List<PopUpMenuItemModel> _buttons(context) => [
        PopUpMenuItemModel(
          name: AppStrings.viewContact,
          onTap: () {},
        ),
        PopUpMenuItemModel(
          name: AppStrings.mediaLinksAndDocs,
          onTap: () {},
        ),
        PopUpMenuItemModel(
          name: AppStrings.search,
          onTap: () {},
        ),
        PopUpMenuItemModel(
          name: AppStrings.muteNotifications,
          onTap: () {},
        ),
        PopUpMenuItemModel(
          name: AppStrings.disappearingMessages,
          onTap: () {},
        ),
        PopUpMenuItemModel(
          name: AppStrings.wallpaper,
          onTap: () {
            navigateTo(context, Routes.wallpaperRoute);
          },
        ),
        PopUpMenuItemModel(
          name: AppStrings.more,
          onTap: () {},
        ),
      ];

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
