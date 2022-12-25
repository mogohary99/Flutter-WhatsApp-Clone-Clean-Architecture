import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/extensions/extensions.dart';
import '../../../../core/functions/navigator.dart';
import '../../../../core/utils/constants/strings_manager.dart';
import '../../../../core/utils/constants/values_manager.dart';
import '../../../../core/utils/routes/routes_manager.dart';
import '../../controllers/auth_cubit/auth_cubit.dart';
import '../../controllers/select_contact_cubit/select_contact_cubit.dart';
import 'components/login_appbar.dart';
import 'components/login_profile_pic.dart';

class LoginProfileInfoScreen extends StatefulWidget {
  const LoginProfileInfoScreen({super.key});

  @override
  State<LoginProfileInfoScreen> createState() => _LoginProfileInfoScreenState();
}

class _LoginProfileInfoScreenState extends State<LoginProfileInfoScreen> {
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      SelectContactCubit.get(context).getAllContacts().then((value) {
        SelectContactCubit.get(context).getContactsOnWhatsApp();
        SelectContactCubit.get(context).getContactsNotOnWhatsApp();
      });
      return BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is SaveUserDataToFirebaseLoadingState) {
            navigateAndRemove(context, Routes.loginLoadingRoute);
          }
        },
        builder: (context, state) {
          AuthCubit cubit = AuthCubit.get(context);
          return Scaffold(
            appBar: LoginAppBar(
              title: Text(
                AppStrings.profileInfo,
                style: context.displayLarge,
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(AppPadding.p18),
              child: Column(
                children: [
                  Text(
                    AppStrings.pleaseProvideYourName,
                    textAlign: TextAlign.center,
                    style: context.titleMedium,
                  ),
                  const SizedBox(height: 20),
                  const LoginProfilePic(),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          cursorHeight: 30,
                          controller: nameController,
                          cursorColor: context.colorScheme.secondary,
                          decoration: const InputDecoration(
                            hintText: AppStrings.typeYourNameHere,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.emoji_emotions_outlined,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      if (nameController.text.length > 4) {
                        cubit.saveUserDataToFirebase(
                          name: nameController.text,
                        );
                      }
                    },
                    child: const Text(
                      AppStrings.next,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },);
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }
}

