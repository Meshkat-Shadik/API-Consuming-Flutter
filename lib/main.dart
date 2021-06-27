import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_riverpod_api/Api/States/api_state.dart';
import 'package:freezed_riverpod_api/Pages/ApiPage.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Riverpod with Freezed',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ApiPage(),
    );
  }
}
