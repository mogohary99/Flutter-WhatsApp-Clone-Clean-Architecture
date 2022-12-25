import 'package:dartz/dartz.dart';
import 'package:flutter_contacts/contact.dart';

import '../../../core/error/failure.dart';
import '../usecases/select_contact/get_contact_name_usecase.dart';

abstract class BaseSelectContactRepository{
Future<Either<Failure,void>> getAllContacts();
Future<Either<Failure,List<Contact>>> getContactsNotOnWhatsApp();
Future<Either<Failure,Map<String,dynamic>>> getContactsOnWhatsApp();
//Future<Either<Failure,String>> getContactName(ContactNameParameters parameters);
}