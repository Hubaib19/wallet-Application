// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables, duplicate_ignore, non_constant_identifier_names, unrelated_type_equality_checks, file_names
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../bottomBar/bottom_bar.dart';
import '../../dataBase/db.functions.dart';
import '../../model/dataModel.dart';

class EditPage extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  int? id;
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
  DateTime date = DateTime.now();
  String? statement;

  TextEditingController Description = TextEditingController();
  TextEditingController amountC = TextEditingController();
  TextEditingController Statement = TextEditingController();
  TextEditingController Date = TextEditingController();

  List<String> category1 = [
    'Income',
    'Expense',
  ];

  @override
  void initState() {
    super.initState();

    Description = TextEditingController(text: widget.description);
    amountC = TextEditingController(text: widget.amoUnt);
    Statement = TextEditingController(text: widget.statement);
    Date = TextEditingController(text: widget.date);
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
          padding: const EdgeInsets.only(top: 15, left: 26, right: 25),
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
                editall(context);
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                width: 100,
                height: 15,
                child: const Text(
                  'Save ',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: 17,
                  ),
                ),
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
            'Date : ${date.day.toString()} /${date.month.toString()} /${date.year.toString()}',
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
              width: 2, color: const Color.fromARGB(255, 144, 143, 143)),
        ),
        child: DropdownButton<String>(
            value: widget.statement,
            items: category1
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 40,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            e,
                            style: const TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ))
                .toList(),
            selectedItemBuilder: (context) => category1
                .map((e) => Row(
                      children: [
                        const SizedBox(
                          width: 42,
                        ),
                        Text(e),
                      ],
                    ))
                .toList(),
            hint: const Text(
              'Statement',
              style: TextStyle(color: Colors.grey),
            ),
            isExpanded: true,
            underline: Container(),
            onChanged: ((value) {
              setState(() {
                widget.statement = value!;
              });
            })),
      ),
    );
  }

  Padding amount_() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SizedBox(
          width: 300,
          child: TextField(
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            controller: amountC,
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: SizedBox(
        width: 300,
        child: TextField(
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
        ),
      ),
    );
  }

  editall(BuildContext context) async {
    final descriptioN = Description.text.trim();
    final amounT = amountC.text.trim();
    final statemenT = widget.statement.toString();
    final datE = date;

    final DataModel dataToadd = DataModel(
      description: descriptioN,
      amount: amounT,
      through: statemenT,
      datetime: datE,
    );
    editdata(widget.id, dataToadd);

    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const Bottombar()));
  }
}
