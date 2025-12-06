import 'package:d20_state_management/screens/home/home_page.dart';
import 'package:d20_state_management/screens/province/province_page.dart';
import 'package:d20_state_management/provider/province_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProvinceProvider(),
      child: MaterialApp(
        home: HomePage(title: "Welcome to Province!"),
        routes: {'/provinces': (context) => ProvincePage()},
      ),
    );
  }
}
