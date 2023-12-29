// ignore_for_file: file_names, must_be_immutable
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet_application/widgets/bottomBar/bottom_bar.dart';
import '../../controller/db_functions.dart';
import 'privacy.dart';
import 'terms.dart';

class Settings extends StatelessWidget {
   Settings({super.key});

  int index = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Settings',
          style: TextStyle(
              fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (ctx) => const Privacy()));
              },
              child: const ListTile(
                title: Text('Privacy & policy'),
                trailing: Icon(Icons.chevron_right),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (ctx) => const Terms()));
              },
              child: const ListTile(
                title: Text('Terms & Conditions'),
                trailing: Icon(Icons.chevron_right),
              ),
            ),
            GestureDetector(
              child: ListTile(
                leading: const Icon(Icons.restore),
                title: const Text('Reset'),
                onTap: () {
                 Provider.of<DBProvider>(context,listen: false).resetData(index);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      margin: EdgeInsets.all(10),
                      backgroundColor: Colors.grey,
                      behavior: SnackBarBehavior.floating,
                      content: Text("Reset completed...",style: TextStyle(color: Colors.black),),
                    ),
                  );
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>  Bottombar()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
