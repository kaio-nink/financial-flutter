import 'dart:io';

import 'package:financial_flutter/src/home_page.dart';
import 'package:financial_flutter/src/register_page.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

void main() {
  // if (Platform.isWindows || Platform.isLinux) {
  //   // Initialize FFI
  //   sqfliteFfiInit();
  // }
  
  databaseFactory = databaseFactoryFfiWeb;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => const HomePage(),
        '/register': (BuildContext context) => const Register(title: 'Lançamentos'),
      },
    );
  }
}

