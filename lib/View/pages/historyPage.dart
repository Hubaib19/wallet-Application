// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet_application/controller/dataBase/db.functions.dart';
import '../../model/dataModel.dart';
import 'editPage.dart';

class TransactionHistory extends StatefulWidget {
  const TransactionHistory({Key? key}) : super(key: key);

  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  String _search = "";
  List<DataModel> searchedList = [];

  @override
  void initState() {
    getAlldata();
    searchedList = walletListnotifier.value;
    super.initState();
  }

  void searchResult() {
    searchedList = walletListnotifier.value
        .where((statementModel) => statementModel.description
            .toLowerCase()
            .contains(_search.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'History',
          style: TextStyle(
              fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Container(
                height: 45,
                width: 120,
                color: const Color.fromARGB(255, 255, 255, 255),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      _search = value;
                    });
                    searchResult();
                  },
                  decoration: InputDecoration(
                    focusColor: Colors.black,
                    suffixIcon: const Icon(
                      Icons.search_rounded,
                      color: Colors.black,
                    ),
                    hintText: 'Search...',
                    hintStyle: const TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
        toolbarHeight: 80,
      ),
      body: Consumer<DBProvider>(builder: (context, value, child) {
        return ValueListenableBuilder(
          valueListenable: DBProvider.walletListnotifier,
          builder:
              (BuildContext ctx, List<DataModel> walletList, Widget? child) {
            if (searchedList.isEmpty) {
              return const Center(
                child: Text(
                  'No results found',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              );
            }
            return ListView.separated(
              itemBuilder: (ctx, index) {
                final data = searchedList[index];
                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.all(8),
                  color: Colors.white,
                  child: ListTile(
                    title: Text(
                      data.description,
                      style: const TextStyle(
                          fontSize: 19, fontWeight: FontWeight.w700),
                    ),
                    subtitle: Text(
                      '${data.datetime.year}-${data.datetime.day}-${data.datetime.month}',
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          data.amount,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: data.through == 'Income'
                                ? Colors.green[400]
                                : const Color.fromARGB(255, 202, 27, 15),
                          ),
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text(
                                    " Delete Data",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  content: const Text(
                                    " You are going to delete this data",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text(
                                        "No",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red),
                                      onPressed: () {
                                        Provider.of<DBProvider>(context)
                                            .deleteData(index);
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text(
                                        "Yes",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          icon: const Icon(
                            Icons.delete_rounded,
                            color: Colors.red,
                          ),
                        ),
                        const SizedBox(width: 2),
                        IconButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => EditPage(
                                id: index,
                                description: data.description,
                                amoUnt: data.amount,
                                statement: data.through,
                                date: data.datetime.toString(),
                              ),
                            ));
                          },
                          icon: const Icon(Icons.edit_rounded,
                              color: Colors.black),
                        ),
                        const SizedBox(
                          width: 2,
                        )
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (ctx, index) {
                return const Divider();
              },
              itemCount: searchedList.length,
            );
          },
        );
      }),
    );
  }
}
