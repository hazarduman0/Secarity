import 'package:flutter/material.dart';
import 'package:secarity/ui/widget/alarm_box.dart';
import 'package:secarity/ui/widget/distance_box.dart';
import 'package:secarity/ui/widget/heat_box.dart';
import 'package:secarity/ui/widget/humidity_box.dart';
import 'package:secarity/ui/widget/motion_box.dart';

class MonitorScreen extends StatelessWidget {
  const MonitorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: size.width,
      child: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const AlarmBox(),
              SizedBox(height: size.shortestSide * 0.07),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: size.shortestSide * 0.05),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [MotionBox(), DistanceBox()]),
              ),
              SizedBox(height: size.shortestSide * 0.05),
              //HeatHumidityPageView(),
              const HeatBox(),
              SizedBox(height: size.shortestSide * 0.05),
              const HumidityBox(),
              // Padding(
              //   padding:
              //       EdgeInsets.symmetric(horizontal: size.shortestSide * 0.05),
              //   child: ChartBox(),
              // ),
              SizedBox(height: size.shortestSide * 0.1),
            ],
          ),
        ),
      ),
    );
  }
}
