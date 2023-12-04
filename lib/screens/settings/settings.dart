// ignore_for_file: file_names
import 'package:flutter/material.dart';
import '../../bottomBar/bottom_bar.dart';
import '../../dataBase/db.functions.dart';
import 'privacy.dart';
import 'terms.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
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
                  resetData(index);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      margin: const EdgeInsets.all(10),
                      backgroundColor: Colors.grey[100],
                      behavior: SnackBarBehavior.floating,
                      content: const Text("Reset completed..."),
                    ),
                  );
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const Bottombar()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
