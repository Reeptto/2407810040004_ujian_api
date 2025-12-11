// import 'package:ari_2407810040004_ujian_api/page/register.dart';
import 'package:ari_2407810040004_ujian_api/page/todo.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // routes: {
      //   "/" :(context)=>Page1(),
      //   "/halaman2":(context)=>Page2()
      // },
      // initialRoute: "/",
      home: TodoPage()
    );
  }
}