import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/base_use_case.dart';
import '../../repository/base_select_contact_repository.dart';

class GetAllContactsUseCase extends BaseUseCase<void, NoParameters>{
  final BaseSelectContactRepository _baseSelectContactRepository;

  GetAllContactsUseCase(this._baseSelectContactRepository);
  @override
  Future<Either<Failure, void>> call(NoParameters parameters)async {
   return await _baseSelectContactRepository.getAllContacts();
  }
}