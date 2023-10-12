import 'package:flutter/material.dart';

class AsyncApp extends StatelessWidget {
  const AsyncApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(const SnackBar(content: Text('wait for 3 seconds')));
          await Future.delayed(const Duration(seconds: 1));
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(const SnackBar(
              content: Text('3 seconds later'),
              duration: Duration(seconds: 2),
            ));
        },
        child: const Text('Async Button'),
      ),
    );
  }
}
