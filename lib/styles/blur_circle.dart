import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

Widget blurredCircle(double size,int time){
  return Stack(
    children:[

    Animate(
      effects: [

           FadeEffect(duration: Duration(seconds: time*2)),
    ScaleEffect(begin: Offset(0.3, 0.3), end: Offset(1, 1)),
      ],
      onPlay: (controller) {
          controller.repeat(reverse: true);
      },
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(      
          shape: BoxShape.circle,
          color: Colors.transparent,
          border: Border.all(
            width: 1,
            color: Colors.transparent,
            
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.blue[100]!.withAlpha(150),
              blurRadius: 30,
              spreadRadius: 20
            )
          ]
        ),
      
      ),
    ),
    // Positioned.fill(
    //   child: BackdropFilter(
    //     filter: ImageFilter.blur(
    //       sigmaX: 10,
    //       sigmaY: 10
    //     ),
    //     child: SizedBox(
    //       height: ,
    //     ),
    //     )
    //     )
    ]
  );
}