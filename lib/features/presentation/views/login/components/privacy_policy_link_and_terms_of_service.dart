import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../../core/extensions/extensions.dart';
import '../../../../../core/utils/constants/strings_manager.dart';
import '../../../../../core/utils/constants/values_manager.dart';

class PrivacyPolicyLinkAndTermsOfService extends StatelessWidget {
  const PrivacyPolicyLinkAndTermsOfService({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(AppPadding.p10),
      child: Center(
        child: Text.rich(
          //style: context.bodyMedium,
          style: context.titleMedium,
          textAlign: TextAlign.center,
          TextSpan(
            children: <TextSpan>[
              const TextSpan(
                text: AppStrings.readOur,
              ),
              buildTextSpanBlueButton(
                text: AppStrings.privacyPolicy,
                onTap: () {
                  // code to open / launch terms of service link here
                },
                context: context,
              ),
              const TextSpan(
                text: AppStrings.tapAgreeAnd,
              ),
              buildTextSpanBlueButton(
                text: AppStrings.termsOfService,
                onTap: () {
                  // code to open / launch terms of service link here
                },
                context: context,
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextSpan buildTextSpanBlueButton({
    required String text,
    required VoidCallback onTap,
    required BuildContext context,
  }) {
    return TextSpan(
      text: text,
      /*
      style: context.bodyMedium!.copyWith(
            color: AppColors.checkMarkBlue,
          ),
       */
      style: context.titleMedium!.copyWith(
        color: context.colorScheme.onTertiary,
      ),
      recognizer: TapGestureRecognizer()..onTap = onTap,
    );
  }
}
