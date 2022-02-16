import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../crud/crud.dart';
import '../provider/API-provider.dart';
import 'dart:convert';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int adminCurrentPage = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () => addDataWidget(context).whenComplete(() {
                  setState(() {});
                }),
            child: const Icon(Icons.add)),
        appBar: AppBar(
          title: const Text("TODO List"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Consumer<TodoProvider>(
          builder: (context, model, _) => FutureBuilder(
            future: model.fetchData(adminCurrentPage),
            // takeSnapShot()
            builder: (context, snapshot)  {
             
              return snapshot.hasData
                ? Column(
                    children: [
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: model.todoData?.length,
                          itemBuilder: (context, int index) => ListTile(
                                onLongPress: () {
                                  deleteDataWidget(context,
                                          model.todoData![index]["_id"])
                                      .whenComplete(() {
                                    setState(() {});
                                  });
                                },
                                onTap: () {
                                  updateDataWidget(context,
                                          model.todoData![index]["_id"])
                                      .whenComplete(() {
                                    setState(() {});
                                  });
                                },
                                title: Text(model.todoData![index]['title']),
                                subtitle: Text(model.todoData![index]['price']),                                
                               //leading: CircleAvatar(
                              // backgroundImage: 
                               //  NetworkImage(, 
                               //  model.todoData![index]["_id"],),
                               //  ),
                              )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (model.mapResponse!['adminCurrentPage'] <
                              model.mapResponse!['adminNumberOfPages'])
                            OutlinedButton(
                              onPressed: () {
                                setState(() {
                                  adminCurrentPage++;
                                  showDialog(
                                      context: context,
                                      builder: (context) => const AlertDialog(
                                          title: Text('Navigating...'),
                                          content:
                                              Text('Moving to the Next page')));
                                });
                              },
                              child: const Text(
                                "Next",
                              ),
                            ),
                          if (model.mapResponse!['adminCurrentPage'] > 1)
                            OutlinedButton(
                              onPressed: () {
                                setState(() {
                                  adminCurrentPage--;
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                          title: const Text('Navigating...'),
                                          content: Text(
                                              "Moving to the $adminCurrentPage page")));
                                });
                              },
                              child: const Text(
                                "Previous",
                              ),
                            ),
                        ],
                      ),
                    ],
                  )
                : snapshot.hasError
                    ? Text(snapshot.error.toString())
                    : const Center(
                        child: CircularProgressIndicator(),
                      );
            }
          ),
        )));
  }
}

