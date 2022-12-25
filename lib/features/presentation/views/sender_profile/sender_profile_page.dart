import 'package:flutter/material.dart';

import '../../../domain/entities/user.dart';
import 'components/body.dart';
import 'components/phone_and_name.dart';
import 'components/sender_profile_icons.dart';
import 'components/sender_user_profile_appbar.dart';

class SenderUserProfilePage extends StatelessWidget {
  final UserEntity user;

  const SenderUserProfilePage({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              delegate: SenderUserProfilePageAppBar(
                context: context,
                user: user,
              ),
              pinned: true,
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  PhoneAndName(
                    name: user.name,
                    phoneNum: user.phoneNumber,
                  ),
                  const SenderProfileIcons(),
                ],
              ),
            ),
            Body(
              status: user.status,
            ),
          ],
        ),
      ),
    );
  }
}
