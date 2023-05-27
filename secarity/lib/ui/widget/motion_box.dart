import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:secarity/constants/app_colors.dart';
import 'package:secarity/constants/app_strings.dart';
import 'package:secarity/models/unique_params.dart';
import 'package:secarity/providers/shared_utility_provider.dart';
import 'package:secarity/service/socket_service.dart';

class MotionBox extends StatelessWidget {
  const MotionBox({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer(builder: (context, ref, child) {
      final String email = ref.read(sharedUtilityProvider).getEmail() ?? '';
      final String token = ref.read(sharedUtilityProvider).getToken() ?? '';

      final motionProvider = ref
          .watch(motionSocketProvider(UniqueParams(name: email, token: token)));

      final isSafe = motionProvider.motion!.value == 0 ||
          motionProvider.motion!.value == null;

      log('motion: ${motionProvider.motion!.value}');

      return Container(
        height: size.shortestSide * 0.43,
        width: size.shortestSide * 0.43,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size.shortestSide * 0.03),
            color: isSafe ? AppColors.safeColor : AppColors.dangerColor),
        child: Stack(
          children: [
            Align(
                alignment: Alignment.bottomLeft,
                child: Image.asset('assets/img/running-man.png')),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: size.shortestSide * 0.03,
                  vertical: size.shortestSide * 0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(AppString.motion,
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(color: Colors.white)),
                  SizedBox(height: size.shortestSide * 0.06),
                  Align(
                    alignment: Alignment.center,
                    child: AutoSizeText(
                      isSafe ? AppString.notDetected : AppString.detected,
                      maxLines: isSafe ? 2 : 1,
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
