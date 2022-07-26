import 'package:contact_list/providers/contacts_provider.dart';
import 'package:contact_list/screens/show.dart';
import 'package:contact_list/screens/create_form.dart';
import 'package:contact_list/screens/edit_form.dart';
import 'package:contact_list/screens/index.dart';
import 'package:contact_list/utils/routing_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ContactsProvider(),
        child: MaterialApp(
          title: 'Contact List',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: RoutingUtil.INDEX,
          routes: {
            RoutingUtil.INDEX: (context) => Index(),
            RoutingUtil.CREATE: (context) => CreateForm(),
            RoutingUtil.EDIT: (context) => EditForm(),
            RoutingUtil.SHOW: (context) => ContactDetails(),
          },
        ));
  }
}
