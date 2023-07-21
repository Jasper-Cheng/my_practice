import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:my_practice/widgets/marquee_widget.dart';

import '../widgets/marquee_timer_widget.dart';



class DetailsScreen extends StatelessWidget {
  /// Constructs a [DetailsScreen]
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: true,
        child: Column(
          children: [
            Container(
              width: 300,
              height: 20,
              margin: EdgeInsets.only(top: 100,left: 50,right: 50,bottom: 100),
              color: Colors.black,
              child: Marquee(
                text: "拉萨北京爱丽丝巴斯克贝拉发表labs地方labs的发表喇叭发生了比较",
                style: TextStyle(color: Colors.white,fontSize: 16),
                scrollAxis: Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.start,
                velocity: 40.0,
                fadingEdgeEndFraction: 0.4,
              ),
            ),
            Container(
              width: 300,
              height: 20,
              margin: EdgeInsets.only(top: 100,left: 50,right: 50,bottom: 100),
              color: Colors.black,
              child: MarqueeWidget(
                enableScroll: true,
                gaspSpace: 10,
                beganSpace: 100,
                text: "拉萨北京爱丽丝巴斯克贝拉发表labs地方labs的发表喇叭发生了比较",
                textStyle: TextStyle(color: Colors.white,fontSize: 16),
              ),
            )
          ],
        ),
      ),
    );
  }
}