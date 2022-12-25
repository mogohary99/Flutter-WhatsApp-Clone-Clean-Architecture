import 'package:flutter/material.dart';

class MyColors {
  /// Base Colors
  final Color black = Colors.black;
  final Color black1 = const Color(0xFF121212);
  final Color black2 = const Color(0xFF18171d); // 900
  final Color black3 = const Color(0xFF242329); // 900
  final Color onyx = const Color(0xFF45444B); // 900
  final Color textBlack = const Color(0XFF4F5054);
  final Color grey = Colors.grey;
  final Color abbey = const Color(0xFF464648);
  final Color dimGray = const Color(0xFF666666);
  final Color textIconColorGray = Colors.grey[300]!;
  final Color white = Colors.white;
  final Color white1 = const Color(0xFFFAFAFA);
  final Color white2 = const Color(0xFFECECF4);
  final Color transparent = Colors.transparent;
  final Color shadow = const Color.fromRGBO(33, 22, 156, 0.1);
  final Color blackLight=  const Color(0XFF646464);
  final Color secondary = const Color(0XFF128C7E); //primary
  final Color primary = const Color(0XFF008069); //primary2
  final Color primary1 = const Color(0XFF1EBEA5); //primaryLight1

  final Color lightGreen = const Color(0XFF25D366);
  final Color teaGreen = const Color(0XFFDCF8C6);

  final Color checkMarkBlue = const Color(0XFF34B7F1);

  final Color round = const Color(0XFF25D167);//coloo
  final Color timeBackgroundColor = const Color(0XFFF0F2F4);
}

abstract class IColors {
  MyColors get _colors;

  Color? scaffoldBackgroundColor;
  Color? appBarColor;
  Color? primaryColor;

  //Color? tabBarColor;
  //Color? tapBarSelectedColor;
  //Color? tapBarNormalColor;
  Brightness? brightness;

  ColorScheme? colorScheme;
}

class LightColors implements IColors {
  @override
  final MyColors _colors = MyColors();

  @override
  ColorScheme? colorScheme;

  @override
  Color? appBarColor;

  @override
  Color? scaffoldBackgroundColor;

  @override
  Brightness? brightness;

  @override
  Color? primaryColor;

  LightColors() {
    appBarColor = _colors.white;
    scaffoldBackgroundColor = _colors.white;
    primaryColor = _colors.primary;
    colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: _colors.primary,
      //to appbar
      onPrimary: _colors.white1,
      //to text on appbar
      primaryContainer: _colors.white2,
      // to other text on appbar,action icon
      secondary: _colors.secondary,
      secondaryContainer: _colors.primary1,
      //to fab
      onSecondary: _colors.white1,
      error: _colors.black,
      onError: _colors.white1,
      background: _colors.white1,
      onBackground: _colors.black1,
      onSecondaryContainer: _colors.lightGreen,//landing image
      surface: _colors.teaGreen,
      onSurface: _colors.dimGray,
      surfaceVariant: _colors.timeBackgroundColor,
      onSurfaceVariant: _colors.blackLight,
      onInverseSurface: _colors.grey,
      onTertiary: _colors.checkMarkBlue,
      onTertiaryContainer: _colors.onyx,
      onPrimaryContainer: _colors.round
    );
    brightness = Brightness.light;
  }
}
