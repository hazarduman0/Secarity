import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:secarity/constants/app_colors.dart';
import 'package:secarity/constants/app_strings.dart';
import 'package:secarity/models/unique_params.dart';
import 'package:secarity/providers/shared_utility_provider.dart';
import 'package:secarity/service/socket_service.dart';
import 'package:secarity/ui/widget/heat_bar.dart';
import 'package:secarity/utilities/helper.dart';

class HeatBox extends StatelessWidget {
  const HeatBox({super.key});

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
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: size.shortestSide * 0.1,
              vertical: size.shortestSide * 0.05),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Transform.rotate(
                  angle: 0.5,
                  child: FaIcon(FontAwesomeIcons.temperatureThreeQuarters,
                      size: size.shortestSide * 0.23,
                      color: const Color.fromARGB(13, 0, 0, 0)),
                ),
              ),
              Consumer(
                builder: (context, ref, child) {
                  final String email =
                      ref.read(sharedUtilityProvider).getEmail() ?? '';
                  final String token =
                      ref.read(sharedUtilityProvider).getToken() ?? '';

                  final tempurateHumiditySocket = ref.watch(
                      tempurateHumiditySocketProvider(
                          UniqueParams(name: email, token: token)));

                  var tempurate;

                  if (tempurateHumiditySocket.tempurateHumidity != null) {
                    tempurate = tempurateHumiditySocket
                            .tempurateHumidity!.temperatureValue ??
                        0;
                  } else {
                    tempurate = 0;
                  }

                  double doubleTemp = tempurate + .0;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(AppString.tempurate,
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(color: AppColors.dimBlack)),
                      SizedBox(height: size.shortestSide * 0.02),
                      AutoSizeText(
                        '$tempurate °C',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: changeColor(doubleTemp, -20.0, 70.0, Colors.blue, Colors.red)),
                      ),
                      SizedBox(height: size.shortestSide * 0.03),
                      HeatBar(
                        color: changeColor(doubleTemp, -20.0, 70.0, Colors.blue, Colors.red),
                        leftMargin: changeMargin(doubleTemp, size),
                      )
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}