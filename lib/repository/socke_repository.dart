import 'package:docs_clone_flutter/clients/socket_client.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketRepository {
  final _socketClient = SocketClient.instance.socket!;

  Socket get socketClient => _socketClient;

  void joinRoom(String docId) {
    _socketClient.emit('join', docId);
  }

  void typing(Map<String, dynamic> data) {
    // print('object typing');
    _socketClient.emit('typing', data);
  }

  void changeLister(Function(Map<String, dynamic>) func) {
    _socketClient.on('changess', (data) {
    print('object changeq');
      return func(data);
    });
  }
}
