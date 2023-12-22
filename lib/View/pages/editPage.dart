// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables, duplicate_ignore, non_constant_identifier_names, unrelated_type_equality_checks, file_names, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wallet_application/controller/edit_provider.dart';
import 'package:wallet_application/widgets/bottomBar/bottom_bar.dart';
import '../../controller/db_functions.dart';
import '../../model/dataModel.dart';

class EditPage extends StatefulWidget {
  var id;
  var description;
  var amoUnt;
  var statement;
  var date;

  EditPage(
      {super.key,
      required this.id,
      required this.description,
      required this.amoUnt,
      required this.statement,
      required this.date});

  @override
  State<EditPage> createState() => EditPageState();
}

class EditPageState extends State<EditPage> {
  @override
  void initState() {
    final provider = Provider.of<EditProvider>(context, listen: false);
    super.initState();
    provider.editAmountC = TextEditingController(text: widget.amoUnt);
    provider.editDescription = TextEditingController(text: widget.description);
    provider.statement = widget.statement;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit here',
          style: TextStyle(
              fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 45, left: 16),
          child: container2(context),
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
                editall();
              },
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    width: 100,
                    height: 50,
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
          const SizedBox(
            height: 20,
          )
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
      child: Consumer<EditProvider>(builder: (context, editProvider, child) {
        return TextButton(
            onPressed: () async {
              DateTime? newDate = await showDatePicker(
                  context: context,
                  initialDate: editProvider.date,
                  firstDate: DateTime(2023),
                  lastDate: DateTime(2500));
              if (newDate == Null) return;
              editProvider.setDate(newDate!);
            },
            child: Text(
              'Date : ${editProvider.date.day} /${editProvider.date.month} /${editProvider.date.year}',
              style: const TextStyle(fontSize: 15, color: Colors.black),
            ));
      }),
    );
  }

  Padding Through() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Consumer<EditProvider>(
        builder: (context, provider, child) {
          return Container(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 15),
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 2,
                  color: Colors.grey,
                ),
              ),
              child: SingleChildScrollView(
                child: DropdownButtonFormField<String>(
                  hint: Row(
                    children: [
                      Text(widget.statement,
                          style: const TextStyle(color: Colors.black)),
                    ],
                  ),
                  value: provider.statement,
                  onChanged: ((value) {
                    provider.setSelectedType(value!);
                  }),
                  items: provider.editCategory
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
                  dropdownColor: Colors.white,
                  isExpanded: true,
                ),
              ));
        },
      ),
    );
  }

  Padding amount_() {
    final editProvider = Provider.of<EditProvider>(context, listen: false);
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SizedBox(
          width: 300,
          child: TextField(
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            controller: editProvider.editAmountC,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              labelText: 'Amount',
              labelStyle: TextStyle(fontSize: 15, color: Colors.grey.shade500),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(width: 2, color: Colors.grey)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                      width: 2, color: Color.fromARGB(255, 158, 149, 149))),
            ),
          ),
        ));
  }

  Padding description() {
    final editProvider = Provider.of<EditProvider>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: SizedBox(
        width: 300,
        child: TextField(
          controller: editProvider.editDescription,
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
        ),
      ),
    );
  }

  Future<void> editall() async {
    final editProvider = Provider.of<EditProvider>(context, listen: false);
    final dbProvider = Provider.of<DBProvider>(context, listen: false);
    final description = editProvider.editDescription.text;
    final amount = editProvider.editAmountC.text;

    final datE = editProvider.date;

    final model = DataModel(
      through: editProvider.statement!,
      amount: amount,
      datetime: datE,
      description: description,
      id: widget.id
    );

    await dbProvider.editData(model);
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) =>  Bottombar(),
    ));
  }
}
