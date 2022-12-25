import 'package:flutter/material.dart';

import '/core/extensions/extensions.dart';
import '../../../../../core/functions/navigator.dart';
import '../../../../../core/utils/constants/assets_manager.dart';
import '../../../../../core/utils/routes/routes_manager.dart';
import '../../../../domain/entities/user.dart';
import '../../../components/my_cached_net_image.dart';
import '../../../controllers/auth_cubit/auth_cubit.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthCubit.get(context).getCurrentUser(),
      builder: (context,snapshot){
        if (snapshot.connectionState == ConnectionState.done) {
            UserEntity user = AuthCubit.get(context).userEntity!;
              return InkWell(
              onTap: () {
                navigateTo(context, Routes.profileRoute, arguments: user);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  children: [
                    Hero(
                      tag: user.uId,
                      child: MyCachedNetImage(
                        radius: 30,
                        imageUrl: user.profilePic,
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.name ?? '',
                            style: context.headlineMedium,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            user.status ?? '',
                            style: context.bodyMedium,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ),
                    //const Spacer(),
                    Image.asset(
                      AppImage.qrCode,
                      width: 30,
                      color: context.colorScheme.secondary,
                    ),
                  ],
                ),
              ),
            );
        }
        return const SizedBox();
      },
    );
  }
}
