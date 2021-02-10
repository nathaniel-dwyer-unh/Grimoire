import 'package:flutter/material.dart';

class SearchMtgjson extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration:
              InputDecoration(hintText: 'Enter a MTG Card Name to Search'),
        ),
        OutlineButton(
          onPressed: null,
          child: Text('Search MTGJSON!'),
          splashColor: Colors.purple,
        ),
      ],
    );
  }
}
