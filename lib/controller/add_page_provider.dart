import 'package:flutter/material.dart';

class AddProvider extends ChangeNotifier{
    DateTime date = DateTime.now();

   String? selectedType;
  final List<String> category1 = [
    'Income',
    'Expense',
  ];

 final TextEditingController description = TextEditingController();

  TextEditingController statementController = TextEditingController();

  final TextEditingController amountC = TextEditingController();

    void setSelectedType(String value) {
    selectedType = value;
    notifyListeners();
  }
}
