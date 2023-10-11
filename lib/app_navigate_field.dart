import 'package:flutter/material.dart';

AppNavigateFieldNotifier kAppNavigateNotifier = AppNavigateFieldNotifier();

class AppNavigateFieldNotifier with ChangeNotifier {}

class AppNavigateField extends StatelessWidget {
  const AppNavigateField({super.key});

  final double _widthFactor = 0.2;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: kAppNavigateNotifier,
      builder: (context, child) {
        return SizedBox(
          width: MediaQuery.of(context).size.width * _widthFactor,
          child: const Column(
            children: [],
          ),
        );
      },
    );
  }
}
