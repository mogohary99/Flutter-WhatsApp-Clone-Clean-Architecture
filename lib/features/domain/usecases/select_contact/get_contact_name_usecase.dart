import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:whatsapp_flutter_clone/core/error/failure.dart';
import 'package:whatsapp_flutter_clone/core/usecase/base_use_case.dart';
import 'package:whatsapp_flutter_clone/features/domain/repository/base_select_contact_repository.dart';
/*
class GetContactNameUseCase extends BaseUseCase<String, ContactNameParameters>{
  final BaseSelectContactRepository _selectContactRepository;

  GetContactNameUseCase(this._selectContactRepository);

  @override
  Future<Either<Failure, String>> call(ContactNameParameters parameters)async {
   return await _selectContactRepository.getContactName(parameters);
  }

}

class ContactNameParameters extends Equatable{
  final String uId;

  const ContactNameParameters(this.uId);

  @override
  List<Object?> get props => [uId];
}

 */