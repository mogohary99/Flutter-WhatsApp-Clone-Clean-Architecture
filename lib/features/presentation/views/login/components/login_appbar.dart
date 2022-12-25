import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/core/extensions/extensions.dart';


class LoginAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget>? actions;
  final Widget? title;

  const LoginAppBar({
    super.key,
    this.actions,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: context.theme.scaffoldBackgroundColor,
        statusBarIconBrightness: _brightness(context),
        statusBarBrightness: _brightness(context),
      ),
      backgroundColor: context.theme.scaffoldBackgroundColor,
      title: title,
      actions: actions,
    );
  }

  Brightness _brightness(BuildContext context) {
    return context.theme.brightness == Brightness.light
        ? Brightness.dark
        : Brightness.light;
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
