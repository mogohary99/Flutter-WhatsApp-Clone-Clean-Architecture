import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure{
  const ServerFailure(super.message);
}

class LocalDatabaseFailure extends Failure{
  const LocalDatabaseFailure(super.message);

}

class CachedFailure extends Failure{
  const CachedFailure(super.message);

}