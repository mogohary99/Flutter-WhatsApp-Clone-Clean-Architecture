import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../../domain/repository/base_call_repository.dart';
import '../../domain/usecases/call/end_call_usecase.dart';
import '../../domain/usecases/call/make_call_usecase.dart';
import '../data_source/call/call_data_source.dart';

class CallRepository extends BaseCallRepository{
  final CallDataSource _callDataSource;

  CallRepository(this._callDataSource);

  @override
  Stream<DocumentSnapshot<Object?>> callStream() => _callDataSource.callStream();

  @override
  Future<Either<Failure, void>> endCall(EndCallParameters parameters) async{
    final result = await _callDataSource.endCall(parameters);
    try{
      return Right(result);
    }on FirebaseException catch(failure){
      return Left(ServerFailure(failure.message!));
    }
  }

  @override
  Future<Either<Failure, void>> makeCall(MakeCallParameters parameters)async {
    final result = await _callDataSource.makeCall(parameters);
    try{
      return Right(result);
    }on FirebaseException catch(failure){
      return Left(ServerFailure(failure.message!));
    }
  }
}