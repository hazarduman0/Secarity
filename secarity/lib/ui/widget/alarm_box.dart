import 'package:auto_size_text/auto_size_text.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:secarity/constants/app_colors.dart';
import 'package:secarity/constants/app_strings.dart';
import 'package:secarity/models/unique_params.dart';
import 'package:secarity/providers/shared_utility_provider.dart';
import 'package:secarity/service/socket_service.dart';

class AlarmBox extends StatefulWidget {
  const AlarmBox({super.key});

  @override
  State<AlarmBox> createState() => _AlarmBoxState();
}

class _AlarmBoxState extends State<AlarmBox> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer(builder: (context, ref, child) {
      final String email = ref.read(sharedUtilityProvider).getEmail() ?? '';
      final String token = ref.read(sharedUtilityProvider).getToken() ?? '';

      final thiefAlarm = ref.watch(
          thieftAlarmSocketProvider(UniqueParams(name: email, token: token)));

      final fireAlarm = ref.watch(
          fireAlarmSocketProvider(UniqueParams(name: email, token: token)));

      final bothTriggered =
          thiefAlarm.alarm!.value == 1 && fireAlarm.alarm!.value == 1;

      final isTriggered =
          thiefAlarm.alarm!.value == 1 || fireAlarm.alarm!.value == 1;

      return AnimatedContainer(
        height: bothTriggered
            ? size.shortestSide * 0.75
            : isTriggered
                ? size.shortestSide * 0.65
                : size.shortestSide * 0.15,
        color: Colors.white,
        duration: const Duration(milliseconds: 200),
        curve: Curves.linear,
        child: isTriggered
            ? alarmTriggered(size, context, () {
                thiefAlarm.killAlarm();
                fireAlarm.killAlarm();
                Fluttertoast.showToast(
                    msg: AppString.alarmSilenced,
                    fontSize: size.shortestSide * 0.04,
                    backgroundColor: Colors.green);
              }, thiefAlarm.alarm!.value == 1, fireAlarm.alarm!.value == 1)
            : whileSecure(context, size),
      );
    });
  }
}

Widget whileSecure(BuildContext context, Size size) => Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.shortestSide * 0.05),
        child: Row(
          children: [
            AvatarGlow(
                endRadius: size.shortestSide * 0.05,
                glowColor: Colors.green,
                curve: Curves.easeInOutBack,
                child: const FaIcon(FontAwesomeIcons.circleCheck,
                    color: Colors.green)),
            SizedBox(width: size.shortestSide * 0.02),
            AutoSizeText(AppString.safeWithSecarity,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(color: Colors.green))
          ],
        ),
      ),
    );

Widget alarmTriggered(Size size, BuildContext context,
        void Function()? onPressed, bool thiefAlarm, bool fireAlarm) =>
    SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: size.shortestSide * 0.03,
            horizontal: size.shortestSide * 0.06),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Spacer(flex: 3),
                Align(
                  alignment: Alignment.center,
                  child: AutoSizeText(AppString.alarmTriggered,
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(fontSize: size.shortestSide * 0.05)),
                ),
                const Spacer(flex: 1),
                AvatarGlow(
                    endRadius: size.shortestSide * 0.08,
                    duration: const Duration(milliseconds: 700),
                    glowColor: Colors.red,
                    curve: Curves.easeInOutBack,
                    child: const FaIcon(FontAwesomeIcons.triangleExclamation,
                        color: Colors.red)),
                const Spacer(flex: 1),
              ],
            ),
            SizedBox(height: size.shortestSide * 0.03),
            thiefAlarm
                ? Column(
                    children: [
                      alarmDetail(
                          size, context, FontAwesomeIcons.carOn, AppString.thiefAlert),
                      AutoSizeText(AppString.detectedVP,
                          style: Theme.of(context).textTheme.bodyMedium)
                    ],
                  )
                : const SizedBox.shrink(),
            SizedBox(height: size.shortestSide * 0.02),
            fireAlarm
                ? alarmDetail(
                    size, context, FontAwesomeIcons.fire, AppString.fireAlert)
                : const SizedBox.shrink(),
            SizedBox(height: size.shortestSide * 0.03),
            const Divider(),
            SizedBox(height: size.shortestSide * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                snapshotButton(size, context),
                killAlarmButton(size, context, onPressed),
              ],
            )
          ],
        ),
      ),
    );

Widget alarmDetail(
        Size size, BuildContext context, IconData icon, String text) =>
    Row(
      children: [
        AvatarGlow(
          endRadius: size.shortestSide * 0.05,
          duration: const Duration(milliseconds: 1200),
          glowColor: Colors.red,
          curve: Curves.easeInOutBack,
          child:
              FaIcon(icon, color: Colors.red, size: size.shortestSide * 0.05),
        ),
        const Spacer(flex: 1),
        AutoSizeText(text,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontSize: size.shortestSide * 0.043)),
        const Spacer(flex: 9),
      ],
    );

Widget snapshotButton(Size size, BuildContext context) => ElevatedButton(
    style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.appBlue, elevation: 1.0),
    onPressed: () {},
    child: Row(
      children: [
        FaIcon(FontAwesomeIcons.eye, size: size.shortestSide * 0.03),
        SizedBox(width: size.shortestSide * 0.01),
        AutoSizeText(
          AppString.capturedView,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Colors.white,
              fontSize: size.shortestSide * 0.04,
              fontWeight: FontWeight.bold),
        ),
      ],
    ));

Widget killAlarmButton(
        Size size, BuildContext context, void Function()? onPressed) =>
    ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red, elevation: 1.0),
        onPressed: onPressed,
        child: AutoSizeText(
          AppString.killAlarm,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Colors.white,
              fontSize: size.shortestSide * 0.04,
              fontWeight: FontWeight.bold),
        ));
