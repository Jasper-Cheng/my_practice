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
                text: "this .",
                style: TextStyle(color: Colors.white,fontSize: 16),
                scrollAxis: Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.start,
                blankSpace: 0.0,
                velocity: 40.0,
                startPadding: 100.0,
                fadingEdgeEndFraction: 0.4,
              ),
            ),
            Container(
              width: 300,
              height: 20,
              margin: EdgeInsets.only(top: 100,left: 50,right: 50,bottom: 100),
              color: Colors.black,
              child: MarqueeTimerWidget(
                beganSpace: 100,
                enableDrag: true,
                scrollSpeed: 26,
                text: "this.",
                textStyle: TextStyle(color: Colors.white,fontSize: 16),
              ),
            )
          ],
        ),
      ),
    );
  }
}