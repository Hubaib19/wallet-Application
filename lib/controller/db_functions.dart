import 'package:flutter/material.dart';
import 'package:wallet_application/model/dataModel.dart';
import 'package:wallet_application/services/db_services.dart';

class DBProvider extends ChangeNotifier {
  String search = "";
  List<DataModel> searchedList = [];
  DateTime date = DateTime.now();

  String? selectedType;
  final List<String> category1 = [
    'Income',
    'Expense',
  ];

  final TextEditingController description = TextEditingController();

  TextEditingController statementController = TextEditingController();

  final TextEditingController amountC = TextEditingController();
  List<DataModel> transactionList = [];
  List<DataModel> graphList = [];

  ValueNotifier showCategory = ValueNotifier('All');

  final TransactionService _transactionService = TransactionService();

  Future<void> getAllData() async {
    transactionList = await _transactionService.getAllData();
    notifyListeners();
  }

  Future<void> addData(DataModel obj) async {
    await _transactionService.addData(obj);
    await getAllData();
  }

  Future<void> deleteData(DataModel data) async {
    await _transactionService.deleteData(data.id.toString());
    await getAllData();
  }

  Future<void> editData(DataModel value) async {
    await _transactionService.editData(value);
    notifyListeners();
    await getAllData();
  }

  Future<void> resetData(int id) async {
    await _transactionService.resetData(id);
    await getAllData();
    notifyListeners();
  }

  void setSelectedType(String value) {
    selectedType = value;
    notifyListeners();
  }
  
    void setSearch(String query) {
    if (query.isEmpty) {
      searchedList = transactionList;
    } else {
      searchedList = transactionList
          .where((statementModel) =>
              statementModel.description.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    transactionList = searchedList;
    notifyListeners();
  }
}
