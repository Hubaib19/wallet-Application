// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import '../../dataBase/db.functions.dart';
import '../../model/dataModel.dart';
import '../../utility/statementChart.dart';
import 'historyPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final box = Hive.box<DataModel>('data');
  @override
  Widget build(BuildContext context) {
    getAlldata();
    return Scaffold(
      body: Builder(builder: (context) {
        final mediaQuery = MediaQuery.of(context);
        return Stack(
          children: [
            const Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 50, left: 10),
                  child: Row(
                    children: [
                      Text(
                        'Hi there ,',
                        style: TextStyle(
                            fontSize: 25,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 35, top: 100),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 200,
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.lightBlueAccent, Colors.pinkAccent]),
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, top: 10),
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Balance',
                            style: TextStyle(fontSize: 17, color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '₹ ${total()}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 15, top: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.arrow_circle_down_rounded,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                    Text(
                                      'Income',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.arrow_circle_down_rounded,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                    Text(
                                      'Expense',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 30),
                                child: Text(
                                  '₹ ${Income()}',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: Text(
                                  '₹ ${Expense()}',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: mediaQuery.padding.top + 350),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text(
                      'Last Transaction', 
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const TransactionHistory(),
                        ));
                      },
                      child: const Text(
                        'See all',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  )
                ],
              ),
            ),
            ValueListenableBuilder(
                valueListenable: walletListnotifier,
                builder: (BuildContext ctx, List<DataModel> transactionList,
                    Widget? child) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 390),
                    child: ListView.separated(
                        itemBuilder: (ctx, index) {
                          final data = transactionList[index];
                          return Card(
                            elevation: 4,
                            margin: const EdgeInsets.all(8),
                            color: Colors.white,
                            child: ListTile(
                              title: Text(
                                data.description,
                                style: const TextStyle(
                                    fontSize: 19, fontWeight: FontWeight.w700),
                              ),
                              subtitle: Text(
                                '${data.datetime.year}-${data.datetime.day}-${data.datetime.month}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700),
                              ),
                              trailing: Text(
                                data.amount,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: data.through == 'Income'
                                      ? Colors.green[500]
                                      : Colors.red,
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (ctx, index) {
                          return const Divider();
                        },
                        itemCount: transactionList.length > 4
                            ? 4
                            : transactionList.length),
                  );
                }),
          ],
        );
      }),
    );
  }
}
