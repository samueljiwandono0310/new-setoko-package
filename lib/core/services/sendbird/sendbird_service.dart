import 'package:sendbird_sdk/sendbird_sdk.dart';
import 'package:setoko_chat_package/core/services/sendbird/sb.dart';
import 'package:setoko_chat_package/core/interfaces/chat_interface.dart';

class SendBirdService implements ChatInterface {
  SendBirdService._constructor();

  static final SendBirdService _instance = SendBirdService._constructor();

  factory SendBirdService() {
    return _instance;
  }

  final _sendbird = SB.sendbird;

  // General related
  @override
  Future<User> connect(
    String userId, {
    String? nickname,
    String? accessToken,
    String? apiHost,
    String? wsHost,
  }) async {
    final _result = await SB.callback<Future<User>>(
      () => _sendbird.connect(
        userId,
        nickname: nickname,
        accessToken: accessToken,
        apiHost: apiHost,
        wsHost: wsHost,
      ),
      (error) => disconnect(),
    );

    return _result;
  }

  @override
  void disconnect() {
    SB.callback<void>(() => _sendbird.disconnect());
  }

  @override
  bool reconnect() {
    return SB.callback<bool>(() => _sendbird.reconnect());
  }

  @override
  bool isInitialized() {
    return SB.callback<bool>(() => _sendbird.isInitialized());
  }

  @override
  Future<PushTokenRegistrationStatus> registerPushToken({
    required PushTokenType type,
    required String token,
    bool alwaysPush = false,
    bool unique = false,
  }) async {
    final _result = await SB.callback<Future<PushTokenRegistrationStatus>>(
      () => _sendbird.registerPushToken(
        type: type,
        token: token,
      ),
    );

    return _result;
  }

  @override
  Future<void> unregisterPushToken({required PushTokenType type, required String token}) async {
    await SB.callback<Future<void>>(
      () => _sendbird.unregisterPushToken(
        type: type,
        token: token,
      ),
    );
  }

  @override
  User? get currentUser => SB.callback<User?>(() => _sendbird.currentUser);
}
