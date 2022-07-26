import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:todo_app/datas.dart';
import 'package:todo_app/ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      toastTheme: ToastThemeData(textColor: Colors.white, 
      background: Colors.amber[200],
      alignment:const Alignment(0.4, 0.7)
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: const ToDo(),
        initialRoute: '/',
        routes: {
          '/':(context) => const ToDo(),
          '/edit':(context) => const Datas()
        },
      ),
    );
  }
}

