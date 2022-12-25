part of 'select_contact_cubit.dart';

abstract class SelectContactState extends Equatable {
  const SelectContactState();
}

class SelectContactInitial extends SelectContactState {
  @override
  List<Object> get props => [];
}
///get all contacts
class GetAllContactsLoadingState extends SelectContactState {
  @override
  List<Object> get props => [];
}

class GetAllContactsSuccessState extends SelectContactState {
  @override
  List<Object> get props => [];
}

class GetAllContactsErrorState extends SelectContactState {
  @override
  List<Object> get props => [];
}
///get contacts not on whats
class GetContactsNotOnWhatsLoadingState extends SelectContactState {
  @override
  List<Object> get props => [];
}

class GetContactsNotOnWhatsSuccessState extends SelectContactState {
  @override
  List<Object> get props => [];
}

class GetContactsNotOnWhatsErrorState extends SelectContactState {
  @override
  List<Object> get props => [];
}
/// get contacts on whatsApp
class GetContactsOnWhatsLoadingState extends SelectContactState {
  @override
  List<Object> get props => [];
}

class GetContactsOnWhatsSuccessState extends SelectContactState {
  @override
  List<Object> get props => [];
}

class GetContactsOnWhatsErrorState extends SelectContactState {
  @override
  List<Object> get props => [];
}