import 'dart:io';
import 'package:contact_list/models/contact.dart';
import 'package:contact_list/services/contacts_service.dart';
import 'package:flutter/material.dart';

class ContactsProvider extends ChangeNotifier {
  bool _isProcessing = true;

  List<Contact> _contactList = [];

  bool get isProcessing => _isProcessing;

  setIsProcessing(bool value) {
    _isProcessing = value;
    notifyListeners();
  }

  List<Contact> get contacts => _contactList;

  setContacts(List<Contact> contactList) {
    _contactList = contactList;
  }

  mergeContact(Contact contact) async {
    setContacts(await ContactsService.index());
    notifyListeners();
  }

  updateContact(Contact contact) async {
    setContacts(await ContactsService.index());
    notifyListeners();
  }

  removeContact(Contact contact) async {
    setContacts(await ContactsService.index());
    notifyListeners();
  }

  Contact getContactByIndex(int index) => _contactList[index];
  Contact setContactByIndex(int index, Contact contact) =>
      _contactList[index] = contact;
}
