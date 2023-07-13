import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'activities/detail_activity.dart';
import 'activities/home_activity.dart';
import 'activities/login_activity.dart';
import 'controllers/application_controller.dart';

class FlutterRouter{
  //所有页面跳转路由放在这里
  static List<RouteBase> routerList=[
    GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const HomeScreen();
        },
        routes: [
          GoRoute(
            name: 'login',
            path: 'login',
            builder: (BuildContext context, GoRouterState state) {
              String? location=state.queryParameters["location"];
              String? text=state.queryParameters["text"];
              return LoginScreen(location: location,text: text,);
            },
          ),
          GoRoute(
              name: "details",
              path: 'details',
              builder: (BuildContext context, GoRouterState state) {
                return const DetailsScreen();
              },
              redirect: loginRedirect
          ),
        ]
    ),
  ];


  //未登录重定向
  static FutureOr<String?> loginRedirect(BuildContext context, GoRouterState state) {
    if (!Provider.of<ApplicationController>(context, listen: false).isSignedIn) {
      return state.namedLocation("login",queryParameters: {
        "location":state.location,
        "text":"未登录返回登录"
      });
    } else {
      return state.location;
    }
  }
}