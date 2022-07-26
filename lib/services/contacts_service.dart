import 'dart:convert';
import 'dart:io';
import 'package:contact_list/models/contact.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ContactsService {
  static String baseUrl = 'http://localhost/api/contacts';
  static Future<List<Contact>> index() async {
    final response = await http.get(
      Uri.parse(baseUrl),
    );

    if (response.statusCode == 200) {
      final list = jsonDecode(response.body).cast<Map<String, dynamic>>();
      return list.map<Contact>((item) => Contact.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load albums');
    }
  }

  static Future store(Contact contact, File? image) async {
    var requestBody = {
      'id': contact.id,
      'name': contact.name,
      'surname': contact.surname,
      'phone': contact.phone,
      'email': contact.email,
      'status': "NORMAL",
      'image': image,
    };
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: json.encode(requestBody),
    );
    if (response.statusCode == 201) {
      return Contact.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create contact.');
    }
  }

  static Future update(Contact contact, File? image) async {
    var requestBody = {
      'id': contact.id,
      'name': contact.name,
      'surname': contact.surname,
      'phone': contact.phone,
      'email': contact.email,
      'status': contact.status,
      'image': image,
    };
    final id = contact.id;
    final response = await http.patch(
      Uri.parse('$baseUrl/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: json.encode(requestBody),
    );
    if (response.statusCode == 200) {
      return Contact.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create contact.');
    }
  }

  static Future destroy(Contact contact) async {
    final id = contact.id;
    final response = await http.delete(
      Uri.parse('$baseUrl/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return Contact.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update contact.');
    }
  }
}
