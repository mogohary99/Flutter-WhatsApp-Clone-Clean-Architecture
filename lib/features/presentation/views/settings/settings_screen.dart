import 'package:flutter/material.dart';

import '../../../../core/utils/constants/strings_manager.dart';
import 'components/profile_card.dart';
import 'components/setting_bottom_text.dart';
import 'components/settings_item_card.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.settings),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const ProfileCard(),
            ...List<Widget>.generate(
              _settingItems.length,
              (index) => SettingsItemCard(
                item: _settingItems[index],
              ),
            ),
            const SettingBottomText(),
          ],
        ),
      ),
    );
  }

  final List<Map<String, dynamic>> _settingItems = [
    {
      'icon': Icons.key,
      'onTab': () {},
      'title': 'Account',
      'subtitle': 'Security notifications, change number',
    },
    {
      'icon': Icons.privacy_tip,
      'onTab': () {},
      'title': 'Privacy',
      'subtitle': 'Bloc contacts, disappearing messages',
    },
    {
      'icon': Icons.chat_sharp,
      'onTab': () {},
      'title': 'Chats',
      'subtitle': 'Theme, wallpapers, chat history',
    },
    {
      'icon': Icons.notifications,
      'onTab': () {},
      'title': 'Notifications',
      'subtitle': 'Message, group & call tones',
    },
    {
      'icon': Icons.data_usage,
      'onTab': () {},
      'title': 'Storage and data',
      'subtitle': 'Network usage, auto download',
    },
    {
      'icon': Icons.language,
      'onTab': () {},
      'title': 'App language',
      'subtitle': 'English',
    },
    {
      'icon': Icons.help_outline,
      'onTab': () {},
      'title': 'Help',
      'subtitle': 'Help centre, contact us, privacy policy',
    },
    {
      'icon': Icons.group,
      'onTab': () {},
      'title': 'Invite a friend',
      'subtitle': '',
    },
  ];
}
