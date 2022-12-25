import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/base_use_case.dart';
import '../../repository/base_select_contact_repository.dart';

class GetContactsOnWhatsUseCase extends BaseUseCase<Map<String,dynamic>, NoParameters>{
  final BaseSelectContactRepository _baseSelectContactRepository;

  GetContactsOnWhatsUseCase(this._baseSelectContactRepository);
  @override
  Future<Either<Failure, Map<String,dynamic>>> call(NoParameters parameters)async {
   return await _baseSelectContactRepository.getContactsOnWhatsApp();
  }

}