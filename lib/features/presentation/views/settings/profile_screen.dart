import 'package:flutter/material.dart';

import '../../../../core/utils/constants/strings_manager.dart';
import '../../../domain/entities/user.dart';
import '../../controllers/auth_cubit/auth_cubit.dart';
import 'components/about_card.dart';
import 'components/name_card.dart';
import 'components/phone_card.dart';
import 'components/profile_pic_circle_card.dart';

class ProfileScreen extends StatelessWidget {
  final UserEntity user;

  const ProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: const Text(AppStrings.profile),
          ),
          body: Column(
            children: [
              const SizedBox(height: 30),
              ProfilePicCircleCard(user: user),
              const SizedBox(height: 20),
              NameCard(user: user),
              AboutCard(user: user),
              PhoneCard(user: user)
            ],
          ),
        );
  }
}






