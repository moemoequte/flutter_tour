import 'package:flutter/material.dart';
import 'package:flutter_tour/app_main_field.dart';
import 'package:flutter_tour/app_navigate_field.dart';

class AppPage extends StatelessWidget {
  const AppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(children: [
        AppNavigateField(),
        const Expanded(child: AppMainField())
      ]),
    );
  }
}
