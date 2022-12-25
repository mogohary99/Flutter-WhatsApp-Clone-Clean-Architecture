import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_flutter_clone/features/presentation/controllers/auth_cubit/auth_cubit.dart';

import '../../../../domain/entities/user.dart';
import '../../../components/my_cached_net_image.dart';
import '../../../components/update_profile_pic_model_bottom_sheet.dart';

class ProfilePicCircleCard extends StatelessWidget {
  const ProfilePicCircleCard({
    super.key,
    required this.user,
  });

  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    UserEntity? newUser;
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is UpdateProfilePicSuccessState) {
        AuthCubit.get(context).getCurrentUser();
        }
        if(state is GetCurrentUserSuccessState){
          newUser = AuthCubit.get(context).userEntity;
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            GestureDetector(
              onTap: () {
                showUpdateProfilePicModelBottomSheet(context);
              },
              child: Hero(
                tag: user.uId,
                child: MyCachedNetImage(
                  imageUrl: newUser?.profilePic ?? user.profilePic,
                  radius: 85,
                ),
              ),
            ),
            const Positioned(
              bottom: 0,
              right: 0,
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.teal,
                child: Icon(
                  Icons.camera_alt_rounded,
                  color: Colors.white,
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
