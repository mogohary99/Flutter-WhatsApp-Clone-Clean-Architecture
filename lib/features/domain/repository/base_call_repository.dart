import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:whatsapp_flutter_clone/features/domain/entities/call.dart';

import '../../../core/error/failure.dart';
import '../usecases/call/end_call_usecase.dart';
import '../usecases/call/make_call_usecase.dart';

abstract class BaseCallRepository{
Future<Either<Failure,Call>> makeCall(MakeCallParameters parameters);
Future<Either<Failure,void>> endCall(EndCallParameters parameters);
Stream<DocumentSnapshot> callStream();
}