import 'package:sendbird_sdk/sendbird_sdk.dart';
import 'package:setoko_chat_package/core/interfaces/chat_interface.dart';
import 'package:setoko_chat_package/core/services/sendbird/sendbird_service.dart';

class ChatModule {
  static ChatModule _instance = ChatModule._constructor();

  ChatModule._constructor() : _chatInterface = SendBirdService();

  late ChatInterface _chatInterface;

  factory ChatModule([
    ChatInterface? chatInterface,
  ]) {
    if (chatInterface != null) {
      _instance._chatInterface = chatInterface;

      return _instance;
    }

    return _instance;
  }

  // General related
  Future<User> connect(
    String userId, {
    String? nickname,
    String? accessToken,
    String? apiHost,
    String? wsHost,
  }) async {
    return _chatInterface.connect(
      userId,
      accessToken: accessToken,
      apiHost: apiHost,
      nickname: nickname,
      wsHost: wsHost,
    );
  }

  void disconnect() => _chatInterface.disconnect();

  bool reconnect() => _chatInterface.reconnect();

  bool isInitialized() => _chatInterface.isInitialized();

  Future<PushTokenRegistrationStatus> registerPushToken({
    required PushTokenType type,
    required String token,
    bool alwaysPush = false,
    bool unique = false,
  }) async {
    return _chatInterface.registerPushToken(type: type, token: token);
  }

  Future<void> unregisterPushToken({required PushTokenType type, required String token}) async {
    return _chatInterface.unregisterPushToken(type: type, token: token);
  }

  User? get currentUser => _chatInterface.currentUser;
}
