import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/functions/navigator.dart';
import '../../../../../core/utils/routes/routes_manager.dart';
import '../../../components/default_button.dart';
import '../../../controllers/auth_cubit/auth_cubit.dart';

class SignOutButton extends StatelessWidget {
  const SignOutButton

  ({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if(state is SignOutSuccessState){
          navigateAndRemove(context, Routes.landingRoute);
        }
      },
      builder: (context, state) {
        return DefaultButton(
          text: 'signout',
          onPress: () {
            AuthCubit.get(context).signOut();
          },
        );
      },
    );
  }
}
