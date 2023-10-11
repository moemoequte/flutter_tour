import 'package:flutter/material.dart';

AppNavigateFieldNotifier kAppNavigateNotifier = AppNavigateFieldNotifier();

class AppNavigateFieldNotifier with ChangeNotifier {}

class AppNavigateField extends StatelessWidget {
  const AppNavigateField({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: kAppNavigateNotifier,
      builder: (context, child) {
        return const Text('todo field');
      },
    );
  }
}
