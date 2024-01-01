// ignore_for_file: non_constant_identifier_names, unrelated_type_equality_checks, no_leading_underscores_for_local_identifiers, file_names, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wallet_application/widgets/bottomBar/bottom_bar.dart';
import '../../controller/db_functions.dart';
import '../../model/dataModel.dart';

class AddData extends StatefulWidget {
  const AddData({super.key});

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Provider.of<DBProvider>(context).getAllData();
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
                final provider =
                    Provider.of<DBProvider>(context, listen: false);
                addTransaction();
                provider.description.clear();
                provider.amountC.clear();
                provider.selectedType = null;
                provider.date = DateTime.now();
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
    final transactionProvider = Provider.of<DBProvider>(context, listen: false);
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
                initialDate: transactionProvider.date,
                firstDate: DateTime(2023),
                lastDate: DateTime(2500));
            if (newDate == Null) return;

            Provider.of<DBProvider>(context, listen: false);
            transactionProvider.date = newDate!;
          },
          child: Text(
            'Date : ${transactionProvider.date.day} /${transactionProvider.date.month} /${transactionProvider.date.year}',
            style: const TextStyle(fontSize: 15, color: Colors.black),
          )),
    );
  }

  Padding Through() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Consumer<DBProvider>(
        builder: (context, provider, child) {
          return Container(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 15),
              width: 300,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 2,
                    color: Colors.grey,
                  )),
              child: DropdownButtonFormField<String>(
                value: provider.selectedType,
                onChanged: ((value) {
                  provider.setSelectedType(value!);
                }),
                items: provider.category1
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Row(
                            children: [
                              Text(
                                e,
                                style: const TextStyle(fontSize: 17),
                              )
                            ],
                          ),
                        ))
                    .toList(),
                hint: const Text(
                  'Select',
                  style: TextStyle(color: Colors.grey),
                ),
                dropdownColor: Colors.white,
                isExpanded: true,
              ));
        },
      ),
    );
  }

  Padding amount_() {
    final transactionProvider = Provider.of<DBProvider>(context, listen: false);
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SizedBox(
          width: 300,
          child: TextFormField(
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              controller: transactionProvider.amountC,
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
    final transactionProvider = Provider.of<DBProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: SizedBox(
        width: 300,
        child: TextFormField(
            controller: transactionProvider.description,
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

  Future addTransaction() async {
    final transactionProvider = Provider.of<DBProvider>(context, listen: false);
    final model = DataModel(
        through: transactionProvider.selectedType!,
        amount: transactionProvider.amountC.text,
        datetime: transactionProvider.date,
        description: transactionProvider.description.text,
        id: DateTime.now().microsecondsSinceEpoch.toString());

    await transactionProvider.addData(model);
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => Bottombar(),
    ));
    transactionProvider.getAllData();
  }
}
