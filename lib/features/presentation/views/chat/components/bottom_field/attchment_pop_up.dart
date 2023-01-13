import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class AttchementPopUp extends StatelessWidget {
   const AttchementPopUp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      //RotationTransition to rotate icon with degree
      icon: const RotationTransition(
        turns: AlwaysStoppedAnimation(-45 / 360),
        child: Icon(
          Icons.attach_file,
          color: Colors.grey,
          size: 26,
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16),),
     // offset: const Offset(0, -340),
      offset: const Offset(0, -350),
      onSelected: (v){
        if (FocusScope.of(context).hasFocus) {
          Future.delayed(const Duration(milliseconds: 50)).whenComplete(
                () {
              FocusScope.of(context).unfocus();
              FocusScope.of(context).dispose();
            },
          );
        }
      },
      onCanceled: () {
        if (!FocusScope.of(context).hasFocus) {
          Future.delayed(const Duration(milliseconds: 50))
              .whenComplete(() => FocusScope.of(context).unfocus());
          FocusScope.of(context).dispose();
        }
      },
      constraints: const BoxConstraints.tightFor(width: double.infinity),
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            padding: const EdgeInsets.only(left: 40, right: 40, bottom: 15),
            enabled: false,
            onTap: () {},
            child: Wrap(
              spacing: 8,
              runAlignment: WrapAlignment.spaceBetween,
              children: [
                AttchmentCard(
                  name: 'Document',
                  color: Colors.deepPurpleAccent,
                  icon: Icons.insert_drive_file,
                  onPress: () {
                  },
                ),
                AttchmentCard(
                  name: 'Camera',
                  color: Colors.redAccent,
                  icon: Icons.camera_alt,
                  onPress: () {},
                ),
                AttchmentCard(
                  name: 'Gallery',
                  color: Colors.purpleAccent,
                  icon: Icons.photo,
                  onPress: () {},
                ),
                AttchmentCard(
                  name: 'Audio',
                  color: Colors.deepOrange,
                  icon: Icons.headset_mic_rounded,
                  onPress: () {},
                ),
                AttchmentCard(
                  name: 'Location',
                  color: Colors.green,
                  icon: Icons.location_on,
                  onPress: () {},
                ),
                AttchmentCard(
                  name: 'Contact',
                  color: Colors.cyan,
                  icon: Icons.person,
                  onPress: () {
                    FlutterContacts.openExternalPick();
                  },
                ),
                AttchmentCard(
                  name: 'Poll',
                  color: Colors.teal,
                  icon: Icons.poll,
                  onPress: () {},
                ),
              ],
            ),
          ),
        ];
      },
    );
  }
}

class AttchmentCard extends StatelessWidget {
  final String name;
  final IconData icon;
  final Color color;
  final VoidCallback onPress;

  const AttchmentCard({
    super.key,
    required this.name,
    required this.icon,
    required this.color,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: color,
            child: IconButton(
              onPressed: onPress,
              splashRadius: 28,
              color: Colors.white,
              icon: Icon(icon),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(name),
        ],
      ),
    );
  }
}
