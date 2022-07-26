import 'package:contact_list/components/contact_list.dart';
import 'package:contact_list/models/contact.dart';
import 'package:contact_list/providers/contacts_provider.dart';
import 'package:contact_list/services/contacts_service.dart';
import 'package:contact_list/utils/routing_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Index extends StatefulWidget {
  const Index({Key? key}) : super(key: key);

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  _index() async {
    var provider = Provider.of<ContactsProvider>(context, listen: false);
    provider.setContacts(await ContactsService.index());
    provider.setIsProcessing(false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _index();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact List"),
        actions: [
          IconButton(
            icon: const Icon(Icons.info),
            tooltip: 'Creator',
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext) {
                    return const AlertDialog(
                      content: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                            'Arthur Sérvulo Rodrigues dos Santos - 20180144775'),
                      ),
                    );
                  });
            },
          ),
        ],
      ),
      body: Consumer<ContactsProvider>(
          builder: (context, contacts, child) => contacts.isProcessing
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : contacts.contacts.isNotEmpty
                  ? ContactList(contacts: contacts.contacts)
                  : Center(child: Text('No contact registered.'))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, RoutingUtil.CREATE,
              arguments: Contact.empty());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
