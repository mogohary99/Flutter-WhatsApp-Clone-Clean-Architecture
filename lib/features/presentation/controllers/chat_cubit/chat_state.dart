part of 'chat_cubit.dart';

abstract class ChatState extends Equatable {
  const ChatState();
}

class ChatInitial extends ChatState {
  @override
  List<Object> get props => [];
}

class SendMessageLoadingState extends ChatState{
  @override
  List<Object?> get props => [];
}

class SendMessageSuccessState extends ChatState{
  @override
  List<Object?> get props => [];
}

class SendMessageErrorState extends ChatState{
  @override
  List<Object?> get props => [];
}

class GetContactNameErrorState extends ChatState{
  @override
  List<Object?> get props => [];
}
class GetContactNameSuccessState extends ChatState{
  @override
  List<Object?> get props => [];
}

//message swipe
class MessageSwipeLoadingState extends ChatState{
  @override
  List<Object?> get props => [];
}
class MessageSwipeState extends ChatState{
  @override
  List<Object?> get props => [];
}

class CancelReplayState extends ChatState{
  @override
  List<Object?> get props => [];
}