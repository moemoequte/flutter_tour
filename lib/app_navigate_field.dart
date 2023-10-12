import 'package:flutter/material.dart';
import 'package:flutter_tour/app_main_field.dart';
import 'package:flutter_tour/navigate_button.dart';

AppNavigateFieldNotifier kAppNavigateNotifier = AppNavigateFieldNotifier();

class AppNavigateFieldNotifier with ChangeNotifier {}

class AppNavigateField extends StatelessWidget {
  AppNavigateField({super.key});

  final double _widthFactor = 0.2;
  final List<_ListNodeContent> _list = [
    _ListNodeContent('title a', const Text('a')),
    _ListNodeContent('title b', const Text('b'))
  ];

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: kAppNavigateNotifier,
      builder: (context, child) {
        return SizedBox(
          width: MediaQuery.of(context).size.width * _widthFactor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List.generate(_list.length, (index) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                child: NavigateButton(
                    buttonText: _list[index].title,
                    isSelected: _list[index].title ==
                        kAppMainfieldNotifier.currentWidgetName,
                    routeToWidget: _list[index].widget),
              );
            }),
          ),
        );
      },
    );
  }
}

class _ListNodeContent {
  _ListNodeContent(this.title, this.widget);
  final String title;
  final Widget widget;
}
