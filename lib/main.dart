import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:wallet_application/controller/add_page_provider.dart';
import 'package:wallet_application/controller/bottomProvider.dart';
import 'package:wallet_application/controller/db_functions.dart';
import 'package:wallet_application/controller/edit_provider.dart';
import 'package:wallet_application/widgets/bottomBar/bottom_bar.dart';
import 'model/dataModel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(DataModelAdapter().typeId)) {
    Hive.registerAdapter(DataModelAdapter());
    await Hive.openBox<DataModel>('data');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => BottomBarProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DBProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => EditProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AddProvider(),
        ),
      ],
      child: MaterialApp(
          title: 'Wallet',
          debugShowCheckedModeBanner: false,
          home: Bottombar()),
    );
  }
}
