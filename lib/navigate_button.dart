import 'package:flutter/material.dart';
import 'package:flutter_tour/app_main_field.dart';

class NavigateButton extends StatelessWidget {
  const NavigateButton(
      {super.key,
      required this.buttonText,
      required this.isSelected,
      required this.routeToWidget});

  final String buttonText;
  final bool isSelected; // TODO
  final Widget routeToWidget;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () => kAppMainfieldNotifier.changeAppMainFieldView(
            buttonText, routeToWidget),
        child: Text(buttonText));
  }
}
