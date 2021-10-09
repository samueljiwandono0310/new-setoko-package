import 'package:sendbird_sdk/sendbird_sdk.dart';
import 'package:setoko_chat_package/core/constants/constan.dart';
import 'package:setoko_chat_package/core/extensions/logger_extension.dart';

class SB {
  SB._constructor();

  static final SB _instance = SB._constructor();

  factory SB() {
    return _instance;
  }

  static T callback<T>(Function callback) {
    try {
      return callback();
    } catch (error) {
      error.logger();
      throw error;
    }
  }

  static final sendbird = SendbirdSdk(appId: SEND_BIRD_APP_ID);
}
