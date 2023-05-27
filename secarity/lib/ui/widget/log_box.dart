import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:secarity/constants/app_colors.dart';
import 'package:secarity/constants/app_strings.dart';
import 'package:secarity/models/thief_data.dart';
import 'package:secarity/models/unique_params.dart';
import 'package:secarity/providers/shared_utility_provider.dart';
import 'package:secarity/service/thief_alarm_service.dart';
import 'package:secarity/utilities/helper.dart';

class LogBox extends StatelessWidget {
  const LogBox({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.shortestSide * 0.95,
      width: size.shortestSide * 0.95,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size.shortestSide * 0.04),
          color: Colors.white),
      child: Padding(
        padding: EdgeInsets.all(size.shortestSide * 0.04),
        child: ListView(
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          children: [
            AutoSizeText(AppString.alarmLogs,
                style: Theme.of(context).textTheme.labelMedium),
            SizedBox(height: size.shortestSide * 0.03),
            Consumer(
              builder: (context, ref, child) {
                final String name =
                    ref.read(sharedUtilityProvider).getEmail() ?? '';
                final String token =
                    ref.read(sharedUtilityProvider).getToken() ?? '';
                final thiefAlarmRecords = ref.watch(
                    getThiefPaginationRecordsProvider(UniqueParams(
                        name: name, token: token, offset: 1, pageSize: 1)));
        
                return thiefAlarmRecords.when(
                    data: (data) => Table(
                      border: TableBorder.symmetric(inside: BorderSide(color: Colors.white,width: size.shortestSide * 0.0023)),
                          columnWidths: const {
                            0: FractionColumnWidth(0.125),
                            1: FractionColumnWidth(0.125),
                            2: FractionColumnWidth(0.125),
                            3: FractionColumnWidth(0.25),
                            4: FractionColumnWidth(0.375),
                          },
                          children: [
                            _buildRow(context: context, size: size, icons: [
                              FontAwesomeIcons.triangleExclamation,
                              FontAwesomeIcons.temperatureHalf,
                              Icons.water_drop_rounded,
                              FontAwesomeIcons.personRunning,
                              FontAwesomeIcons.calendar,
                            ]),
                          ] + _tableRows(data!, size, context),
                        ),
                    error: (error, stackTrace) => errOrLoadingCard(
                        size,
                        AutoSizeText(
                          AppString.somethingWrong,
                          style: Theme.of(context).textTheme.bodyMedium,
                        )),
                    loading: () => errOrLoadingCard(
                        size,
                        CircularProgressIndicator(
                          color: AppColors.appBlue,
                        )));
              },
            ),
            SizedBox(height: size.shortestSide * 0.05)
          ],
        ),
      ),
    );
  }

  List<TableRow> _tableRows(List<ThiefData> datas, Size size, BuildContext context) => List.generate(datas.length, (index) => _buildRow(datas: rowStringList(datas[index]) ,size: size, context: context));

  TableRow _buildRow(
      {List<IconData>? icons,
      List<String>? datas,
      required Size size,
      required BuildContext context}) {
    if (datas == null) {
      return TableRow(
          decoration: const BoxDecoration(color: Color.fromARGB(195, 231, 227, 227)),
          children: icons!
              .map((icon) => Align(
                alignment: Alignment.center,
                    child: Padding(
                      padding:  EdgeInsets.symmetric(vertical: size.shortestSide * 0.01),
                      child: FaIcon(icon,
                          color: Colors.black54, size: size.shortestSide * 0.04),
                    ),
                  ))
              .toList());
    } else {
      return TableRow(
        decoration: const BoxDecoration(color: Color.fromARGB(195, 245, 242, 242)),
          children: datas
              .map((data) => Center(
                child: Padding(
                  padding:  EdgeInsets.symmetric(vertical: size.shortestSide * 0.015),
                  child: AutoSizeText(data,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall),
                ),
              ))
              .toList());
    }
  }

  Widget errOrLoadingCard(Size size, Widget widget) => Expanded(
        child: Center(child: widget),
      );
}
