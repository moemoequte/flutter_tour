import 'package:flutter/material.dart';

class CounterApp extends StatelessWidget {
  CounterApp({super.key});

  final _numNotifier = _CenterNumberNotifier();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.9,
          child: Center(
              child: ListenableBuilder(
            builder: (context, child) {
              return Text('${_numNotifier.num}');
            },
            listenable: _numNotifier,
          )),
        ),
        Row(
          children: [
            const Spacer(),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.1,
              child: FloatingActionButton(
                onPressed: () => _numNotifier.adder(),
                tooltip: 'Add 1',
                child: const Icon(Icons.add),
              ),
            )
          ],
        )
      ],
    );
  }
}

class _CenterNumberNotifier with ChangeNotifier {
  int num = 0;

  void adder() {
    num += 1;
    notifyListeners();
  }
}
