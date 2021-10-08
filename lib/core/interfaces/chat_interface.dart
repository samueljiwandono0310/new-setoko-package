import 'package:sendbird_sdk/sendbird_sdk.dart';

abstract class ChatInterface {
  // General related
  Future<User> connect(
    String userId, {
    String? nickname,
    String? accessToken,
    String? apiHost,
    String? wsHost,
  });

  void disconnect();

  bool reconnect();

  bool isInitialized();

  Future<PushTokenRegistrationStatus> registerPushToken({
    required String token,
    bool alwaysPush = false,
    bool unique = false,
  });

  Future<void> unregisterPushToken({
    required String token,
  });

  User? get currentUser;
}
