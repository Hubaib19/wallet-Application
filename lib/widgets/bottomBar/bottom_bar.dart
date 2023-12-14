// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:wallet_application/View/pages/addPage.dart';
import 'package:wallet_application/View/pages/historyPage.dart';
import 'package:wallet_application/View/pages/homePage.dart';
import 'package:wallet_application/View/pages/statistics.dart';
import 'package:wallet_application/View/settings/settings.dart';


class Bottombar extends StatefulWidget {
  const Bottombar({super.key});

  @override
  State<Bottombar> createState() => _bottom_barState();
}

class _bottom_barState extends State<Bottombar> {
  int index_button = 0;

  final List<Widget> _bottombar = [
    HomePage(),
    StatisticsScreen(),
    TransactionHistory(),
    Settings(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const AddData(),
          ));
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: const [Colors.lightBlueAccent, Colors.pinkAccent],
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Icon(Icons.add, color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: _bottombar[index_button],
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        child: Padding(
          padding: const EdgeInsets.only(top: 7.5, bottom: 7.5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    index_button = 0;
                  });
                },
                child: const Icon(Icons.home_rounded),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    index_button = 1;
                  });
                },
                child: const Icon(Icons.bar_chart_rounded),
              ),
              const SizedBox(
                width: 20,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    index_button = 2;
                  });
                },
                child: const Icon(Icons.history_rounded),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    index_button = 3;
                  });
                },
                child: const Icon(Icons.settings_rounded),
              )
            ],
          ),
        ),
      ),
    );
  }
}
