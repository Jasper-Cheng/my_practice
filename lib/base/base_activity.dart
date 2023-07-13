import 'package:flutter/cupertino.dart';

import 'base_controller.dart';

abstract class BaseActivity extends StatefulWidget {
  const BaseActivity({Key? key}) : super(key: key);

  @override
  State<BaseActivity> createState() => _BaseActivityState();
}

class _BaseActivityState extends State<BaseActivity> with WidgetsBindingObserver{
  BaseController? baseController;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }


}
