import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:secarity/constants/app_colors.dart';
import 'package:secarity/constants/app_strings.dart';
import 'package:secarity/models/unique_params.dart';
import 'package:secarity/providers/route_controller_provider.dart';
import 'package:secarity/providers/shared_utility_provider.dart';
import 'package:secarity/service/socket_service.dart';
import 'package:secarity/ui/logs_screen.dart';
import 'package:secarity/ui/map_screen.dart';
import 'package:secarity/ui/monitor_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.appBackgroundColor,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(size.shortestSide * 0.4),
            child: Consumer(
              builder: (context, ref, child) {
                final String email =
                    ref.read(sharedUtilityProvider).getEmail() ?? '';
                final String token =
                    ref.read(sharedUtilityProvider).getToken() ?? '';

                final thiefAlarm = ref.watch(thieftAlarmSocketProvider(
                    UniqueParams(name: email, token: token)));

                final fireAlarm = ref.watch(fireAlarmSocketProvider(
                    UniqueParams(name: email, token: token)));

                final isTriggered =
                    thiefAlarm.alarm!.value == 1 || fireAlarm.alarm!.value == 1;

                return Container(
                  decoration: BoxDecoration(
                      gradient: isTriggered
                          ? AppColors.alarmedAppBarColor
                          : AppColors.appBarColor),
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: size.shortestSide * 0.1,
                        left: size.shortestSide * 0.08,
                        right: size.shortestSide * 0.08),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AutoSizeText(AppString.appTitle,
                                style: Theme.of(context).textTheme.titleLarge),
                            Consumer(
                              builder: (context, ref, child) {
                                return SizedBox(
                                  height: size.shortestSide * 0.08,
                                  width: size.shortestSide * 0.17,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        ref
                                            .read(routeControllerProvider
                                                .notifier)
                                            .logOut();
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      size.shortestSide *
                                                          0.3))),
                                      child: FaIcon(
                                          FontAwesomeIcons.rightFromBracket,
                                          color: AppColors.mainColor,
                                          size: size.shortestSide * 0.035)),
                                );
                              },
                            )
                          ],
                        ),
                        TabBar(
                            indicatorColor: Colors.transparent,
                            labelStyle: Theme.of(context).textTheme.bodyMedium,
                            unselectedLabelStyle:
                                Theme.of(context).textTheme.bodyMedium,
                            labelColor: Colors.white,
                            unselectedLabelColor: Colors.white30,
                            tabs:  [
                              Tab(text: AppString.home),
                              Tab(text: AppString.logs),
                              Tab(text: AppString.map)
                            ])
                      ],
                    ),
                  ),
                );
              },
            )),
        body: const TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [MonitorScreen(), LogsScreen(), MapScreen()]),
      ),
    ));
  }
}