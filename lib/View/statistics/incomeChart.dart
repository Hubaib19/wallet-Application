// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wallet_application/controller/db_functions.dart';
import 'package:wallet_application/model/dataModel.dart';

class IncomeChart extends StatelessWidget {
  const IncomeChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Consumer<DBProvider>(
            builder: (context, transactionProvider, child) {
            var allIncome = transactionProvider.graphList
                .where((element) => element.through == 'Income')
                .toList();
            return transactionProvider.graphList.isEmpty
                ? const SingleChildScrollView(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Center(child: Text('No data Found')),
                        ],
                      ),
                    ),
                  )
                :SfCircularChart(
                    palette: const [Colors.lightBlueAccent],
                    series: <CircularSeries>[
                      PieSeries<DataModel, String>(
                          dataSource: allIncome,
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
                      alignment: ChartAlignment.center,
                    ),
                  );
          },
        ),
      ),
    );
  }
}
