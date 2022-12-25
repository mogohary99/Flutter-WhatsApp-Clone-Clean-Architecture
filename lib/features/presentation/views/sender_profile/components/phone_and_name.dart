import 'package:flutter/material.dart';

import '/core/extensions/extensions.dart';

class PhoneAndName extends StatelessWidget {
  final String name;
  final String phoneNum;

  const PhoneAndName({
  super.key,
  required this.name,
  required this.phoneNum,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children:  [
        const SizedBox(height: 35),
        Text(
          name,
          style: context.headlineMedium!.copyWith(fontSize: 22),
        ),
        const SizedBox(height: 10),
        Text(
          phoneNum,
          style: context.bodyMedium,
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}