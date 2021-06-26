import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth/auth.dart';
import 'auth/auth1.dart';

Future<void> main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => Auth(),
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "King Shoes",
        theme: ThemeData(
          primarySwatch: Colors.yellow,
        ),
        home: LoginPage(),
      ),
    );
  }
}
