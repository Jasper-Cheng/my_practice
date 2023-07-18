import 'dart:async';

import 'package:flutter/material.dart';

//定时器加ValueNotifier实现，拖拽有问题
class MarqueeTimerWidget extends StatefulWidget {
  final String text;
  final TextStyle textStyle;
  final int scrollSpeed;
  final bool enableDrag;
  final double? beganSpace;
  final double? endSpace;

  const MarqueeTimerWidget({Key? key,required this.text,required this.textStyle, this.scrollSpeed=26, this.enableDrag=true, this.beganSpace, this.endSpace}) : super(key: key);

  @override
  State<MarqueeTimerWidget> createState() => _MarqueeTimerWidgetState();
}

class _MarqueeTimerWidgetState extends State<MarqueeTimerWidget> with WidgetsBindingObserver{
  late Timer _timer;
  late Size textSize;
  double _maxWidth=0;
  late ValueNotifier<double> _counter;
  bool touchPause=false;
  int totalBase=0;
  double baseWidth=0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    textSize=_getTextSize(widget.text,widget.textStyle);
    _counter = ValueNotifier<double>(0);
    _timer=Timer.periodic(Duration(milliseconds: widget.scrollSpeed), (timer) {
      if(!touchPause){
        if(_counter.value>-(baseWidth+(widget.beganSpace??0))){
          _counter.value--;
        }else{
          _counter.value=0;
        }
      }
    });
  }


  @override
  void dispose() {
    if (_timer.isActive) {  // 判断定时器是否是激活状态
      _timer.cancel();
    }
    // controller.dispose();
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
    //进入应用时候不会触发该状态 应用程序处于可见状态，并且可以响应用户的输入事件。它相当于 Android 中Activity的onResume
      case AppLifecycleState.resumed:
        _timer=Timer.periodic(Duration(milliseconds: widget.scrollSpeed), (timer) {
          if(!touchPause){
            if(_counter.value>=-textSize.width){
              _counter.value--;
            }else{
              _counter.value=_maxWidth;
            }
          }
        });
        break;
    //应用状态处于闲置状态，并且没有用户的输入事件，
    // 注意：这个状态切换到 前后台 会触发，所以流程应该是先冻结窗口，然后停止UI
      case AppLifecycleState.inactive:
        if (_timer.isActive) {  // 判断定时器是否是激活状态
          _timer.cancel();
        }
        break;
    //当前页面即将退出
      case AppLifecycleState.detached:
        if (_timer.isActive) {  // 判断定时器是否是激活状态
          _timer.cancel();
        }
        break;
    // 应用程序处于不可见状态
      case AppLifecycleState.paused:
        if (_timer.isActive) {  // 判断定时器是否是激活状态
          _timer.cancel();
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    //LayoutBuilder用来获取最大可滚动范围
    return LayoutBuilder(
      builder: (context, constraints){
        _maxWidth=constraints.maxWidth;
        _counter.value=widget.beganSpace==null?_maxWidth:widget.beganSpace!;
        baseWidth=(textSize.width+(widget.endSpace??0));
        totalBase=(_maxWidth/baseWidth).ceil()+1;
        return GestureDetector(
          child: Stack(
            alignment: Alignment.centerLeft,
            children: generateWidget()
          ),
          onHorizontalDragDown: (detail){
            widget.enableDrag?touchPause=true:null;
          },
          onHorizontalDragUpdate: (detail){
            widget.enableDrag?_counter.value=_counter.value+detail.delta.dx:null;
          },
          onHorizontalDragEnd: (detail){
            widget.enableDrag?touchPause=false:null;
          },
        );
      },
    );
  }

  List<Widget> generateWidget(){
    List<Widget> list=[];
    for(int i=0;i<totalBase;i++){
      list.add(
        ValueListenableBuilder<double>(
          builder: (context,value,child){
            return Positioned(
              // left: widget.enableScroll?animation.value:0,
              left: (widget.beganSpace??0)+(i*baseWidth)+_counter.value,
              child: Text(
                widget.text,
                style: widget.textStyle,
                overflow: TextOverflow.clip,
                softWrap: false,
              ),
            );
          },
          valueListenable: _counter,
        ),
      );
    }
    return list;
  }

  //获取text的size
  Size _getTextSize(String text, TextStyle? style) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: style), maxLines: 1, textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }
}
