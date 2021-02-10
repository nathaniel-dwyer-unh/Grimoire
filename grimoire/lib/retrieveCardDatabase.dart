import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

/* 
References:
  - Fetching data via http: https://flutter.dev/docs/cookbook/networking/fetch-data 
*/

Future<Cards> fetchCards() async {
  final response =
      await http.get(Uri.https('jsonplaceholder.typicode.com', 'albums/1'));

  if (response.statusCode == 200) {
    // 200 is a successful status code
    // if the server did return a 200 OK response
    // then parse the JSON
    return Cards.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response
    // then throw an exception
    throw Exception('Failed to load card database');
  }
}

class Cards {
  final int userId;
  final int id;
  final String title;

  Cards({this.userId, this.id, this.title});

  factory Cards.fromJson(Map<String, dynamic> json) {
    // this creates a json object that we can fill with card info
    return Cards(
      userId: json['userId'],
      id: json['id'],
      title: json['title'], // ['data'][cardName][0]['convertedManaCost']
    );
  }
}

class RetrieveCardDatabase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      onPressed: null,
      child: Text('Retrieve/Load MTGJSON!'),
      splashColor: Colors.purple,
    );
  }
}
