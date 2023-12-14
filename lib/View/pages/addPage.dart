// ignore_for_file: non_constant_identifier_names, unrelated_type_equality_checks, no_leading_underscores_for_local_identifiers, file_names
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wallet_application/View/pages/homePage.dart';
import '../../dataBase/db.functions.dart';
import '../../model/dataModel.dart';

class AddData extends StatefulWidget {
  const AddData({super.key});

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  DateTime date = DateTime.now();
  String? statement;

  final TextEditingController Description = TextEditingController();

  TextEditingController statementController = TextEditingController();

  final TextEditingController amountC = TextEditingController();

  final List<String> category1 = [
    'Income',
    'Expense',
  ];
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    getAlldata();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Add Transactions',
          style: TextStyle(
              fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Form(
        key: _formkey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 45, left: 16),
            child: container2(context),
          ),
        ),
      ),
    );
  }

  Container container2(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth * 0.9,
      height: 550,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 50),
          description(),
          const SizedBox(height: 30),
          amount_(),
          const SizedBox(height: 30),
          Through(),
          const SizedBox(height: 30),
          date_time(context),
          const Spacer(),
          Expanded(
            child: GestureDetector(
              onTap: () {
                onAddbuttonClicked(context);
              },
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    child: const Text(
                      'Save ',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container date_time(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 2, color: Colors.grey)),
      width: 300,
      child: TextButton(
          onPressed: () async {
            DateTime? newDate = await showDatePicker(
                context: context,
                initialDate: date,
                firstDate: DateTime(2023),
                lastDate: DateTime(2500));
            if (newDate == Null) return;
            setState(() {
              date = newDate!;
            });
          },
          child: Text(
            'Date : ${date.day} /${date.month} /${date.year}',
            style: const TextStyle(fontSize: 15, color: Colors.black),
          )),
    );
  }

  Padding Through() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 2,
            color: const Color.fromARGB(255, 144, 143, 143),
          ),
        ),
        child: Row(
          children: [
            Expanded(
                child: TextFormField(
              controller: statementController,
              readOnly: true,
              decoration: const InputDecoration(
                hintText: 'Statement',
                hintStyle: TextStyle(color: Colors.grey),
                suffixIcon: Icon(Icons.arrow_drop_down),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'statement is empty';
                } else {
                  return null;
                }
              },
              onTap: () {
                _showStatementPicker(context);
              },
            )),
          ],
        ),
      ),
    );
  }

  void _showStatementPicker(BuildContext context) async {
    String? selectedStatement = await showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(20, 370, 90, 0),
      items: category1.map((e) {
        return PopupMenuItem(
          value: e,
          child: Text(e),
        );
      }).toList(),
    );
    if (selectedStatement != null) {
      setState(() {
        statement = selectedStatement;
        statementController.text = statement!;
      });
    }
  }

  Padding amount_() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SizedBox(
          width: 300,
          child: TextFormField(
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              controller: amountC,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                labelText: 'Amount',
                labelStyle:
                    TextStyle(fontSize: 15, color: Colors.grey.shade500),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(width: 2, color: Colors.grey)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    width: 2,
                    color: Color.fromARGB(255, 158, 149, 149),
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Amount is empty';
                }
                return null;
              }),
        ));
  }

  Padding description() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: SizedBox(
        width: 300,
        child: TextFormField(
            controller: Description,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              labelText: 'Category',
              labelStyle: TextStyle(fontSize: 15, color: Colors.grey.shade500),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(width: 2, color: Colors.grey)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                      width: 2, color: Color.fromARGB(255, 158, 149, 149))),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Category is empty';
              }
              return null;
            }),
      ),
    );
  }

  onAddbuttonClicked(BuildContext context) {
    if (_formkey.currentState!.validate()) {
      final _description = Description.text.trim();
      final _amount = amountC.text.trim();
      final _statement = statement.toString();
      final _date = date;

      if (statement!.isEmpty || _amount.isEmpty || _description.isEmpty) {
        return;
      } else {
        final dataToadd = DataModel(
          description: _description,
          amount: _amount,
          through: _statement,
          datetime: _date,
        );
        addData(dataToadd);

        Navigator.of(context)
            .pop(MaterialPageRoute(builder: (context) => const HomePage()));
      }
    }
  }
}
