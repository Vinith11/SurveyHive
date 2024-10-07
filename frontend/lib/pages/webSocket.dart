import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class WebSocketService {
  final WebSocketChannel channel;

  WebSocketService._(this.channel);

  factory WebSocketService.connect(String url) {
    final channel = WebSocketChannel.connect(Uri.parse(url));
    return WebSocketService._(channel);
  }

  void sendMessage(String message) {
    channel.sink.add(message);
  }

  void close() {
    channel.sink.close(status.goingAway);
  }
}
