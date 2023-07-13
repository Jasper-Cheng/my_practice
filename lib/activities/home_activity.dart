import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../dialogs/food_dialog.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen')),
      body: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  displayDialog(context);
                },
                child: Text("Show Dialog"),
              ),
              ElevatedButton(
                onPressed: () => context.go('/details'),
                child: const Text('Go to the Details screen'),
              ),
            ],
          )
      ),
    );
  }
}