import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:secarity/constants/app_colors.dart';
import 'package:secarity/constants/app_strings.dart';
import 'package:secarity/models/unique_params.dart';
import 'package:secarity/providers/shared_utility_provider.dart';
import 'package:secarity/service/socket_service.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class HumidityBox extends StatelessWidget {
  const HumidityBox({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: size.shortestSide * 0.05),
        child: Container(
          height: size.shortestSide * 0.4,
          width: size.shortestSide * 0.9,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(size.shortestSide * 0.03)),
          child: Consumer(
            builder: (context, ref, child) {
              final String email =
                  ref.read(sharedUtilityProvider).getEmail() ?? '';
              final String token =
                  ref.read(sharedUtilityProvider).getToken() ?? '';

              final tempurateHumiditySocket = ref.watch(
                  tempurateHumiditySocketProvider(
                      UniqueParams(name: email, token: token)));

              var humidity;

              if (tempurateHumiditySocket.tempurateHumidity != null) {
                humidity =
                    tempurateHumiditySocket.tempurateHumidity!.humidityValue ??
                        0;
              } else {
                humidity = 0;
              }

              double doubleHum = humidity + .0;

              return Stack(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Transform.rotate(
                      angle: 0.5,
                      child: Icon(Icons.water_drop_rounded,
                          size: size.shortestSide * 0.23,
                          color: const Color.fromARGB(13, 0, 0, 0)),
                    ),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(size.shortestSide * 0.03)),
                    curve: Curves.linear,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(size.shortestSide * 0.03),
                      child: WaveWidget(
                          waveFrequency: 0.5,
                          waveAmplitude: 10.0,
                          wavePhase: 5.0,
                          config: CustomConfig(
                              colors: [AppColors.appBlue.withOpacity(0.5)],
                              durations: [15000],
                              heightPercentages: [getWaweHeight(doubleHum)]),
                          size: size),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.shortestSide * 0.1,
                        vertical: size.shortestSide * 0.05),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(AppString.humidity,
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(color: AppColors.dimBlack)),
                        SizedBox(height: size.shortestSide * 0.02),
                        AutoSizeText(
                          '% $humidity',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: AppColors.appBlue),
                        ),
                      ],
                    ),
                  )
                ],
              );
            },
          ),
        ));
  }
}

double getWaweHeight(double humidity) {
  log('${humidity / 100}');
  return 1 - (humidity / 100);
}
