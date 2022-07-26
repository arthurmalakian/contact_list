import 'package:contact_list/components/contact_item.dart';
import 'package:contact_list/models/contact.dart';
import 'package:flutter/material.dart';

class ContactList extends StatelessWidget {
  const ContactList({Key? key, required this.contacts}) : super(key: key);

  final List<Contact> contacts;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        height: double.infinity,
        child: GridView.builder(
            padding: const EdgeInsets.all(15),
            itemCount: contacts.length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
            itemBuilder: (context, index) {
              return ContactItem(contacts[index]);
            }));
  }
}
