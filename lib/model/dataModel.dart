// ignore_for_file: file_names
import 'package:hive/hive.dart';
part 'dataModel.g.dart';

@HiveType(typeId: 1)
class DataModel {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String description;

  @HiveField(2)
  String amount;

  @HiveField(3)
  String through;

  @HiveField(4)
  DateTime datetime;

  DataModel({
    required this.description,
    required this.amount,
    required this.through,
    required this.datetime,
    this.id,
  });
}
