import 'package:dartz/dartz.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:whatsapp_flutter_clone/core/error/failure.dart';
import 'package:whatsapp_flutter_clone/core/usecase/base_use_case.dart';
import 'package:whatsapp_flutter_clone/features/domain/repository/base_select_contact_repository.dart';

class GetContactsNotOnWhatsUseCase extends BaseUseCase<List<Contact>, NoParameters>{
  final BaseSelectContactRepository _baseSelectContactRepository;

  GetContactsNotOnWhatsUseCase(this._baseSelectContactRepository);
  @override
  Future<Either<Failure, List<Contact>>> call(NoParameters parameters) async{
    return await _baseSelectContactRepository.getContactsNotOnWhatsApp();
  }

}