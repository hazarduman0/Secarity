import 'package:auto_size_text/auto_size_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:secarity/constants/app_colors.dart';
import 'package:secarity/constants/app_strings.dart';
import 'package:secarity/models/thief_data.dart';
import 'package:secarity/models/unique_params.dart';
import 'package:secarity/providers/shared_utility_provider.dart';
import 'package:secarity/service/thief_alarm_service.dart';
import 'package:secarity/utilities/enums.dart';
import 'package:secarity/utilities/helper.dart';

class ChartBox extends StatelessWidget {
  const ChartBox({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.shortestSide * 0.5,
      width: size.shortestSide * 0.95,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size.shortestSide * 0.04),
          color: Colors.white),
      child: Padding(
        padding: EdgeInsets.only(
            left: size.shortestSide * 0.04, top: size.shortestSide * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeText(AppString.graphTH,
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
                        name: name, token: token, offset: 1, pageSize: 15)));
                return thiefAlarmRecords.when(
                    data: (data) => SizedBox(
                          height: size.shortestSide * 0.35,
                          width: size.shortestSide * 0.91,
                          child: LineChart(
                            LineChartData(
                              lineTouchData: LineTouchData(enabled: false),
                              gridData: FlGridData(
                                show: true,
                                drawHorizontalLine: true,
                                drawVerticalLine: true,
                                horizontalInterval: 20.0,
                                verticalInterval: 1.0,
                                getDrawingHorizontalLine: (value) =>
                                    _drawingLine(size),
                                getDrawingVerticalLine: (value) =>
                                    _drawingLine(size),
                              ),
                              titlesData: FlTitlesData(
                                show: true,
                                bottomTitles: _axisTitles,
                                rightTitles: _axisTitles,
                                topTitles: _axisTitles,
                                leftTitles: AxisTitles(
                                    drawBehindEverything: false,
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      getTitlesWidget: (value, meta) =>
                                          AutoSizeText(
                                              '${value.toInt().toString()}\t',
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall),
                                      reservedSize: size.shortestSide * 0.08,
                                      interval: 20,
                                    )),
                              ),
                              borderData: FlBorderData(
                                show: false,
                                border: const Border(
                                  left: BorderSide.none,
                                  bottom: BorderSide.none,
                                  right: BorderSide.none,
                                  top: BorderSide.none,
                                ),
                              ),
                              minX: 0,
                              maxX: 8,
                              maxY: 100,
                              minY: -20,
                              lineBarsData: [
                                _lineChartBarData(data, FlType.humidity, size,
                                    AppColors.appBlue),
                                _lineChartBarData(data, FlType.tempurate, size,
                                    AppColors.dangerColor),
                              ],
                            ),
                          ),
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
          ],
        ),
      ),
    );
  }

  FlLine _drawingLine(Size size) => FlLine(
        color: const Color.fromARGB(255, 198, 198, 198),
        strokeWidth: size.shortestSide * 0.003,
      );

  LineChartBarData _lineChartBarData(List<ThiefData>? thiefDataList,
          FlType flType, Size size, Color color) =>
      LineChartBarData(
        spots: getFlSpots(thiefDataList, flType),
        isCurved: true,
        color: color,
        barWidth: size.shortestSide * 0.007,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: true,
          getDotPainter: (p0, p1, p2, p3) => p0.x == 0 || p0.x == 8 ? FlDotCirclePainter(radius:0.0, strokeWidth: 0.0) : FlDotCirclePainter(
              color: color.withOpacity(0.9),
              radius: size.shortestSide * 0.008,
              strokeWidth: size.shortestSide * 0.002,
              strokeColor: color.withOpacity(0.2)),
        ),
        belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [color.withOpacity(0.3), color.withOpacity(0.0)])),
      );

  Widget errOrLoadingCard(Size size, Widget widget) => Expanded(
        child: Center(child: widget),
      );

  AxisTitles get _axisTitles =>
      AxisTitles(sideTitles: SideTitles(showTitles: false));
}
