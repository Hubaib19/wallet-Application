import 'package:flutter/material.dart';
import 'package:wallet_application/model/dataModel.dart';
import 'package:wallet_application/services/db_services.dart';

class DBProvider extends ChangeNotifier {
  String search = "";
  List<DataModel> searchedList = [];
  List<DataModel> transactionList = [];
  List<DataModel> graphList = [];
  String dateFilterTitle = 'All';

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

  gettrasaction() {
    searchedList = transactionList;
  }

  void setSearch(String query) {
    if (query.isEmpty) {
      searchedList = transactionList;
      notifyListeners();
    } else {
      searchedList = transactionList
          .where((statementModel) => statementModel.description
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
      notifyListeners();
    }
  }

  void setdatefilter(String value) {
    dateFilterTitle = value;
    notifyListeners();
  }
}
