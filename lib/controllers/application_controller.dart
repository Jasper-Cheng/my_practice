import 'package:flutter/cupertino.dart';

//实际上就是一个数据model
class ApplicationController with ChangeNotifier {

  //是否登录的标识、后续换成token
  bool isSignedIn = false;
  //主题、国际化、全局变量等全局配置

  int _count = 0;
  // 读方法
  int get counter => _count;
  // 写方法
  void increment() {
    _count++;
    notifyListeners();// 通知听众刷新
  }

  void updateIsSignIn(bool login){
    isSignedIn=login;
    notifyListeners();
  }



}