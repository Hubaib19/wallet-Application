// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../model/dataModel.dart';

// ValueNotifier<List<DataModel>> walletListnotifier =
//     ValueNotifier<List<DataModel>>([]);

class DBProvider extends ChangeNotifier {
List <DataModel> transactionList = [];


  Future<void> addData(DataModel value) async {
    final walletDB = await Hive.openBox<DataModel>('data');
    walletDB.add(value);
    notifyListeners();
    getAlldata();
  }

  Future<void> getAlldata() async {
    final walletDB = await Hive.openBox<DataModel>('data');
    walletDB.clear();
    walletDB.addAll(walletDB.values);
    notifyListeners();
  }

  Future<void> deleteData(int id) async {
    final walletDB = await Hive.openBox<DataModel>('data');
    await walletDB.deleteAt(id);
    await getAlldata();
  }

  Future<void> editdata(id, DataModel value) async {
    final walletDB = await Hive.openBox<DataModel>('data');
    walletDB.clear();
    walletDB.addAll(walletDB.values);
    walletDB.putAt(id, value);
    getAlldata();
    notifyListeners();
  }

  Future<void> resetData(int id) async {
    final walletDB = await Hive.openBox<DataModel>('data');
    walletDB.clear();
    getAlldata();
    notifyListeners();
  }
}
