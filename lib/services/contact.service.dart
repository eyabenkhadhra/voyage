import '../model/contact.model.dart';
import '../utils/contact.database.dart';

class ContactService {
  ContactDatabase contactDatabase = ContactDatabase();

  Future<List<Contact>> listeContacts() async{
    var contacts = await contactDatabase.recuperer();
    return contacts.map((item) => Contact.fromJson(item)).toList();
  }

  Future<bool> AjouterContact(Contact c) async{
    int res = await contactDatabase.inserer(c);
    return res > 0 ? true : false;
  }

  Future<bool> ModifierContact(Contact c) async{
    int res = await contactDatabase.modifier(c);
    return res > 0 ? true : false;
  }

  Future<bool> SupprimerContact(Contact c) async{
    int res = await contactDatabase.supprimer(c);
    return res > 0 ? true : false;
  }
}