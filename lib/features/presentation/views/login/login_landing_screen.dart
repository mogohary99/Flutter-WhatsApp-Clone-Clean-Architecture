import 'package:flutter/material.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/functions/navigator.dart';
import '../../../../core/utils/constants/strings_manager.dart';
import '../../../../core/utils/constants/values_manager.dart';
import '../../../../core/utils/routes/routes_manager.dart';
import '../../components/default_button.dart';
import 'components/landing_image.dart';
import 'components/login_appbar.dart';
import 'components/privacy_policy_link_and_terms_of_service.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LoginAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Text(
              AppStrings.welcomeToWhatsApp,
              style: context.displayLarge!.copyWith(
                fontSize: 28,
              ),
            ),
            const Spacer(),
            const LandingImage(),
            const Spacer(),
            const PrivacyPolicyLinkAndTermsOfService(),
            const SizedBox(height: AppSize.s14),
            DefaultButton(
              text: AppStrings.agreeAndContinue,
              width: context.width(0.7),
              onPress: ()  {
                navigateAndReplace(context, Routes.loginRoute);
              },
            ),
            const SizedBox(height: AppSize.s80),
          ],
        ),
      ),
    );
  }
}
