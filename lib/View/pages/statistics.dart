import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet_application/controller/db_functions.dart';
import '../statistics/allCharts.dart';
import '../statistics/expenceChart.dart';
import '../statistics/incomeChart.dart';


class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  String dateFilterTitle = 'All';

  @override
  void initState() {
    super.initState();
    Provider.of<DBProvider>(context, listen: false).graphList =
        Provider.of<DBProvider>(context, listen: false).transactionList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Statistics',
          style: TextStyle(
              fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                const Text(
                  'Data',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                PopupMenuButton<int>(
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      70,
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        dateFilterTitle,
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                      const Icon(
                        Icons.arrow_drop_down_sharp,
                        size: 20,
                      )
                    ],
                  ),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 1,
                      child: const Text(
                        "All",
                      ),
                      onTap: () {
                        Provider.of<DBProvider>(context, listen: false)
                                .graphList =
                            Provider.of<DBProvider>(context, listen: false)
                                .transactionList;
                        setState(() {
                          dateFilterTitle = 'All';
                        });
                      },
                    ),
                    PopupMenuItem(
                      value: 2,
                      child: const Text(
                        "Today",
                      ),
                      onTap: () {
                        Provider.of<DBProvider>(context, listen: false)
                            .graphList = Provider.of<DBProvider>(context,
                                listen: false)
                            .transactionList
                            .where((element) =>
                                element.datetime.day == DateTime.now().day &&
                                element.datetime.month ==
                                    DateTime.now().month &&
                                element.datetime.year == DateTime.now().year)
                            .toList();
                        Provider.of<DBProvider>(context, listen: false);
                        dateFilterTitle = "Today";
                      },
                    ),
                    PopupMenuItem(
                      value: 3,
                      child: const Text(
                        "Week",
                      ),
                      onTap: () {
                        Provider.of<DBProvider>(context, listen: false)
                            .graphList = Provider.of<DBProvider>(context,
                                listen: false)
                            .transactionList
                            .where((element) =>
                                element.datetime.weekday ==
                                    DateTime.now().weekday &&
                                element.datetime.month ==
                                    DateTime.now().month &&
                                element.datetime.year == DateTime.now().year)
                            .toList();
                        Provider.of<DBProvider>(context, listen: false);
                        dateFilterTitle = "Week";
                      },
                    ),
                    PopupMenuItem(
                      value: 4,
                      child: const Text(
                        "Month",
                      ),
                      onTap: () {
                        Provider.of<DBProvider>(context, listen: false)
                            .graphList = Provider.of<DBProvider>(context,
                                listen: false)
                            .transactionList
                            .where((element) =>
                                element.datetime.month ==
                                    DateTime.now().month &&
                                element.datetime.year == DateTime.now().year)
                            .toList();
                        Provider.of<DBProvider>(context, listen: false);
                        dateFilterTitle = "Month";
                      },
                    ),
                    PopupMenuItem(
                      value: 5,
                      child: const Text(
                        "Year",
                      ),
                      onTap: () {
                        Provider.of<DBProvider>(context, listen: false)
                            .graphList = Provider.of<DBProvider>(context,
                                listen: false)
                            .transactionList
                            .where((element) =>
                                element.datetime.year == DateTime.now().year &&
                                element.datetime.year == DateTime.now().year)
                            .toList();
                        Provider.of<DBProvider>(context, listen: false);
                        dateFilterTitle = "Year";
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: DefaultTabController(
              length: 3,
              initialIndex: 0,
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    child: ButtonsTabBar(
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.lightBlueAccent,
                                  Colors.pinkAccent
                                ]),
                            borderRadius: BorderRadius.circular(15)),
                        tabs: const [
                          Tab(
                            text: 'All',
                          ),
                          Tab(
                            text: 'Expence',
                          ),
                          Tab(
                            text: 'Income',
                          ),
                        ]),
                  ),
                  const Expanded(
                    child: TabBarView(
                      children: [
                        AllScreen(),
                        ExpenceChart(),
                        IncomeChart(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
