import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/base_use_case.dart';
import '../../repository/base_call_repository.dart';

class MakeCallUseCase extends BaseUseCase<void, MakeCallParameters> {
  final BaseCallRepository _baseCallRepository;

  MakeCallUseCase(this._baseCallRepository);

  @override
  Future<Either<Failure, void>> call(MakeCallParameters parameters) async {
    return await _baseCallRepository.makeCall(parameters);
  }
}

class MakeCallParameters extends Equatable {
  final String receiverId;
  final String receiverName;
  final String receiverPic;

  const MakeCallParameters({
    required this.receiverId,
    required this.receiverName,
    required this.receiverPic,
  });

  @override
  List<Object?> get props => [
        receiverId,
        receiverName,
        receiverPic,
      ];
}
