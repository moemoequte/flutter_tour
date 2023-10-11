import 'package:flutter/material.dart';

AppMainFieldNotifier kAppMainfieldNotifier = AppMainFieldNotifier();

class AppMainFieldNotifier with ChangeNotifier {}

class AppMainField extends StatelessWidget {
  const AppMainField({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: kAppMainfieldNotifier,
      builder: (context, child) {
        return const Text('todo field');
      },
    );
  }
}
