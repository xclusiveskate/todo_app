import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
// import 'package:todo_app/datas.dart';
// import 'package:flutter/src/foundation/key.dart';

class ToDo extends StatefulWidget {
  const ToDo({Key? key}) : super(key: key);

  @override
  State<ToDo> createState() => _ToDoState();
}

class _ToDoState extends State<ToDo> {
  var color = Colors.amber;
  final textController = TextEditingController();
  final scrollController = ScrollController();
  bool isEditing = false;
  List<String> todoData = [];
  List deletedData = [];
  int currentIndex = 0;
  int editIndex = 0;
  String edit = '';
  dynamic data;
  showTodo() {
    if (textController.text.isEmpty) {
      showToast();
    } else {
      setState(() {
        todoData.add(textController.text);
        textController.clear();
      });
    }
  }

  var toDelete;
  deleteTodo(int id) {
    setState(() {
      toDelete = todoData[id];
      deletedData.add(todoData[id]);
    });
    todoData.removeAt(id);
  }

  toEdit(int id) {
    setState(() {
      isEditing = true;
      editIndex = id;
      textController.text = todoData[id].toString();
      // todoData.add();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color,
        title: const Text("ToDo App"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            const Text("Manage your day to day activities here"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 4,
                    child: TextField(
                      controller: textController,
                      decoration: const InputDecoration(
                          hintText: "create todo",
                          hintStyle: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.normal)),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: IconButton(
                        onPressed: () {
                          // toast('message');
                          if (textController.text.isEmpty) {
                            showToast();
                          } else {
                            setState(() {
                              // if (isEditing) {
                              //   print(editIndex);
                              //   todoData[editIndex] = textController.text;
                              //   print(editIndex);

                              //   editIndex = 0;
                              //   print(editIndex);

                              //   isEditing = false;
                              // } else {
                              todoData.add(textController.text);
                              // }

                              // persistentData.add(textController.text);
                              textController.clear();
                              addSuccess();
                            });
                          }
                        },
                        icon: Icon(
                          Icons.send,
                          color: color,
                        )),
                  )
                ],
              ),
            ),
            ListView.builder(
                padding: const EdgeInsets.all(10.0),
                controller: scrollController,
                itemCount: todoData.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {},
                    title: Text(
                      todoData[index],
                      style: const TextStyle(overflow: TextOverflow.ellipsis),
                    ),
                    trailing: SizedBox(
                      width: MediaQuery.of(context).size.width / 4.5,
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () async{
                                dynamic received = await Navigator.pushNamed(
                                    context, '/edit',
                                    arguments: {
                                      'data': todoData[index],
                                      'index': index,
                                    });
                                if (received != null) {
                                  var nIndex = received['index'];
                                  setState(() {
                                    todoData[nIndex] = received['data'];
                                  });
                                } else {
                                  print('nayy');
                                }
                                // toEdit(index);
                              },
                              icon: const Icon(Icons.edit)),
                          IconButton(
                              onPressed: () => showDeleteLog(index),
                              icon: const Icon(Icons.delete)),
                        ],
                      ),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }

  void showDeleteLog(int id) async {
    return await showDialog(
        // barrierColor: Colors.amber[100],
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: color,
            title: const Text("About to delete a todo"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text("Are you sure you want to delete??"),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel")),
              TextButton(
                  onPressed: () {
                    setState(() {
                      deleteTodo(id);
                      showDelSuccess(id);
                      Navigator.pop(context);
                    });
                    setState(() {});
                    // }
                  },
                  child: const Text("Confirm")),
            ],
          );
        });
  }

  void showToast() {
    return toast("Textfield is empty",
        duration: const Duration(milliseconds: 5));
  }

  void showDelSuccess(index) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text(' item deleted successfully'),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: color,
      duration: const Duration(seconds: 16),
      action: SnackBarAction(
          label: "undo",
          onPressed: () {
            SnackBarClosedReason.swipe;

            undo(index);
          }),
    ));
  }

//[], ()
  void undo(int index) {
    List data = deletedData.where((element) => element == toDelete).toList();
    todoData.insert(index, data.first);
    setState(() {});
  }

  void addSuccess() {
    toast("todo item added");
  }
}
