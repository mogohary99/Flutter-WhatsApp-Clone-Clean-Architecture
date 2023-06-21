import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp_flutter_clone/features/data/data_source/call/call_data_source.dart';
import 'package:whatsapp_flutter_clone/features/data/repository/call_repository.dart';
import 'package:whatsapp_flutter_clone/features/domain/repository/base_call_repository.dart';
import 'package:whatsapp_flutter_clone/features/domain/usecases/call/call_stream_usecase.dart';
import 'package:whatsapp_flutter_clone/features/domain/usecases/call/end_call_usecase.dart';
import 'package:whatsapp_flutter_clone/features/domain/usecases/call/make_call_usecase.dart';
import 'package:whatsapp_flutter_clone/features/presentation/controllers/call_cubit/call_cubit.dart';
import 'package:whatsapp_flutter_clone/features/presentation/controllers/chat_background_cubit/chat_background_cubit.dart';

import '../../features/data/data_source/auth/local/auth_local_data_source.dart';
import '../../features/data/data_source/auth/remote/auth_remote_data_source.dart';
import '../../features/data/data_source/chat/remote/chat_remote_data_source.dart';
import '../../features/data/data_source/select_contact/local/get_contacts_local_data_source.dart';
import '../../features/data/data_source/select_contact/remote/select_contact_remote_data_source.dart';
import '../../features/data/repository/auth_repository.dart';
import '../../features/data/repository/chat_repository.dart';
import '../../features/data/repository/select_contact_Repository.dart';
import '../../features/domain/repository/base_auth_repository.dart';
import '../../features/domain/repository/base_chat_repository.dart';
import '../../features/domain/repository/base_select_contact_repository.dart';
import '../../features/domain/usecases/auth/get_cached_local_current_uid_usecase.dart';
import '../../features/domain/usecases/auth/get_current_uid_usecase.dart';
import '../../features/domain/usecases/auth/get_current_user_usecase.dart';
import '../../features/domain/usecases/auth/get_user_by_id_usecase.dart';
import '../../features/domain/usecases/auth/save_userdata_to_firebase_usecase.dart';
import '../../features/domain/usecases/auth/set_user_state_usecase.dart';
import '../../features/domain/usecases/auth/sign_in_with_phone_number_usecase.dart';
import '../../features/domain/usecases/auth/signout_usecase.dart';
import '../../features/domain/usecases/auth/update_profile_pic_usecase.dart';
import '../../features/domain/usecases/auth/verify_otp_usecase.dart';
import '../../features/domain/usecases/chat/get_chat_messages_usecase.dart';
import '../../features/domain/usecases/chat/get_contacts_chat_usecase.dart';
import '../../features/domain/usecases/chat/get_num_of_message_not_seen_usecase.dart';
import '../../features/domain/usecases/chat/send_file_message_usecase.dart';
import '../../features/domain/usecases/chat/send_gif_message_usecase.dart';
import '../../features/domain/usecases/chat/send_text_message_usecase.dart';
import '../../features/domain/usecases/chat/set_chat_message_seen_usecase.dart';
import '../../features/domain/usecases/select_contact/get_all_contacts_usecase.dart';
import '../../features/domain/usecases/select_contact/get_contacts_not_on_whats_usecase.dart';
import '../../features/domain/usecases/select_contact/get_contacts_on_whats_usecase.dart';
import '../../features/presentation/controllers/auth_cubit/auth_cubit.dart';
import '../../features/presentation/controllers/bottom_chat_cubit/bottom_chat_cubit.dart';
import '../../features/presentation/controllers/chat_cubit/chat_cubit.dart';
import '../../features/presentation/controllers/select_contact_cubit/select_contact_cubit.dart';
import '../network/cache_helper.dart';

final sl = GetIt.instance;

Future<void> init() async {
  ///shared prefs
  final sharedPref = await SharedPreferences.getInstance();

  sl.registerLazySingleton<SharedPreferences>(() => sharedPref);
  sl.registerLazySingleton<CacheHelper>(() => CacheHelper(sl()));

  ///cubit
  sl.registerFactory(
      () => AuthCubit(sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl(), sl()));
  sl.registerFactory(() => SelectContactCubit(sl(), sl(), sl()));
  sl.registerFactory(() => ChatCubit(sl(), sl(), sl(), sl(), sl(), sl(),sl()));
  sl.registerLazySingleton(() => BottomChatCubit());
  sl.registerLazySingleton(() => ChatBackgroundCubit());
  sl.registerLazySingleton(() => CallCubit(sl(), sl(), sl()));

  ///use case
  /////////auth
  sl.registerLazySingleton(() => SignInWithPhoneNumberUseCase(sl()));
  sl.registerLazySingleton(() => VerifyOtpUseCase(sl()));
  sl.registerLazySingleton(() => SaveUserDataToFirebaseUseCase(sl()));
  sl.registerLazySingleton(() => GetCurrentUidUseCase(sl()));
  sl.registerLazySingleton(() => SignOutUseCase(sl()));
  sl.registerLazySingleton(() => GetCachedLocalCurrentUidUseCase(sl()));
  sl.registerLazySingleton(() => GetUserByIdUseCase(sl()));
  sl.registerLazySingleton(() => SetUserStateUseCase(sl()));
  sl.registerLazySingleton(() => GetCurrentUserUseCase(sl()));
  sl.registerLazySingleton(() => UpdateProfilePicUseCase(sl()));
  ////////select contact
  sl.registerLazySingleton(() => GetAllContactsUseCase(sl()));
  sl.registerLazySingleton(() => GetContactsOnWhatsUseCase(sl()));
  sl.registerLazySingleton(() => GetContactsNotOnWhatsUseCase(sl()));
  ///////chat
  sl.registerLazySingleton(() => SendTextMessageUseCase(sl()));
  sl.registerLazySingleton(() => GetContactsChatUseCase(sl()));
  sl.registerLazySingleton(() => GetChatMessagesUseCase(sl()));
  sl.registerLazySingleton(() => SetChatMessageSeenUseCase(sl()));
  sl.registerLazySingleton(() => SendGifMessageUseCase(sl()));
  sl.registerLazySingleton(() => SendFileMessageUseCase(sl()));
  sl.registerLazySingleton(() => GetNumberOfMessageNotSeenUseCase(sl()));
  // sl.registerLazySingleton(() => GetContactNameUseCase(sl()));
  /////call
  sl.registerLazySingleton(() => CallStreamUseCase(sl()));
  sl.registerLazySingleton(() => EndCallUseCase(sl()));
  sl.registerLazySingleton(() => MakeCallUseCase(sl()));
  ///repository
  sl.registerLazySingleton<BaseAuthRepository>(
    () => AuthRepository(localDataSource: sl(), remoteDataSource: sl()),
  );

  sl.registerLazySingleton<BaseSelectContactRepository>(
    () => SelectContactRepository(sl(), sl()),
  );

  sl.registerLazySingleton<BaseChatRepository>(() => ChatRepository(sl()));

  sl.registerLazySingleton<BaseCallRepository>(() => CallRepository(sl()));
  ///remote data source
  sl.registerLazySingleton<BaseAuthRemoteDataSource>(
    () => AuthRemoteDataSource(
      auth: sl(),
      firestore: sl(),
      firebaseStorage: sl(),
    ),
  );
  sl.registerLazySingleton<BaseSelectContactsRemoteDataSource>(
    () => SelectContactsRemoteDataSource(sl(), sl()),
  );
  sl.registerLazySingleton<BaseChatRemoteDataSource>(
    () => ChatRemoteDataSource(sl(), sl(), sl()),
  );

  sl.registerLazySingleton(() => CallDataSource(sl(), sl()));
  /// local data source
  sl.registerLazySingleton<BaseAuthLocalDataSource>(
    () => AuthLocalDataSource(sharedPreferences: sl()),
  );
  sl.registerLazySingleton<BaseSelectContactsLocalDataSource>(
    () => SelectContactsLocalDataSource(),
  );

  //External
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  final firebaseStorage = FirebaseStorage.instance;

  sl.registerLazySingleton(() => auth);
  sl.registerLazySingleton(() => firestore);
  sl.registerLazySingleton(() => firebaseStorage);
}
