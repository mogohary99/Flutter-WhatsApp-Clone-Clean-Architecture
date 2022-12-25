import 'package:flutter/material.dart';
import '/core/extensions/extensions.dart';

import '../utils/constants/strings_manager.dart';
import '../utils/constants/values_manager.dart';
import 'navigator.dart';

class AppDialogs {
  static Future<void> permissionDialog(
    BuildContext context, {
    required VoidCallback onContinuePressed,
        required String contentText,
  }) {
    return _showMyDialog(
      context: context,
      contentPadding: EdgeInsets.zero,
      borderRadius: AppSize.s8,
      content: Column(
        children: [
          Container(
            width: double.infinity,
            height: AppSize.s120,
            decoration: BoxDecoration(
              //color: AppColors.primary,
              color: context.colorScheme.secondaryContainer,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppSize.s8),
                topRight: Radius.circular(AppSize.s8),
              ),
            ),
            child: const Icon(
              Icons.phone,
              color: Colors.white,
              size: 50,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.p28,
              vertical: AppPadding.p28,
            ),
            child: Text(
              contentText,
              //style: Theme.of(context).textTheme.bodyLarge,
              style: context.titleSmall!.copyWith(
                height: 1.5,
              ),
            ),
          )
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: const Text(
            'Not Now',
          ),
          onPressed: () {
            navigatePop(context);
          },
        ),
        TextButton(
          onPressed: onContinuePressed,
          child: const Text(
            'Continue',
          ),
        ),
      ],
    );
  }

  static Future<void> submitPhoneDialog({
    required BuildContext context,
    required String phoneNumber,
    required VoidCallback okPressed,
  }) {
    return _showMyDialog(
      context: context,
      actionSpacer: true,
      borderRadius: 3,
      contentPadding: const EdgeInsets.only(
        top: AppPadding.p20,
        right: AppPadding.p20,
        left: AppPadding.p20,
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(AppStrings.youEnteredThePhoneNum),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: AppPadding.p20,
            ),
            child: Text(
              phoneNumber,
              style: context.titleMedium,
            ),
          ),
          const Text(AppStrings.isThisOk),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: Text(
            AppStrings.edit,
            style: TextStyle(
              color: context.colorScheme.secondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          onPressed: okPressed,
          child: Text(
            AppStrings.ok,
            style: TextStyle(
              color: context.colorScheme.secondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

Future<void> _showMyDialog({
  required BuildContext context,
  double borderRadius = 0,
  required Widget content,
  required List<Widget> actions,
  bool actionSpacer = false,
  EdgeInsetsGeometry? contentPadding,
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: contentPadding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius),
          ),
        ),
        content: SingleChildScrollView(
          child: content,
        ),
        actions: actions,
        actionsAlignment: actionSpacer
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.end,
      );
    },
  );
}
