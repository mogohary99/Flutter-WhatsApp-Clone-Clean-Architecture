import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts/contact.dart';

import '../../../../core/usecase/base_use_case.dart';
import '../../../domain/usecases/select_contact/get_all_contacts_usecase.dart';
import '../../../domain/usecases/select_contact/get_contacts_not_on_whats_usecase.dart';
import '../../../domain/usecases/select_contact/get_contacts_on_whats_usecase.dart';

part 'select_contact_state.dart';

class SelectContactCubit extends Cubit<SelectContactState> {
  final GetAllContactsUseCase _getAllContactsUseCase;
  final GetContactsOnWhatsUseCase _getContactsOnWhatsUseCase;
  final GetContactsNotOnWhatsUseCase _getContactsNotOnWhatsUseCase;

  SelectContactCubit(
    this._getAllContactsUseCase,
    this._getContactsOnWhatsUseCase,
    this._getContactsNotOnWhatsUseCase,
  ) : super(SelectContactInitial());

  static SelectContactCubit get(context) => BlocProvider.of(context);

  Future<void> getAllContacts() async {
    emit(GetAllContactsLoadingState());
    final result = await _getAllContactsUseCase(const NoParameters());
    result.fold(
      (l) => emit(GetAllContactsErrorState()),
      (r) => emit(GetAllContactsSuccessState()),
    );
  }

///////////
  List<Contact> contactNotOnWhats=[];

  Future<void> getContactsNotOnWhatsApp() async {
    emit(GetContactsNotOnWhatsLoadingState());
    contactNotOnWhats = [];
    final result = await _getContactsNotOnWhatsUseCase(const NoParameters());
    result.fold(
      (l) => emit(GetContactsNotOnWhatsErrorState()),
      (r) {
        for (var element in r) {
          contactNotOnWhats.add(element);
        }
        emit(GetContactsNotOnWhatsSuccessState());
      } ,
    );
  }

////////////
  Map<String,dynamic> contactOnWhats={};
  Future<void> getContactsOnWhatsApp() async {
    emit(GetContactsOnWhatsLoadingState());
    //contactOnWhats = {};
    final result = await _getContactsOnWhatsUseCase(const NoParameters());
    result.fold(
      (l) => emit(GetContactsOnWhatsErrorState()),
      (r) {
        contactOnWhats.addAll(r);
        emit(GetContactsOnWhatsSuccessState());
      },
    );
  }

}
