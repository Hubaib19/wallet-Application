// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet_application/controller/db_functions.dart';
import 'editPage.dart';

class TransactionHistory extends StatefulWidget {
  const TransactionHistory({Key? key}) : super(key: key);

  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<DBProvider>(context, listen: false);
    provider.searchedList;
    provider.getAllData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Transactions',
          style: TextStyle(
              fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Consumer<DBProvider>(
                builder: (context, provider, child) {
                  return Container(
                    height: 45,
                    width: 120,
                    color: const Color.fromARGB(255, 255, 255, 255),
                    child: TextField(
                      onChanged: (value) {
                        provider.setSearch(value);
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
                  );
                },
              ),
            ),
          ),
        ],
        toolbarHeight: 80,
      ),
      body: Consumer<DBProvider>(
        builder: (context, provider, child) {
          if (provider.transactionList.isEmpty) {
            return const Center(
              child: Text(
                'No results found',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            );
          }
          return ListView.separated(
            itemBuilder: (ctx, index) {
              final data = provider.transactionList[index];
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
                                      provider.deleteData(data);
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
                              id: data.id,
                              description: data.description,
                              amoUnt: data.amount,
                              statement: data.through,
                              date: data.datetime.toString(),
                            ),
                          ));
                        },
                        icon:
                            const Icon(Icons.edit_rounded, color: Colors.black),
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
            itemCount: provider.transactionList.length,
          );
        },
      ),
    );
  }
}
