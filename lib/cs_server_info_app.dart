import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tour/libssq.dart';

final _a2s = A2SLibrary(DynamicLibrary.open('ssq.dll'));

class CSServerInfoApp extends StatelessWidget {
  const CSServerInfoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        _ServerInfoListTile(
          hostname: 'css.cialloo.com',
          port: 27015,
        ),
        _ServerInfoListTile(hostname: 'css.cialloo.com', port: 27016),
      ],
    );
  }
}

class _ServerInfoListTile extends StatelessWidget {
  const _ServerInfoListTile({required this.hostname, required this.port});

  final String hostname;
  final int port;

  @override
  Widget build(BuildContext context) {
    final future = _getServerInfo(hostname, port);
    return Row(
      children: [
        Expanded(
            child: InkWell(
          child: FutureBuilder(
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.data;
                return Text('${data?.hostname} ${data?.mapName}');
              } else if (snapshot.hasError) {
                return Text('query error: ${snapshot.error}');
              }

              return Text('quering $hostname:$port');
            },
            future: future,
          ),
          onTap: () {},
        ))
      ],
    );
  }
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
  await Future.delayed(Duration.zero);
  final server = _a2s.ssq_server_new(ip.toNativeUtf8() as Pointer<Char>, port);
  final info = _a2s.ssq_info(server as Pointer<Int>);
  final name = info.cast<Pointer<Utf8>>().elementAt(1).value.toDartString();
  final mapName = info.cast<Pointer<Utf8>>().elementAt(3).value.toDartString();
  final count = info.cast<Uint8>().elementAt(10).value;
  return _ServerInfo(mapName: mapName, playerCount: count, hostname: name);
}
