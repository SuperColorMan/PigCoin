import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;
/// -------------------------------
/// Des: 即时通讯全局管理类
/// -------------------------------
class ImCommManager{
  /// 协议
  static const String PROTOCOL = "ws://";

  /// 接口ip
  static const String IP = "127.0.0.1";

  /// 端口
  static const String PORT = "8899";

  /// WebSocket通讯地址
  static const String  WS_LOCAL = PROTOCOL + IP + ":" + PORT + "/api/im/server";

  /// 连接句柄
  static var channel;

  /// 初始化
  static Future<void> init() async {
    /// 建立连接
    channel = await IOWebSocketChannel.connect(WS_LOCAL);
  }
}