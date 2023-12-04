// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../model/dataModel.dart';
import '../pages/statistics.dart';

class ExpenceChart extends StatefulWidget {
  const ExpenceChart({super.key});

  @override
  State<ExpenceChart> createState() => _ExpenceChartState();
}

class _ExpenceChartState extends State<ExpenceChart> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: ValueListenableBuilder(
        valueListenable: overViewGraphNotifier,
        builder:
            (BuildContext context, List<DataModel> newList, Widget? child) {
          var allincome =
              newList.where((element) => element.through == 'Expense').toList();
          return overViewGraphNotifier.value.isEmpty
              ? const SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('No data found'),
                    ],
                  ),
                )
              : SfCircularChart(
                  palette: const [Colors.pinkAccent],
                  series: <CircularSeries>[
                    PieSeries<DataModel, String>(
                        dataSource: allincome,
                        xValueMapper: (DataModel expenseDate, _) =>
                            expenseDate.description,
                        yValueMapper: (DataModel expenseDate, _) =>
                            num.parse(expenseDate.amount),
                        dataLabelSettings: const DataLabelSettings(
                          isVisible: true,
                        ))
                  ],
                  legend: const Legend(
                      isVisible: true,
                      overflowMode: LegendItemOverflowMode.scroll,
                      alignment: ChartAlignment.center),
                );
        },
      ),
    ));
  }
}
