// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:docs_clone_flutter/constant.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketClient {
  io.Socket? socket;

  static SocketClient? _instance;

  SocketClient._internal() {
    socket = io.io(host, <String, dynamic>{
      'transport': ['websocket'],
      'autoConnect': false,
    });
    socket!.connect();
  }

  static SocketClient get instance {
    _instance ??= SocketClient._internal();
    return _instance!;
  }
}
