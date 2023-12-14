// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../model/dataModel.dart';
import '../pages/statistics.dart';

class IncomeChart extends StatefulWidget {
  const IncomeChart({super.key});

  @override
  State<IncomeChart> createState() => _IncomeScreenState();
}

class _IncomeScreenState extends State<IncomeChart> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: ValueListenableBuilder(
          valueListenable: overViewGraphNotifier,
          builder:
              (BuildContext context, List<DataModel> newList, Widget? child) {
            var allincome = newList
                .where((element) => element.through == 'Income')
                .toList();
            return overViewGraphNotifier.value.isEmpty
                ? const SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('No data Found'),
                      ],
                    ),
                  )
                : SfCircularChart(
                    palette: const [Colors.lightBlueAccent],
                    series: <CircularSeries>[
                      PieSeries<DataModel, String>(
                          dataSource: allincome,
                          xValueMapper: (DataModel incomeDate, _) =>
                              incomeDate.description,
                          yValueMapper: (DataModel incomeDate, _) =>
                              int.parse(incomeDate.amount),
                          dataLabelSettings: const DataLabelSettings(
                            isVisible: true,
                          ))
                    ],
                    legend: const Legend(
                        isVisible: true,
                        overflowMode: LegendItemOverflowMode.scroll,
                        alignment: ChartAlignment.center),
                  );
          }),
    ));
  }
}
