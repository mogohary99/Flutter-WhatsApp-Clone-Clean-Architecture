import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecase/base_use_case.dart';
import '../../../domain/usecases/call/call_stream_usecase.dart';
import '../../../domain/usecases/call/end_call_usecase.dart';
import '../../../domain/usecases/call/make_call_usecase.dart';

part 'call_state.dart';

class CallCubit extends Cubit<CallState> {
  final CallStreamUseCase _callStreamUseCase;
  final EndCallUseCase _endCallUseCase;
  final MakeCallUseCase _makeCallUseCase;

  CallCubit(
    this._callStreamUseCase,
    this._endCallUseCase,
    this._makeCallUseCase,
  ) : super(CallInitial());

  Stream<DocumentSnapshot> callStream() =>
      _callStreamUseCase(const NoParameters());

  Future<void> makeCall({
    required String receiverId,
    required String receiverName,
    required String receiverPic,
  }) async {
    emit(MakeCallLoadingState());
    final result = await _makeCallUseCase(
      MakeCallParameters(
        receiverId: receiverId,
        receiverName: receiverName,
        receiverPic: receiverPic,
      ),
    );
    result.fold(
      (l) => emit(MakeCallErrorState()),
      (r) => emit(MakeCallSuccessState()),
    );
  }

  Future<void> endCall({
    required String receiverId,
    required String callerId,
  }) async {
    emit(EndCallLoadingState());
    final result = await _endCallUseCase(
      EndCallParameters(
        receiverId: receiverId,
        callerId: callerId,
      ),
    );
    result.fold(
      (l) => emit(EndCallErrorState()),
      (r) => emit(EndCallSuccessState()),
    );
  }
}
