part of 'call_cubit.dart';

abstract class CallState extends Equatable {
  const CallState();
}

class CallInitial extends CallState {
  @override
  List<Object> get props => [];
}

class MakeCallLoadingState extends CallState {
  @override
  List<Object> get props => [];
}

class MakeCallSuccessState extends CallState {
  @override
  List<Object> get props => [];
}

class MakeCallErrorState extends CallState {
  @override
  List<Object> get props => [];
}

class EndCallLoadingState extends CallState {
  @override
  List<Object> get props => [];
}

class EndCallSuccessState extends CallState {
  @override
  List<Object> get props => [];
}

class EndCallErrorState extends CallState {
  @override
  List<Object> get props => [];
}