import 'package:flutter/material.dart';
import 'package:secarity/constants/app_colors.dart';

class HeatBar extends StatefulWidget {
  HeatBar({super.key, required this.color, required this.leftMargin});

  Color color;
  double leftMargin;

  @override
  State<HeatBar> createState() => _HeatBarState();
}

class _HeatBarState extends State<HeatBar> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      children: [
        SizedBox(
          height: size.shortestSide * 0.08,
          width: size.shortestSide * 0.7,
          child: Align(
            alignment: Alignment.center,
            child: Container(
              height: size.shortestSide * 0.02,
              width: size.shortestSide * 0.7,
              decoration: BoxDecoration(
                  gradient: AppColors.blueRedGradient,
                  borderRadius: BorderRadius.circular(size.shortestSide * 0.2)),
            ),
          ),
        ),
        AnimatedContainer(
            height: size.shortestSide * 0.08,
            width: size.shortestSide * 0.08,
            margin: EdgeInsets.only(left: widget.leftMargin),
            decoration: BoxDecoration(
                color: widget.color,
                borderRadius:
                    BorderRadiusDirectional.circular(size.shortestSide),
                border: Border.all(
                    width: size.shortestSide * 0.01, color: Colors.white)),
            curve: Curves.linear,
            duration: const Duration(milliseconds: 300))
      ],
    );
  }
}
