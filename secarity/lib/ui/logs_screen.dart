import 'package:flutter/material.dart';
import 'package:secarity/ui/widget/chart_box.dart';
import 'package:secarity/ui/widget/log_box.dart';

class LogsScreen extends StatelessWidget {
  const LogsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: size.shortestSide * 0.05),
              const ChartBox(),
              SizedBox(height: size.shortestSide * 0.05),
              const LogBox()
            ],
          ),
        ),
      );
  }
}
