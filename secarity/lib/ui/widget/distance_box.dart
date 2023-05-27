import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:secarity/constants/app_colors.dart';
import 'package:secarity/constants/app_strings.dart';
import 'package:secarity/models/unique_params.dart';
import 'package:secarity/providers/shared_utility_provider.dart';
import 'package:secarity/service/socket_service.dart';
import 'package:secarity/utilities/helper.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class DistanceBox extends StatelessWidget {
  const DistanceBox({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer(builder: (context, ref, child) {
      final String email = ref.read(sharedUtilityProvider).getEmail() ?? '';
      final String token = ref.read(sharedUtilityProvider).getToken() ?? '';

      final distancerProvier = ref.watch(
          distanceSocketProvider(UniqueParams(name: email, token: token)));

      final distanceValue = distancerProvier.distance!.distanceValue;

      final isSafe = distanceValue == null
          ? true
          : distanceValue > 150
              ? true
              : false;

      double doubleDistance = distanceValue == null ? 0.0 : distanceValue + .0;

      return Container(
        height: size.shortestSide * 0.43,
        width: size.shortestSide * 0.43,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size.shortestSide * 0.03),
            color: isSafe ? AppColors.safeColor : changeColor(doubleDistance, 0.0, 150.0, AppColors.dangerColor, AppColors.safeColor)),
        child: Padding(
          padding: EdgeInsets.only(
              left: size.shortestSide * 0.03,
              right: size.shortestSide * 0.03,
              top: size.shortestSide * 0.03,
              bottom: 0.0),
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(AppString.distance,
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: Colors.white)),
                SizedBox(height: size.shortestSide * 0.04),
                Align(
                    alignment: Alignment.center,
                    child: AutoSizeText(isSafe ? AppString.safe : '$distanceValue cm',
                        style: Theme.of(context).textTheme.displayLarge)),
                SizedBox(height: size.shortestSide * 0.046),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SleekCircularSlider(
                    initialValue: isSafe ? 150 : doubleDistance,
                    innerWidget: (percentage) => const SizedBox.shrink(),
                    appearance: CircularSliderAppearance(
                        spinnerMode: false,
                        angleRange: 180.0,
                        startAngle: 180.0,
                        customWidths: CustomSliderWidths(
                            handlerSize: size.shortestSide * 0.03,
                            trackWidth: size.shortestSide * 0.025,
                            progressBarWidth: size.shortestSide * 0.025),
                        size: size.shortestSide * 0.3,
                        customColors: CustomSliderColors(
                            dotColor:
                                changeColor(doubleDistance, 0.0, 150.0, AppColors.dangerColor, AppColors.safeColor).withGreen(100),
                            dynamicGradient: false,
                            hideShadow: true,
                            trackColor: Colors.white,
                            progressBarColor: Colors.white)),
                    min: 0.0,
                    max: 150.0,
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
