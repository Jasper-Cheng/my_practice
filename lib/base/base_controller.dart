import 'dart:ui';

import 'package:flutter/cupertino.dart';

abstract class BaseController with ChangeNotifier{

  late BuildContext context;
  late State state;
  late String key;

  BaseController();

  void initController(State state);

  void postFrameCallback(FrameCallback callback) {
    WidgetsBinding.instance.addPostFrameCallback(callback);
  }

}