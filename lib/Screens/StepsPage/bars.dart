import 'package:fitness_app/providers/currentState.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BarChartSample3 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BarChartSample3State();
}

class BarChartSample3State extends State<BarChartSample3> {
  @override
  Widget build(BuildContext context) {
    CurrentState _instance = Provider.of<CurrentState>(context, listen: false);
    return AspectRatio(
      aspectRatio: 1.7,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        color: const Color(0xff2c4260),
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            maxY: 20000,
            barTouchData: BarTouchData(
              enabled: false,
              touchTooltipData: BarTouchTooltipData(
                tooltipBgColor: Colors.transparent,
                tooltipPadding: const EdgeInsets.all(0),
                tooltipMargin: 8,
                getTooltipItem: (
                  BarChartGroupData group,
                  int groupIndex,
                  BarChartRodData rod,
                  int rodIndex,
                ) {
                  return BarTooltipItem(
                    rod.y.round().toString(),
                    TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
            ),
            titlesData: FlTitlesData(
              show: true,
              bottomTitles: SideTitles(
                showTitles: true,
                getTextStyles: (value) => const TextStyle(
                    color: Color(0xff7589a2),
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
                margin: 20,
                getTitles: (double value) {
                  switch (value.toInt()) {
                    case 0:
                      return 'Mn';
                    case 1:
                      return 'Te';
                    case 2:
                      return 'Wd';
                    case 3:
                      return 'Tu';
                    case 4:
                      return 'Fr';
                    case 5:
                      return 'St';
                    case 6:
                      return 'Sn';
                    default:
                      return '';
                  }
                },
              ),
              leftTitles: SideTitles(showTitles: false),
            ),
            borderData: FlBorderData(
              show: false,
            ),
            barGroups: [
              ...List.generate(
                _instance.currentUser.steps.length,
                (index) => BarChartGroupData(
                  barsSpace: 100,
                  x: 0,
                  barRods: [
                    BarChartRodData(
                        y: (_instance.currentUser.steps[index].steps)
                            .toDouble(),
                        colors: [Colors.lightBlueAccent, Colors.greenAccent])
                  ],
                  showingTooltipIndicators: [0],

                ),
              ),
              BarChartGroupData(
                barsSpace: 100,
                x: 0,
                barRods: [
                  BarChartRodData(
                      y: 8,
                      colors: [Colors.lightBlueAccent, Colors.greenAccent])
                ],
                showingTooltipIndicators: [0],
              ),
              BarChartGroupData(
                x: 1,
                barRods: [
                  BarChartRodData(
                      y: 10,
                      colors: [Colors.lightBlueAccent, Colors.greenAccent])
                ],
                showingTooltipIndicators: [0],
              ),
              BarChartGroupData(
                x: 2,
                barRods: [
                  BarChartRodData(
                      y: 5000,
                      colors: [Colors.lightBlueAccent, Colors.greenAccent])
                ],
                showingTooltipIndicators: [0],
              ),
              BarChartGroupData(
                x: 3,
                barRods: [
                  BarChartRodData(
                      y: 15,
                      colors: [Colors.lightBlueAccent, Colors.greenAccent])
                ],
                showingTooltipIndicators: [0],
              ),
              BarChartGroupData(
                x: 4,
                barRods: [
                  BarChartRodData(
                      y: 13,
                      colors: [Colors.lightBlueAccent, Colors.greenAccent])
                ],
                showingTooltipIndicators: [0],
              ),
              BarChartGroupData(
                x: 5,
                barRods: [
                  BarChartRodData(
                      y: 11,
                      colors: [Colors.lightBlueAccent, Colors.greenAccent])
                ],
                showingTooltipIndicators: [0],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
