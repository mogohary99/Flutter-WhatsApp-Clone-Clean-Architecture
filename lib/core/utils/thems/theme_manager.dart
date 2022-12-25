import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '/core/utils/thems/styles_manager.dart';
import 'my_colors.dart';
import '../constants/font_manager.dart';
import '../constants/values_manager.dart';

ThemeData createTheme(IColors iColors) => ThemeData(
  scaffoldBackgroundColor: iColors.scaffoldBackgroundColor,
  primaryColor: iColors.primaryColor,
  colorScheme: iColors.colorScheme,
  brightness: iColors.brightness,
  textTheme: _textTheme(iColors),
  appBarTheme: _appBarTheme(iColors),
  popupMenuTheme: _popupMenuThemeData(iColors),
  tabBarTheme: tabBarTheme(),
  textButtonTheme: _textButtonThemeData(iColors),
  elevatedButtonTheme: _elevatedButtonThemeData(iColors),
  inputDecorationTheme: _inputDecorationTheme(iColors),
  dividerColor: iColors.colorScheme!.secondaryContainer,
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: iColors.primaryColor,
  ),
);

TextTheme _textTheme(IColors iColors) {
  return TextTheme(
      displayLarge: getSemiBoldStyle(
        color: iColors.colorScheme!.secondary,
        fontSize: FontSize.s20,
      ),
      //for appbar
      headlineLarge: getBoldStyle(
        color: iColors.colorScheme!.onPrimary,
        fontSize: 18,
      ),
      bodySmall: getRegularStyle(
          color: iColors.colorScheme!.primaryContainer,
          fontSize: 13
      ),
      //for list tile title
      headlineMedium: getMediumStyle(
        //color: AppColors.textBlack,
        color: iColors.colorScheme!.onSurface,
        fontSize: FontSize.s17,
      ),

      labelLarge: getBoldStyle(
        color: iColors.colorScheme!.onPrimary,
        fontSize: 14,
      ),
      //for list tile subtitle
      bodyMedium: getMediumStyle(
        color: iColors.colorScheme!.onInverseSurface,
        fontSize: FontSize.s14,
      ),
      //for time card
      displaySmall: TextStyle(
          color: iColors.colorScheme!.onSurfaceVariant,
          fontSize: 16,
          fontWeight: FontWeight.w500
      ),
      //////////////////////////////////////////////login
      titleLarge: getMediumStyle(
        color: iColors.colorScheme!.onSurface,
        fontSize: FontSize.s17,
      ),
      titleMedium: getMediumStyle(
        color: iColors.colorScheme!.onInverseSurface,
        fontSize: FontSize.s14,
      ),
      titleSmall: getSemiBoldStyle(
        //color: AppColors.blackLight,
        color: iColors.colorScheme!.onSurfaceVariant,
        fontSize: FontSize.s14,
      )
  );
}

AppBarTheme _appBarTheme(IColors colors) {
  return AppBarTheme(
    color: colors.colorScheme!.primary,
    elevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: colors.colorScheme!.primary,
      statusBarIconBrightness: Brightness.light,
    ),
    titleTextStyle: TextStyle(
      color: colors.colorScheme!.onPrimary,
      fontSize: AppSize.s20,
      fontWeight: FontWeightManager.semiBold,
    ),
    actionsIconTheme: IconThemeData(
      color: colors.colorScheme!.primaryContainer,
      size: FontSize.s26,
    ),
  );
}

TabBarTheme tabBarTheme() {
  return const TabBarTheme(
    labelStyle: TextStyle(
      fontSize: FontSize.s14,
      fontWeight: FontWeightManager.bold,
    ),
  );
}

TextButtonThemeData _textButtonThemeData(IColors colors) {
  return TextButtonThemeData(
    style: TextButton.styleFrom(
      textStyle: TextStyle(
        color: colors.colorScheme!.secondary,
        fontWeight: FontWeightManager.medium,
      ),
    ),
  );
}

PopupMenuThemeData _popupMenuThemeData(IColors iColors) {
  return PopupMenuThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(3),
    ),
    textStyle: TextStyle(
      color: iColors.colorScheme!.onSurface,
      fontWeight: FontWeightManager.medium,
      fontSize: FontSize.s17,
    ),
  );
}

InputDecorationTheme _inputDecorationTheme(IColors iColors) {
  return InputDecorationTheme(
    hintStyle: TextStyle(
      color: iColors.colorScheme!.onInverseSurface,
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: iColors.colorScheme!.secondary,
        width: 2,
      ),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: iColors.colorScheme!.secondary,
        width: 2,
      ),
    ),
  );
}

ElevatedButtonThemeData _elevatedButtonThemeData(IColors iColors) {
  return ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: iColors.colorScheme!.secondary,
      textStyle: TextStyle(
        color: iColors.colorScheme!.onSecondary,
        fontWeight: FontWeightManager.medium,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSize.s20,
        vertical: AppSize.s14,
      ),
    ),
  );
}
