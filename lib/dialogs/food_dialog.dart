import 'package:flutter/material.dart';

displayDialog(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return SimpleDialog(
        title: Text('Choose food'),
        children:[
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context, "Pizza"); },
            child: const Text('Pizza'),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context, "Burger");
            },
            child: const Text('Burger'),
          ),
        ],
        elevation: 10,
        //backgroundColor: Colors.green,
      );
    },
  );
}