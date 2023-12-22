import 'package:hive/hive.dart';
import 'package:wallet_application/model/dataModel.dart';

class TransactionService {

  Future<List<DataModel>> getAllData() async {
    final walletDB = await Hive.openBox<DataModel>('data');
    return walletDB.values.toList();
  }

  Future<void> addData(DataModel obj) async {
    final walletDB = await Hive.openBox<DataModel>('data');
    await walletDB.put(obj.id, obj);
  }

  Future<void> deleteData(String id) async {
    final walletDB = await Hive.openBox<DataModel>('data');
    walletDB.delete(id);
  }

  Future<void> editData(DataModel value) async {
      final walletDB = await Hive.openBox<DataModel>('data');
      walletDB.put(value.id, value);
  }
  
   Future<void> resetData(int id) async {
    final walletDB = await Hive.openBox<DataModel>('data');
    walletDB.clear();
  }
}