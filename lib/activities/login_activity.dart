import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../controllers/application_controller.dart';

class LoginScreen extends StatelessWidget {

  final String? location;
  final String? text;
  const LoginScreen({super.key, this.location,this.text});

  @override
  Widget build(BuildContext context) {
    print("state.location=${location}");
    return Scaffold(
      appBar: AppBar(title: const Text('Login Screen')),
      body: Center(
        child: ElevatedButton(
          onPressed: (){
            Provider.of<ApplicationController>(context, listen: false).isSignedIn=true;
            if(location==null){
              context.go("/");
            }else{
              context.go(location!);
            }
          },
          child: Text(text??"登录"),
        ),
      ),
    );
  }
}