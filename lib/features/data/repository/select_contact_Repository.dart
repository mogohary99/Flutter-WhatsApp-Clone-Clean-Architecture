import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_contacts/contact.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/error/failure.dart';
import '../../domain/repository/base_select_contact_repository.dart';
import '../data_source/select_contact/local/get_contacts_local_data_source.dart';
import '../data_source/select_contact/remote/select_contact_remote_data_source.dart';

class SelectContactRepository extends BaseSelectContactRepository{
  final BaseSelectContactsRemoteDataSource remoteDataSource;
  final BaseSelectContactsLocalDataSource localDataSource;

  SelectContactRepository(this.remoteDataSource, this.localDataSource);

  @override
  Future<Either<Failure, void>> getAllContacts() async{
    final result = await remoteDataSource.getAllContacts(await localDataSource.getContacts());
    try{
      return Right(result);
    }on CachedException catch(failure){
      return Left(CachedFailure(failure.message));
    }on FirebaseAuthException catch(failure){
      return Left(ServerFailure(failure.message!));
    }
  }

  @override
  Future<Either<Failure, List<Contact>>> getContactsNotOnWhatsApp()async {
    final result = await remoteDataSource.contactsNotOnWhatsApp();
    try{
      return Right(result);
    }on FirebaseAuthException catch(failure){
      return Left(ServerFailure(failure.message!));
    }
  }

  @override
  Future<Either<Failure, Map<String,dynamic>>> getContactsOnWhatsApp()async {
    final result = await remoteDataSource.contactsOnWhatsApp();
    try{
      return Right(result);
    }on FirebaseAuthException catch(failure){
      return Left(ServerFailure(failure.message!));
    }
  }
/*
  @override
  Future<Either<Failure, String>> getContactName(ContactNameParameters parameters)async {
    final result = await remoteDataSource.getContactName(parameters);
    try{
      return Right(result);
    }on CachedException catch(failure){
      return Left(CachedFailure(failure.message));
    }
  }

 */
}