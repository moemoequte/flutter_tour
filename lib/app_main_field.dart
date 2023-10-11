import 'package:flutter/material.dart';

AppMainFieldNotifier kAppMainfieldNotifier = AppMainFieldNotifier();

class AppMainFieldNotifier with ChangeNotifier {
  late String currentWidgetName;
  Widget currentWidget = const AppMainFieldInitContent();

  void changeAppMainFieldView(String name, Widget widget) {
    currentWidgetName = name;
    currentWidget = widget;
    notifyListeners();
  }
}

class AppMainField extends StatelessWidget {
  const AppMainField({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: kAppMainfieldNotifier,
      builder: (context, child) {
        return kAppMainfieldNotifier.currentWidget;
      },
    );
  }
}

class AppMainFieldInitContent extends StatelessWidget {
  const AppMainFieldInitContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('init content'); // TODO
  }
}
