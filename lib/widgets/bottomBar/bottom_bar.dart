// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet_application/View/pages/addPage.dart';
import 'package:wallet_application/View/pages/historyPage.dart';
import 'package:wallet_application/View/pages/homePage.dart';
import 'package:wallet_application/View/pages/statistics.dart';
import 'package:wallet_application/View/settings/settings.dart';
import 'package:wallet_application/controller/bottomProvider.dart';

class Bottombar extends StatelessWidget {
  Bottombar({super.key});

  final List<Widget> bottombar = [
    HomePage(),
    StatisticsScreen(),
    TransactionHistory(),
    Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    final bottomProvider = Provider.of<BottomBarProvider>(context);
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
      body: bottombar[bottomProvider.indexButton],
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
                  Provider.of<BottomBarProvider>(context, listen: false)
                      .setIndex(0);
                },
                child: const Icon(Icons.home_rounded),
              ),
              GestureDetector(
                onTap: () {
                  Provider.of<BottomBarProvider>(context, listen: false)
                      .setIndex(1);
                },
                child: const Icon(Icons.bar_chart_rounded),
              ),
              const SizedBox(
                width: 20,
              ),
              GestureDetector(
                onTap: () {
                  Provider.of<BottomBarProvider>(context, listen: false)
                      .setIndex(2);
                },
                child: const Icon(Icons.history_rounded),
              ),
              GestureDetector(
                onTap: () {
                  Provider.of<BottomBarProvider>(context, listen: false)
                      .setIndex(3);
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
