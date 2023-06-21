import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/utils/thems/my_colors.dart';
import 'core/shared/bloc_observer.dart';
import 'core/utils/constants/strings_manager.dart';
import 'core/utils/routes/routes_manager.dart';
import 'core/services/services_locator.dart' as di;
import 'core/utils/thems/theme_manager.dart';
import 'features/presentation/controllers/auth_cubit/auth_cubit.dart';
import 'features/presentation/controllers/bottom_chat_cubit/bottom_chat_cubit.dart';
import 'features/presentation/controllers/chat_background_cubit/chat_background_cubit.dart';
import 'features/presentation/controllers/chat_cubit/chat_cubit.dart';
import 'features/presentation/controllers/select_contact_cubit/select_contact_cubit.dart';
import 'features/presentation/views/camera/camera_screen.dart';
//csccccccc
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  await di.init();
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.sl<AuthCubit>()..getCurrentUser()),
        BlocProvider(
          create: (context) => di.sl<SelectContactCubit>()
            ..getAllContacts()
            ..getContactsOnWhatsApp(),
        ),
        BlocProvider(create: (context) => di.sl<ChatCubit>()),
        BlocProvider(create: (context) => di.sl<BottomChatCubit>()),
        BlocProvider(create: (context) => di.sl<ChatBackgroundCubit>()),
      ],
      child: MaterialApp(
        title: AppStrings.appName,
        debugShowCheckedModeBanner: false,
        theme: createTheme(LightColors()),
        onGenerateRoute: AppRoutes.onGenerateRoute,
        initialRoute: Routes.splashRoute,
      ),
    );
  }
}
