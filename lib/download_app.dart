import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DownloadApp extends StatelessWidget {
  DownloadApp({super.key});

  final _progressNotifier = _DownloadProgressNotifier();
  double _value = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        SizedBox(
            height: 20,
            width: MediaQuery.of(context).size.width * 0.6,
            child: ListenableBuilder(builder: (context, child) {
              return LinearProgressIndicator(value: _value,);
            }, listenable: _progressNotifier,)),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(onPressed: () async {
          bool isDone = false;
          int contentLength = 0;
          int tempLength = 0;
          List<int> list = List.empty(growable: true);
          () async {
            final response = await http.Client().send(http.Request('GET', Uri.parse('https://upload.wikimedia.org/wikipedia/commons/f/ff/Pizigani_1367_Chart_10MB.jpg')));
            contentLength = response.contentLength ?? 0;
            response.stream.listen((value) { 
              tempLength += value.length;
              _value = tempLength/contentLength;
              list.addAll(value);
            }).onDone(() {
              File file = File('./a.jpg');
              file.createSync();
              file.writeAsBytesSync(list);
              isDone = true;
            });
          };
          while(!isDone) {
            await Future.delayed(Duration(milliseconds: 200));
            _progressNotifier.changeValue();
          }
        }, child: const Text('Download')),
        const Spacer()
      ],
    );
  }
}

class _DownloadProgressNotifier with ChangeNotifier {
  void changeValue() {
    notifyListeners();
  }
}