import 'package:flutter/material.dart';

class EditProvider extends ChangeNotifier{
    DateTime date = DateTime.now();
   String? statement;
  // DateTime? selectedEditDateTime;

  TextEditingController editDescription = TextEditingController();
  TextEditingController editAmountC = TextEditingController();
  TextEditingController editDate = TextEditingController();

  List<String> editCategory = [
    'Income',
    'Expense',
  ];

      void setSelectedType(String value) {
    statement = value;
    notifyListeners();
  }


 void setDate(DateTime newDate) {
    date = newDate;
    notifyListeners();
  }

}