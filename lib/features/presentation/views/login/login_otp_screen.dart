import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/functions/navigator.dart';
import '../../../../core/utils/constants/font_manager.dart';
import '../../../../core/utils/constants/strings_manager.dart';
import '../../../../core/utils/constants/values_manager.dart';
import '../../../../core/utils/routes/routes_manager.dart';
import '../../controllers/auth_cubit/auth_cubit.dart';
import 'components/login_appbar.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;

  const OtpScreen({super.key, required this.phoneNumber});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

  @override
  void initState() {
    super.initState();
    _listenSmsCode();
  }

  _listenSmsCode() async {
    await SmsAutoFill().listenForCode();
  }
  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is VerifyOtpSuccessState) {
          navigateAndRemove(context, Routes.loginProfileInfoRoute);
        }
      },
      builder: (context, state) {
        AuthCubit cubit = AuthCubit.get(context);
        return Scaffold(
          appBar: LoginAppBar(
            title: Text(
              AppStrings.verifyingYourNumber,
              style: context.displayLarge,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
            child: Column(
              children: [
                Text(
                  AppStrings.waitingToDetectSms,
                  style: context.titleSmall,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.phoneNumber,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeightManager.semiBold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        AppStrings.wrongNumber,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: context.width(0.45),
                  child: PinFieldAutoFill(
                    codeLength: 6,
                    autoFocus: true,
                    cursor: Cursor(
                      color: context.colorScheme.secondary,
                      enabled: true,
                      height: 30,
                    ),
                    onCodeChanged: (value) {
                      if (value!.length == 6) {
                        cubit.verifyOtp(smsOtpCode: value.trim());
                      }
                    },
                  ),
                  /*
                  child: TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (val) {
                      if (val.length == 6) {
                        cubit.verifyOtp(smsOtpCode: val.trim());
                      }
                    },
                    decoration: const InputDecoration(
                      hintText: ' __  __ __ __',
                      hintStyle: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),

                   */
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppPadding.p18),
                  child: Text(
                    AppStrings.enter6DigitCode,
                    style: context.bodySmall,
                  ),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.message,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    const Text(
                      AppStrings.resendSms,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    const Spacer(),
                    TweenAnimationBuilder(
                      tween: Tween(begin: 60.0, end: 0),
                      duration: const Duration(seconds: 60),
                      builder: (context, value, child) => Text(
                        '00:${value.toInt()}',
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      onEnd: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
