import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_practice/controllers/application_controller.dart';
import 'package:my_practice/router.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    /*
    使用ChangeNotifierProvider包裹整个页面，当ApplicationController里面的对应数据更新时
    所有使用过ApplicationController对应数据的页面均会更新，为了避免单独widget使用但却整个
    页面刷新的情况，我们可以在具体使用ApplicationController数据的地方使用Consumer包裹，
    这样当ApplicationController数据源改变时就可以只刷新单个widget
    */
    //ApplicationController 是顶级的Provider
    ChangeNotifierProvider(
      create: (context) => ApplicationController(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: GoRouter(
          routes: FlutterRouter.routerList
      ),
    );
  }
}


