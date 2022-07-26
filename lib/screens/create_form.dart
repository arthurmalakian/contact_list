import 'dart:io';

import 'package:contact_list/components/image_input.dart';
import 'package:contact_list/providers/contacts_provider.dart';
import 'package:contact_list/utils/routing_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/contact.dart';
import '../services/contacts_service.dart';

class CreateForm extends StatefulWidget {
  @override
  _CreateForm createState() => _CreateForm();
}

class _CreateForm extends State<CreateForm> {
  File? _pickedImage;

  void _selectImage(File? pickedImage) {
    _pickedImage = pickedImage;
  }

  Future<dynamic> _store(Contact contact, File? image) async {
    var provider = Provider.of<ContactsProvider>(context, listen: false);
    provider.mergeContact(await ContactsService.store(contact, image));
    provider.setIsProcessing(false);
  }

  Widget build(BuildContext context) {
    Contact contact = ModalRoute.of(context)!.settings.arguments as Contact;
    return Scaffold(
      appBar: AppBar(title: Text("Add Contact")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _store(contact, _pickedImage);
            Navigator.pushNamedAndRemoveUntil(
                context, RoutingUtil.INDEX, (route) => false);
          });
        },
        child: const Icon(Icons.save),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: TextFormField(
                    initialValue: contact.name,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      icon: Icon(Icons.account_box),
                    ),
                    keyboardType: TextInputType.text,
                    onChanged: (text) {
                      contact.name = text;
                    },
                  )),
              Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: TextFormField(
                    initialValue: contact.surname,
                    decoration: const InputDecoration(
                      labelText: 'Surname',
                      icon: Icon(Icons.account_box),
                    ),
                    keyboardType: TextInputType.text,
                    onChanged: (text) {
                      contact.surname = text;
                    },
                  )),
              Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: TextFormField(
                    initialValue: contact.phone,
                    decoration: const InputDecoration(
                      labelText: 'Phone',
                      icon: Icon(Icons.phone),
                    ),
                    keyboardType: TextInputType.text,
                    onChanged: (text) {
                      contact.phone = text;
                    },
                  )),
              Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: TextFormField(
                    initialValue: contact.email,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      icon: Icon(Icons.email),
                    ),
                    keyboardType: TextInputType.text,
                    onChanged: (text) {
                      contact.email = text;
                    },
                  )),
              Padding(
                  padding: const EdgeInsets.only(top: 32),
                  child: ImageInput(_selectImage))
            ],
          )),
    );
  }
}
