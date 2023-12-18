// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../controller/dataBase/db.functions.dart';
import '../../utility/chartUtility.dart';

// ValueNotifier<List<DataModel>> overViewGraphNotifier =
// ValueNotifier(walletListnotifier.value);

class AllScreen extends StatefulWidget {
  const AllScreen({super.key});

  @override
  State<AllScreen> createState() => _AllScreenState();
}

class _AllScreenState extends State<AllScreen> {
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer(builder: (context, value, child) {
          Map incomeMap = {
            'name': "Income",
            "amount": IncomeAndExpence().income(),
          };
          Map expenseMap = {
            'name': 'Expense',
            'amount': IncomeAndExpence().expense(),
          };
          List<Map> totalMap = [incomeMap, expenseMap];
          return Provider.of<DBProvider>(context).    
              ? const SingleChildScrollView(
                  child: Column(
                    children: [
                      Text('No data Found'),
                    ],
                  ),
                )
              : SfCircularChart(
                  tooltipBehavior: _tooltipBehavior,
                  series: <CircularSeries>[
                    PieSeries<Map, String>(
                        dataSource: totalMap,
                        xValueMapper: (Map data, _) => data['name'],
                        yValueMapper: (Map data, _) => data['amount'],
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
      ),
    );
  }
}
