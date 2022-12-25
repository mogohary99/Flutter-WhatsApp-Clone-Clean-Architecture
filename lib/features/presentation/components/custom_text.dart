import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final TextTheme textStyle;
  const CustomText({super.key, required this.text, required this.textStyle});

  @override
  Widget build(BuildContext context) {
    ThemeData theme =Theme.of(context);
    return Text(
      text,
      style: theme.textTheme.bodyMedium
    );
  }
}
