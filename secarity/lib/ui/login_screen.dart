import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:secarity/constants/app_colors.dart';
import 'package:secarity/constants/app_strings.dart';
import 'package:secarity/providers/route_controller_provider.dart';
import 'package:secarity/providers/shared_utility_provider.dart';
import 'package:secarity/ui/widget/input_widget.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    log(ref.read(sharedUtilityProvider).getToken().toString());
    log(ref.read(sharedUtilityProvider).getEmail().toString());
    log(ref.read(sharedUtilityProvider).getPassword().toString());
    ref.read(routeControllerProvider.notifier).autoLogin();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            CustomPaint(
              painter: CustomShapePaint(),
              child: Container(),
            ),
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              child: SizedBox(
                height: size.height,
                width: size.width,
                child: Column(
                  children: [
                    const Spacer(flex: 2),
                    SizedBox(
                      height: size.shortestSide * 1.15,
                      width: size.shortestSide * 0.9,
                      child: Card(
                        child: Column(
                          children: [
                            Container(
                              height: size.shortestSide * 0.18,
                              width: size.shortestSide,
                              decoration: BoxDecoration(
                                  color: AppColors.mainColor,
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(
                                          size.shortestSide * 0.03))),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.shortestSide * 0.1),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: AutoSizeText(AppString.appTitle,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge)),
                              ),
                            ),
                            Container(
                              height: size.shortestSide * 0.18,
                              width: size.shortestSide,
                              color: AppColors.appBlue,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.shortestSide * 0.1),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: AutoSizeText(AppString.welcomeBack,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium)),
                              ),
                            ),
                            InputArea(
                                text: AppString.username,
                                controller: _emailController,
                                isPassword: false),
                            InputArea(
                                text: AppString.password,
                                controller: _passwordController,
                                isPassword: true),
                            Expanded(
                                child: Consumer(
                              builder: (context, ref, child) => GestureDetector(
                                  onTap: () {
                                    ref
                                        .read(routeControllerProvider.notifier)
                                        .login(_emailController.text,
                                            _passwordController.text);
                                  },
                                  child: SizedBox(
                                      child: Center(
                                    child: AutoSizeText(AppString.login,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall),
                                  ))),
                            ))
                          ],
                        ),
                      ),
                    ),
                    const Spacer(flex: 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AutoSizeText(AppString.dontHaveAccount,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontSize: size.shortestSide * 0.04)),
                        TextButton(
                            onPressed: () {
                              ref
                                  .read(routeControllerProvider.notifier)
                                  .routeRegister();
                            },
                            child: AutoSizeText(AppString.create,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: AppColors.appBlue,
                                        fontSize: size.shortestSide * 0.04))),
                      ],
                    ),
                    const Spacer(flex: 2),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomShapePaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = AppColors.loginCustomShapeColor;
    paint.style = PaintingStyle.fill;

    var path = Path();
    path.moveTo(0, size.height * 0.4);
    path.lineTo(size.width, size.height * 0.6);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, size.height * 0.4);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}