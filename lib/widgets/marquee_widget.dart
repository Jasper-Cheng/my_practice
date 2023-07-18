import 'package:flutter/material.dart';

//动画实现,拖拽有问题
class MarqueeWidget extends StatefulWidget {
  final String text;
  final TextStyle textStyle;
  final int scrollSpeed;
  final bool enableScroll;

  const MarqueeWidget({Key? key,required this.text,required this.textStyle, this.scrollSpeed=40, this.enableScroll=true,}) : super(key: key);

  @override
  State<MarqueeWidget> createState() => _MarqueeWidgetState();
}

class _MarqueeWidgetState extends State<MarqueeWidget> with SingleTickerProviderStateMixin{
  late Animation<double> animation;
  late AnimationController controller;
  Tween<double> tween=Tween(begin: 0.0,end: 0.0);
  GlobalKey globalKey=GlobalKey();
  late Size textSize;
  late Size newTextSize;
  String newText="";
  double _maxWidth=0;

  @override
  void initState() {
    super.initState();
    textSize=_getTextSize(widget.text,widget.textStyle);
    tween.end=-textSize.width;
    controller=AnimationController(
        vsync: this,
        duration: Duration(milliseconds:(textSize.width/(widget.scrollSpeed/1000)).ceil()),
    );
    animation=tween.animate(controller);
    // addListener： 每一帧都会调用，调用之后一般使用setState来刷新界面
    animation.addListener(() {
      debugPrint("animation.value=${animation.value}");
      debugPrint("controller.value=${controller.value}");
    });
    // addStatusListener：监听动画当前的状态 如动画开始、结束、正向或反向
    animation.addStatusListener((status) {
      debugPrint('status $status');
      switch (status){
        case AnimationStatus.dismissed:
          break;
        case AnimationStatus.forward:
          break;
        case AnimationStatus.reverse:
          break;
        case AnimationStatus.completed:
          break;
      };
    });
    controller.repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //LayoutBuilder用来获取最大可滚动范围
    return LayoutBuilder(
      builder: (context, constraints){
        _maxWidth=constraints.maxWidth;
        newText=generateNewText();
        newTextSize=_getTextSize(newText,widget.textStyle);
        //AnimatedBuilder用来刷新包裹的widget
        return AnimatedBuilder(
          animation: animation,
          builder: (context, child){
            return GestureDetector(
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Positioned(
                    key: globalKey,
                    left: widget.enableScroll?animation.value:0,
                    child: child??Container(),
                  )
                ],
              ),
              onHorizontalDragDown: (detail){
              },
              onHorizontalDragUpdate: (detail){
              },
              onHorizontalDragEnd: (detail){
              },
            );
          },
          child: Text(
            newText,
            style: widget.textStyle,
            overflow: TextOverflow.clip,
            softWrap: false,
          ),
        );
      },
    );
  }

  String generateNewText(){
    int i=(_maxWidth/textSize.width).ceil();
    String a=widget.text*i;
    debugPrint("widget.text+a=${widget.text+a}");
    return widget.text+a;
  }

  //获取text的size
  Size _getTextSize(String text, TextStyle? style) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: style), maxLines: 1, textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }
}
