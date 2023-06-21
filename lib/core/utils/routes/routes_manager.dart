import 'package:flutter/material.dart';
import 'package:whatsapp_flutter_clone/features/domain/entities/call.dart';
import 'package:whatsapp_flutter_clone/features/presentation/views/calls/call_screen.dart';
import 'package:whatsapp_flutter_clone/features/presentation/views/wallpaper/wallpaper_screen.dart';

import '../../../features/domain/entities/user.dart';
import '../../../features/presentation/views/camera/camera_screen.dart';
import '../../../features/presentation/views/camera/sending_image_view_page.dart';
import '../../../features/presentation/views/camera/sending_video_view_page.dart';
import '../../../features/presentation/views/chat/chat_screen.dart';
import '../../../features/presentation/views/login/login_landing_screen.dart';
import '../../../features/presentation/views/login/login_loading_screen.dart';
import '../../../features/presentation/views/login/login_otp_screen.dart';
import '../../../features/presentation/views/login/login_profile_info_screen.dart';
import '../../../features/presentation/views/login/login_screen.dart';
import '../../../features/presentation/views/main_layout/main_layout_screen.dart';
import '../../../features/presentation/views/select_contact/select_contact_screen.dart';
import '../../../features/presentation/views/sender_profile/sender_profile_page.dart';
import '../../../features/presentation/views/settings/profile_screen.dart';
import '../../../features/presentation/views/settings/settings_screen.dart';
import '../../../features/presentation/views/splash/splash_screen.dart';
import '../constants/strings_manager.dart';

class Routes {
  static const String splashRoute = '/';
  static const String landingRoute = '/landing';
  static const String loginRoute = '/login';
  static const String otpRoute = '/otp';
  static const String loginProfileInfoRoute = '/login-profile';
  static const String loginLoadingRoute = '/login-loading';
  static const String mainLayoutRoute = '/main-layout';
  static const String selectContactRoute = '/select-contact';
  static const String settingsRoute = '/settings';
  static const String chatRoute = '/chat';
  static const String cameraRoute = '/camera';
  static const String sendingImageViewRoute = '/sending-image-view';
  static const String sendingVideoViewRoute = '/sending-video-view';
  static const String profileRoute = '/profile';
  static const String senderUserProfileRoute = '/sender-profile';
  static const String wallpaperRoute = '/wallpaper';
  static const String callRoute = '/call-route';
}

class AppRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      case Routes.landingRoute:
        return MaterialPageRoute(
          builder: (_) => const LandingScreen(),
        );
      case Routes.loginRoute:
        return MaterialPageRoute(
          builder: (_) =>  const LoginScreen(),
        );
      case Routes.otpRoute:
        final phoneNumber = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) =>  OtpScreen(phoneNumber: phoneNumber),
        );
      case Routes.loginProfileInfoRoute:
        return MaterialPageRoute(
          builder: (_) => const LoginProfileInfoScreen(),
        );
      case Routes.loginLoadingRoute:
        return MaterialPageRoute(
          builder: (_) => const LoginLoadingScreen(),
        );
      case Routes.mainLayoutRoute:
        return MaterialPageRoute(
          builder: (_) => const MainLayoutScreen(),
        );
      case Routes.selectContactRoute:
        return MaterialPageRoute(
          builder: (_) => const SelectContactScreen(),
        );
      case Routes.settingsRoute:
        return MaterialPageRoute(
          builder: (_) =>  SettingsScreen(),
        );
      case Routes.chatRoute:
        final arguments =settings.arguments as Map<String,dynamic>;
        final String name =arguments['name'];
        final String uId = arguments['uId'];
        return MaterialPageRoute(
          builder: (_) => ChatScreen(name: name,uId: uId,),
        );
      case Routes.cameraRoute:
        final arguments =settings.arguments as Map<String,dynamic>;
        //final String name =arguments['name'];
        final String uId = arguments['uId'];
        return MaterialPageRoute(
          builder: (_) =>  CameraScreen(receiverId: uId),
        );
      case Routes.sendingImageViewRoute:
        final arguments =settings.arguments as Map<String,dynamic>;
        //final String name =arguments['name'];
        final String uId = arguments['uId'];
        final String path = arguments['path'];
        return MaterialPageRoute(
          builder: (_) => SendingImageViewPage(path: path,receiverId: uId),
        );
      case Routes.sendingVideoViewRoute:
        final arguments =settings.arguments as Map<String,dynamic>;
        //final String name =arguments['name'];
        final String uId = arguments['uId'];
        final String path = arguments['path'];
        return MaterialPageRoute(
          builder: (_) => SendingVideoViewPage(path: path,receiverId: uId),
        );
      case Routes.profileRoute:
        final argument = settings.arguments as UserEntity;
        return MaterialPageRoute(
          builder: (_) => ProfileScreen(user: argument),
        );
      case Routes.senderUserProfileRoute:
        final argument = settings.arguments as UserEntity;
        return MaterialPageRoute(
          builder: (_) => SenderUserProfilePage(user: argument),
        );
      case Routes.wallpaperRoute:
        return MaterialPageRoute(
          builder: (_) => const WallpaperScreen(),
        );
      case Routes.callRoute:
        final arguments =settings.arguments as Map<String,dynamic>;
        final Call call = arguments['call'];
        final String channelId = arguments['channelId'];
        return MaterialPageRoute(
          builder: (_) => CallScreen(call: call,channelId: channelId),
        );
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text(
            AppStrings.noRouteFound,
          ),
        ),
        body: const Center(
          child: Text(
            AppStrings.noRouteFound,
          ),
        ),
      ),
    );
  }
}
