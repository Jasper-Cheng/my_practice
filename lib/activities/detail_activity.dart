import 'package:flutter/material.dart';
import 'package:my_practice/widgets/marquee_widget.dart';

class DetailsScreen extends StatelessWidget {
  /// Constructs a [DetailsScreen]
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: true,
        child: Container(
          width: 300,
          height: 20,
          margin: EdgeInsets.only(top: 100,left: 50,right: 50,bottom: 100),
          color: Colors.black,
          child: MarqueeWidget(
            scrollSpeed: 10000,
            text: "this is my jasper private palace, take your picket and respect invite to see me.",
            textStyle: TextStyle(color: Colors.white,fontSize: 16),
          ),
        ),
      ),
    );
  }
}