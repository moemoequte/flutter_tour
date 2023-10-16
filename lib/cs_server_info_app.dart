import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tour/libssq.dart';

final _a2s = A2SLibrary(DynamicLibrary.open('ssq.dll'));

final _queryList = [
  _QueryParameter(hostname: 'css.cialloo.com', port: 27015),
  _QueryParameter(hostname: 'css.cialloo.com', port: 27016),
  _QueryParameter(hostname: 'bot.cialloo.com', port: 27015),
  _QueryParameter(hostname: 'bot.cialloo.com', port: 27016)
];

final _appInfoNotifier = _InfoAppNotifier();

class CSServerInfoApp extends StatelessWidget {
  const CSServerInfoApp({super.key});

  @override
  Widget build(BuildContext context) {
    _generateList();
    return ListenableBuilder(
      listenable: _appInfoNotifier,
      builder: (context, child) {
        return Column(
          children: [
            Column(
              children: _appInfoNotifier.infoTileList,
            ),
            const TextButton(onPressed: _generateList, child: Text('press'))
          ],
        );
      },
    );
  }
}

void _generateList() {
  _appInfoNotifier.infoTileList = List.generate(_queryList.length, (index) {
    return _InfoTile(
        future:
            _getServerInfo(_queryList[index].hostname, _queryList[index].port));
  });
  _appInfoNotifier.notify();
}

class _InfoAppNotifier with ChangeNotifier {
  late List<Widget> infoTileList;
  void notify() {
    notifyListeners();
  }
}

class _InfoTile extends StatelessWidget {
  final Future<_ServerInfo> future;

  const _InfoTile({required this.future});

  Widget _build(String info) {
    return Row(
      children: [
        Expanded(
            child: InkWell(
          child: Text(info),
        ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Text('fetching data');
        }

        if (snapshot.hasData) {
          var data = snapshot.data;
          return _build('${data?.hostname} ${data?.mapName}');
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const Text('fetching data');
      },
    );
  }
}

class _QueryParameter {
  final String hostname;
  final int port;

  _QueryParameter({required this.hostname, required this.port});
}

class _ServerInfo {
  final String hostname;
  final String mapName;
  final int playerCount;

  _ServerInfo(
      {required this.hostname,
      required this.mapName,
      required this.playerCount});
}

Future<_ServerInfo> _getServerInfo(String ip, int port) async {
  await Future.delayed(const Duration(milliseconds: 300));
  final server = _a2s.ssq_server_new(ip.toNativeUtf8() as Pointer<Char>, port);
  final info = _a2s.ssq_info(server as Pointer<Int>);
  final name = info.cast<Pointer<Utf8>>().elementAt(1).value.toDartString();
  final mapName = info.cast<Pointer<Utf8>>().elementAt(3).value.toDartString();
  final count = info.cast<Uint8>().elementAt(10).value;
  return _ServerInfo(mapName: mapName, playerCount: count, hostname: name);
}
