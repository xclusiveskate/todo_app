import 'package:flutter/material.dart';
import 'package:todo_app/ui.dart';

class Datas extends StatefulWidget {
  const Datas({Key? key}) : super(key: key);

  @override
  State<Datas> createState() => _DatasState();
}

class _DatasState extends State<Datas> {
  final textController = TextEditingController();
  dynamic data;
  // List<String> todoData = [];

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)!.settings.arguments;
    print(data['index']);
    textController.text = data['data'];
    // var todoData;
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            SizedBox(
                width: 350,
                height: 100,
                child: TextField(
                  controller: textController,
                  decoration: const InputDecoration(labelText: 'Edit'),
                )),
            const SizedBox(height: 10),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, 
                       {'data': textController.text, 'index': data['index']});
                },
                child: const Text('save')),
          ],
        ));
  }
}
