// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../model/dataModel.dart';

class UtilityProvider extends ChangeNotifier {
  int totals = 0;
  final walletDB = Hive.box<DataModel>('data');
  ValueNotifier expenseTotal = ValueNotifier(0.0);
  ValueNotifier incomeTotal = ValueNotifier(0.0);

  int total() {
    var chart = walletDB.values.toList();
    List a = [0, 0];
    for (var i = 0; i < chart.length; i++) {
      a.add(chart[i].through == 'Income'
          ? int.parse(chart[i].amount)
          : int.parse(chart[i].amount) * -1);
    }
    totals = a.reduce((value, element) => value + element);
    return totals;
  }

  int income() {
    var chart = walletDB.values.toList();
    List a = [0, 0];
    for (var i = 0; i < chart.length; i++) {
      a.add(chart[i].through == 'Income' ? int.parse(chart[i].amount) : 0);
    }
    totals = a.reduce((value, element) => value + element);
    return totals;
  }

  int expense() {
    var chart = walletDB.values.toList();
    List a = [0, 0];
    for (var i = 0; i < chart.length; i++) {
      a.add(chart[i].through == 'Income' ? 0 : int.parse(chart[i].amount));
    }
    totals = a.reduce((value, element) => value + element);
    return totals;
  }
}
