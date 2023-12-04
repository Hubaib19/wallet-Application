// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../model/dataModel.dart';

ValueNotifier<List<DataModel>> walletListnotifier =
    ValueNotifier<List<DataModel>>([]);

Future<void> addData(DataModel value) async {
  final walletDB = await Hive.openBox<DataModel>('data');
  walletDB.add(value);
  walletListnotifier.value.add(value);
  walletListnotifier.notifyListeners();
  getAlldata();
}

Future<void> getAlldata() async {
  final walletDB = await Hive.openBox<DataModel>('data');
  walletListnotifier.value.clear();
  walletListnotifier.value.addAll(walletDB.values);
  walletListnotifier.notifyListeners();
}

Future<void> deleteData(int id) async {
  final walletDB = await Hive.openBox<DataModel>('data');
  await walletDB.deleteAt(id);
  await getAlldata();
}

Future<void> editdata(id, DataModel value) async {
  final walletDB = await Hive.openBox<DataModel>('data');
  walletListnotifier.value.clear();
  walletListnotifier.value.addAll(walletDB.values);
  walletDB.putAt(id, value);
  getAlldata();
  walletListnotifier.notifyListeners();
}

Future<void> resetData(int id) async {
  final walletDB = await Hive.openBox<DataModel>('data');
  walletDB.clear();
  getAlldata();
  walletListnotifier.notifyListeners();
}
