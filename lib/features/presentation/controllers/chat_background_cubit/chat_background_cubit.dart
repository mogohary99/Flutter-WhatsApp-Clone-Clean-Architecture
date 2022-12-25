import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whatsapp_flutter_clone/core/utils/constants/assets_manager.dart';

part 'chat_background_state.dart';

class ChatBackgroundCubit extends Cubit<ChatBackgroundState> {
  ChatBackgroundCubit() : super(ChatBackgroundInitial());
  static ChatBackgroundCubit get(context) => BlocProvider.of(context);

  String backgroundImage =AppImage.chatBackground;

  void changeBackground(String image){
    emit(ChangeBackgroundLoadingState());
    backgroundImage= image;
    emit(ChangeBackgroundSuccessState());
  }
}
