import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/API-provider.dart';

final titleController = TextEditingController();
final descriptionController = TextEditingController();

addDataWidget(BuildContext context) {
  return showModalBottomSheet(
      context: context,
      builder: (context) => Container(
          height: 500,
          width: 50,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(hintText: 'Add title'),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(hintText: 'Add description'),
              ),
              ElevatedButton(
                  onPressed: () {
                    if (titleController.text.isNotEmpty) {
                      Provider.of<TodoProvider>(context, listen: false)
                          .addData({
                        "title": titleController.text,
                        "message": descriptionController.text
                      }).whenComplete(() => Navigator.pop(context));
                      showDialog(
                          context: context,
                          builder: (context) => const AlertDialog(
                                title: Text('Message'),
                                content: Text('Your file is Added.'),
                              )).whenComplete(() => Navigator.pop(context));
                    }
                  },
                  child: const Text("Submit"))
            ],
          )));
}

updateDataWidget(BuildContext context, String id) {
  return showModalBottomSheet(
      context: context,
      builder: (context) => Container(
          height: 500,
          width: 500,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: titleController,
                decoration: const InputDecoration(hintText: 'Add title'),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(hintText: 'Add description'),
              ),
              ElevatedButton(
                  onPressed: () {
                    if (titleController.text.isNotEmpty) {
                      Provider.of<TodoProvider>(context, listen: false)
                          .updateData({
                        'id': id,
                        "title": titleController.text,
                        "message": descriptionController.text
                      }, id).whenComplete(() => Navigator.pop(context));
                      showDialog(
                          context: context,
                          builder: (context) => const AlertDialog(
                                title: Text('Message'),
                                content: Text('Your file is Added.'),
                              )).whenComplete(() => Navigator.pop(context));
                    }
                  },
                  child: Container(
                      margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                      child: const Text('Updated',
                          style: TextStyle(fontSize: 15)))),
            ],
          )));
}

deleteDataWidget(BuildContext context, String id) {
  return showModalBottomSheet(
      context: context,
      builder: (context) => Container(
          height: 200,
          width: 50,
          alignment: Alignment.center,
          child: Center(
              child: Column(
            children: <Widget>[
              const Center(
                child: ListTile(
                    leading: Icon(Icons.photo),
                    title: Text('Click Yes To Delete Items')),
              ),
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('Yes'),
                onTap: () {
                  Provider.of<TodoProvider>(context, listen: false)
                      .deleteData(id)
                      .whenComplete(() => Navigator.pop(context));
                  showDialog(
                      context: context,
                      builder: (context) => const AlertDialog(
                            title: Text('Message'),
                            content: Text('Your file is Deleted.'),
                          )).whenComplete(() => Navigator.pop(context));
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('No'),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) => const AlertDialog(
                            title: Text('Message'),
                            content: Text('Your file is not Deleted.'),
                          )).whenComplete(() => Navigator.pop(context));
                },
              ),
            ],
          ))));
}
