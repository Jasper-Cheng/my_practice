import 'package:flutter/material.dart';

class MarqueeWidget extends StatefulWidget {
  final String text;
  final TextStyle textStyle;
  final int scrollSpeed;
  final bool enableScroll;

  const MarqueeWidget({Key? key,required this.text,required this.textStyle, this.scrollSpeed=3000, this.enableScroll=true,}) : super(key: key);

  @override
  State<MarqueeWidget> createState() => _MarqueeWidgetState();
}

class _MarqueeWidgetState extends State<MarqueeWidget> with SingleTickerProviderStateMixin{
  late Animation<double> animation;
  late AnimationController controller;
  Tween<double> tween=Tween(begin: 0.0,end: 0.0);
  GlobalKey globalKey=GlobalKey();

  @override
  void initState() {
    super.initState();
    controller=AnimationController(
        vsync: this,
        duration: Duration(milliseconds:widget.scrollSpeed)
    );
    animation=tween.animate(controller);
    // addListener： 每一帧都会调用，调用之后一般使用setState来刷新界面
    // addStatusListener：监听动画当前的状态 如动画开始、结束、正向或反向
    animation.addStatusListener((status) {
      debugPrint('status $status');
      switch (status){
      //动画一开始就停止了
        case AnimationStatus.dismissed:
          break;
      //动画从头到尾都在播放
        case AnimationStatus.forward:
          break;
      //动画从结束到开始倒着播放
        case AnimationStatus.reverse:
          break;
      //动画播放完停止
        case AnimationStatus.completed:
          controller.repeat();
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
        Size size=_getTextSize(widget.text,widget.textStyle);
        tween.begin=constraints.maxWidth;
        tween.end=-size.width;
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
                // controller.stop(canceled:false);
              },
              onHorizontalDragUpdate: (detail){
                DragUpdateDetails updateDetails=detail;
                double a=animation.value+updateDetails.delta.dx;
                debugPrint("controller.value=${controller.value}");
                debugPrint("animation.value=${animation.value}");
                // controller.value=a;
                // controller.forward(from: a);
                // debugPrint("updateDetails.localPosition.dx=${updateDetails.delta.dx}");
              },
              onHorizontalDragEnd: (detail){
                // controller.forward();
              },
            );
          },
          child: Text(
            widget.text,
            style: widget.textStyle,
            overflow: TextOverflow.clip,
            softWrap: false,
          ),
        );
      },
    );
  }

  //获取text的size
  Size _getTextSize(String text, TextStyle? style) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: style), maxLines: 1, textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }
}
