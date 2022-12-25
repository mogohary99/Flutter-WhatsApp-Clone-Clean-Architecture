import 'package:flutter_contacts/flutter_contacts.dart';
import '/core/error/exceptions.dart';

abstract class BaseSelectContactsLocalDataSource{
  Future<List<Contact>> getContacts();
}

class SelectContactsLocalDataSource extends BaseSelectContactsLocalDataSource{
  @override
  Future<List<Contact>> getContacts()async {
   if(await FlutterContacts.requestPermission()){
     return await FlutterContacts.getContacts(withProperties: true,);
   }else{
     throw(const CachedException(message: 'Not Allowed to get contacts'));
   }
  }
}