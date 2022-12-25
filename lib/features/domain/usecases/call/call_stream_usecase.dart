import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/usecase/base_use_case.dart';
import '../../repository/base_call_repository.dart';

class CallStreamUseCase extends StreamBaseUseCase<DocumentSnapshot,NoParameters>{
  final BaseCallRepository _baseCallRepository;

  CallStreamUseCase(this._baseCallRepository);
  @override
  Stream<DocumentSnapshot> call(NoParameters parameters) {
    return _baseCallRepository.callStream();
  }
}