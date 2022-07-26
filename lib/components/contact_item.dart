import 'dart:io';

import 'package:contact_list/models/contact.dart';
import 'package:contact_list/providers/contacts_provider.dart';
import 'package:contact_list/services/contacts_service.dart';
import 'package:contact_list/utils/routing_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactItem extends StatelessWidget {
  final Contact contact;

  const ContactItem(this.contact);

  _selectedContact(BuildContext context) {
    Navigator.of(context).pushNamed(
      RoutingUtil.SHOW,
      arguments: contact,
    );
  }

  _edit(BuildContext context) {
    Navigator.pushNamed(context, RoutingUtil.EDIT, arguments: contact);
  }

  _destroy(BuildContext context, Contact contact) async {
    var provider = Provider.of<ContactsProvider>(context, listen: false);
    provider.removeContact(await ContactsService.destroy(contact));
    provider.setIsProcessing(false);
  }

  _block(BuildContext context, Contact contact) async {
    contact.status = contact.status == "BLOQUEADO" ? 'NORMAL' : "BLOQUEADO";
    var provider = Provider.of<ContactsProvider>(context, listen: false);
    provider.updateContact(await ContactsService.update(contact, null));
    provider.setIsProcessing(false);
  }

  _favorite(BuildContext context, Contact contact) async {
    contact.status = contact.status == "FAVORITO" ? 'NORMAL' : "FAVORITO";
    var provider = Provider.of<ContactsProvider>(context, listen: false);
    provider.updateContact(await ContactsService.update(contact, null));
    provider.setIsProcessing(false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: const LinearGradient(
                colors: [Colors.blue, Colors.blueAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () => _selectedContact(context),
                    child: CircleAvatar(
                      minRadius: 30,
                      backgroundImage: NetworkImage(contact.picUrl != null
                          ? contact.picUrl.toString()
                          : 'https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_960_720.png'),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${contact.name.toString()} ${contact.surname.toString()}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(contact.phone.toString(),
                          style: const TextStyle(color: Colors.white))
                    ],
                  )
                ],
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RoutingUtil.EDIT,
                            arguments: contact);
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.white70,
                      )),
                  IconButton(
                    onPressed: (() => _destroy(context, contact)),
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: (() => _favorite(context, contact)),
                      icon: Icon(
                        Icons.star,
                        color: contact.status == Contact.FAVORITO
                            ? Colors.yellow
                            : Colors.white70,
                      )),
                  IconButton(
                    onPressed: (() => _block(context, contact)),
                    icon: Icon(
                      Icons.block,
                      color: contact.status == Contact.BLOQUEADO
                          ? Colors.red
                          : Colors.white70,
                    ),
                  ),
                ],
              )
            ],
          ),
        ]));
  }
}
