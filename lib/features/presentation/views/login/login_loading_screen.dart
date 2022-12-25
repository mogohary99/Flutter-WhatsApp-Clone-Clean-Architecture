import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../core/functions/navigator.dart';
import '../../../../core/shared/commen.dart';
import '../../../../core/utils/constants/strings_manager.dart';
import '../../../../core/utils/routes/routes_manager.dart';
import '../../controllers/auth_cubit/auth_cubit.dart';
import 'components/landing_image.dart';
import 'components/login_appbar.dart';

class LoginLoadingScreen extends StatelessWidget {
  const LoginLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SaveUserDataToFirebaseSuccessState) {
          navigateAndRemove(context, Routes.mainLayoutRoute);
          /*
          if (kDebugMode) {
            print('lllll');
          }
          sl<CacheHelper>()
              .saveData(
            key: AppStrings.uId,
            value: sl<GetCurrentUidUseCase>().toString(),
          )
              .then((value) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              Routes.mainLayoutRoute,
              (route) => false,
            );
          });
          */
        }
        if (state is SaveUserDataToFirebaseErrorState) {
          showSnackBar(context: context, content: 'content err');
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: const LoginAppBar(
            title: Text(
              AppStrings.initializing,
            ),
          ),
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  AppStrings.pleaseWaitAMoment,
                  style: context.displayLarge,
                ),
                const Spacer(),
                const LandingImage(),
                const Spacer(),
                const CircularProgressIndicator(),
                const SizedBox(height: 60),
              ],
            ),
          ),
        );
      },
    );
  }
}
