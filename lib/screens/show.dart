import 'package:contact_list/models/contact.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactDetails extends StatefulWidget {
  @override
  _ContactDetails createState() => _ContactDetails();
}

class _ContactDetails extends State<ContactDetails> {
  _launchCaller(String number) async {
    Uri url = Uri.parse('tel:$number');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget build(BuildContext context) {
    Contact contact = ModalRoute.of(context)!.settings.arguments as Contact;
    return Scaffold(
      appBar: AppBar(title: Text("Contact Details")),
      body: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                CircleAvatar(
                  minRadius: 150,
                  backgroundImage: NetworkImage(contact.picUrl != null
                      ? contact.picUrl.toString()
                      : 'https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_960_720.png'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      contact.name.toString(),
                      style: const TextStyle(color: Colors.black),
                    ),
                    InkWell(
                        onTap: () => _launchCaller(contact.phone.toString()),
                        child: Text(contact.phone.toString(),
                            style: const TextStyle(color: Colors.black))),
                  ],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      contact.email.toString(),
                      style: const TextStyle(color: Colors.black),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ]),
    );
  }
}
