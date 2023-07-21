import 'package:flutter/material.dart';

/*大概思路:
position left 边距 scrollDistance变量控制
例如 text="jasper"不足以显示完全jasper时newText="jasperjasperjasper"，
可以显示jasperja这样的宽度时间，newText="jasperjasperjasperjasper",以此类推
以jasper为基本的发射值区间[jasper.width,2*jasper.width]
每当值到达区间边界，重新赋值scrollDistance
触摸停止动画，动态更新dx的偏移量，抬起手重新开始动画并使用scrollOffset重新计算偏移，达到最大值时reset动画
使其重新发送值，如此就进入刚开始的循环
 */
class MarqueeWidget extends StatefulWidget {
  final String text;
  final TextStyle textStyle;
  final int scrollSpeed;
  final bool enableScroll;
  final int beganSpace;
  final int gaspSpace;

  const MarqueeWidget({Key? key,required this.text,required this.textStyle, this.scrollSpeed=40, this.enableScroll=true, this.beganSpace=0, this.gaspSpace=0, }) : super(key: key);

  @override
  State<MarqueeWidget> createState() => _MarqueeWidgetState();
}

class _MarqueeWidgetState extends State<MarqueeWidget> with SingleTickerProviderStateMixin{
  late Animation<double> animation;
  late AnimationController controller;
  Tween<double> tween=Tween(begin: 0.0,end: 0.0);
  late Size textSize;
  late Size newTextSize;
  String text="";
  String newText="";
  double _maxWidth=0;
  double scrollDistance=0;
  StateSetter? aState;
  double scrollOffset=0;

  @override
  void initState() {
    super.initState();
    int i=widget.gaspSpace;
    String a=" "*i;
    text=widget.text+a;
    textSize=_getTextSize(text,widget.textStyle);
    tween.begin=textSize.width;
    tween.end=textSize.width*2;
    controller=AnimationController(
        vsync: this,
        duration: Duration(milliseconds:(textSize.width/(widget.scrollSpeed/1000)).ceil()),
    );
    animation=tween.animate(controller);
    // addListener： 每一帧都会调用，调用之后一般使用setState来刷新界面
    animation.addListener(() {
      updateDistanceValue(animation.value);
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
      }
    });
    Future.delayed(Duration(milliseconds: 100),(){
      controller.repeat();
    });
  }

  void updateDistanceValue(double baseValue){
    if(aState!=null){
      aState!((){
        if(0<baseValue+scrollOffset&&baseValue+scrollOffset<tween.end!){
          scrollDistance=baseValue+scrollOffset;
        }else{
          scrollDistance=tween.begin!;
          if(scrollOffset!=0){
            scrollOffset=0;
            controller.reset();
            controller.repeat();
          }
        }
      });
    }
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
        return GestureDetector(
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              StatefulBuilder(
                builder: (context, setInnerState) {
                  aState=setInnerState;
                  return Positioned(
                    left: -scrollDistance,
                    child: Text(
                      newText,
                      style: widget.textStyle,
                      overflow: TextOverflow.clip,
                      softWrap: false,
                    ),
                  );
                },
              )
            ],
          ),
          onHorizontalDragDown: (detail){
            if(widget.enableScroll){
              scrollOffset=0;
              controller.stop();
            }
          },
          onHorizontalDragUpdate: (detail){
            if(widget.enableScroll){
              updateDistanceValue(scrollDistance-detail.delta.dx);
            }
          },
          onHorizontalDragEnd: (detail){
            if(widget.enableScroll){
              scrollOffset=scrollDistance-tween.begin!;
              controller.reset();
              controller.repeat();
            }
          },
        );
      },
    );
  }

  String generateNewText(){
    int i=(_maxWidth/textSize.width).ceil();
    String a=text*i;
    return text+text+a;
  }

  //获取text的size
  Size _getTextSize(String text, TextStyle? style) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: style), maxLines: 1, textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }
}
