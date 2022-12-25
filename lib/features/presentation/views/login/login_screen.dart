import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/functions/navigator.dart';
import '../../../../core/functions/app_dialogs.dart';
import '../../../../core/utils/constants/strings_manager.dart';
import '../../../../core/utils/constants/values_manager.dart';
import '../../../../core/utils/routes/routes_manager.dart';
import '../../components/default_button.dart';
import '../../controllers/auth_cubit/auth_cubit.dart';
import 'components/login_appbar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController countryCodeController = TextEditingController();
  late String phoneNumber;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SignInSuccessState) {
          navigateAndRemove(context, Routes.otpRoute, arguments: phoneNumber);
        }
      },
      builder: (context, state) {
        AuthCubit cubit = AuthCubit.get(context);
        return Scaffold(
          appBar: LoginAppBar(
            title: Text(
              AppStrings.enterYourPhoneNumber,
              style: context.displayLarge,
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.more_vert,
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p14),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.whatsAppWillNeed,
                    textAlign: TextAlign.center,
                    //style: context.bodyLarge,
                    style: context.titleSmall,
                  ),
                  TextButton(
                    onPressed: () {
                      AppDialogs.permissionDialog(
                        context,
                        onContinuePressed: () {},
                        contentText: AppStrings.toRetrieveYourPhone,
                      );
                    },
                    child: const Text(
                      AppStrings.whatIsMyNumber,
                    ),
                  ),
                  SizedBox(
                    width: context.width(0.7),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Center(
                                child: InkWell(
                                  onTap: () {
                                    showCountryPicker(
                                      context: context,
                                      showPhoneCode: true,
                                      onSelect: (myCountry) {
                                        cubit.setCountry(myCountry);
                                        countryCodeController.text =
                                            cubit.country!.phoneCode;
                                      },
                                    );
                                  },
                                  child: Text(
                                    cubit.country == null
                                        ? AppStrings.pickCountry
                                        : cubit.country!.name,
                                    textAlign: TextAlign.center,
                                    style: context.titleLarge,
                                  ),
                                ),
                              ),
                            ),
                            Icon(
                              Icons.arrow_drop_down,
                              color: context.colorScheme.primary,
                              size: AppSize.s28,
                            ),
                          ],
                        ),
                        const Divider(
                          height: 0,
                          thickness: 0.7,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: AppSize.s60,
                              child: TextField(
                                //enabled: false,
                                readOnly: true,
                                controller: countryCodeController,
                                style: TextStyle(
                                    color: context
                                        .colorScheme.onTertiaryContainer),
                                decoration: InputDecoration(
                                  prefix: Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    width: 10,
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      '+',
                                      style: context.titleLarge!.copyWith(
                                          color: context
                                              .colorScheme.onTertiaryContainer),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: AppSize.s14,
                            ),
                            Expanded(
                              child: TextField(
                                controller: phoneController,
                                keyboardType: TextInputType.phone,
                                cursorColor: context.colorScheme.secondary,
                                cursorHeight: 30,
                                style: TextStyle(
                                    color: context
                                        .colorScheme.onTertiaryContainer),
                                decoration: const InputDecoration(
                                  hintText: AppStrings.phoneNumber,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSize.s12),
                        Text(
                          AppStrings.carrierChargesMayApply,
                          style: context.titleMedium,
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  DefaultButton(
                    text: AppStrings.next,
                    onPress: ()  {
                      if (phoneController.text.isNotEmpty &&
                          countryCodeController.text.isNotEmpty) {
                        String number = phoneController.text.trim();
                        phoneNumber = '+${countryCodeController.text}$number';
                        AppDialogs.submitPhoneDialog(
                          context: context,
                          phoneNumber:
                              '+${countryCodeController.text} ${phoneController.text}',
                          okPressed: () {
                            navigatePop(context);
                            cubit.signInWithPhoneNumber(
                                phoneNumber: phoneNumber,);
                          },
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    height: AppSize.s28,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
    countryCodeController.dispose();
  }
}
