// ignore_for_file: non_constant_identifier_names, file_names
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../model/dataModel.dart';

class StatementProvider extends ChangeNotifier{

double totals = 0;

final box = Hive.box<DataModel>('data');

double total() {
  var statement = box.values.toList();

  double totalAmount = 0;
  for (var i = 0; i < statement.length; i++) {
    if (statement[i].through == 'Income') {
      totalAmount += double.parse(statement[i].amount);
    } else {
      totalAmount -= double.parse(statement[i].amount);
    }
  }
  return totalAmount;
}

double Income() {
  var statement = box.values.toList();
  double incomeAmount = 0;
  for (var i = 0; i < statement.length; i++) {
    if (statement[i].through != 'Expense') {
      incomeAmount += double.parse(statement[i].amount);
    }
  }
  return incomeAmount;
}

double Expense() {
  var statement = box.values.toList();
  double expenseAmount = 0;
  for (var i = 0; i < statement.length; i++) {
    if (statement[i].through == 'Expense') {
      expenseAmount += double.parse(statement[i].amount);
    }
  }
  return expenseAmount;
}
}