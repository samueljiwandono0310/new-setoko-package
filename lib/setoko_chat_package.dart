
import 'dart:async';

import 'package:flutter/services.dart';

class SetokoChatPackage {
  static const MethodChannel _channel = MethodChannel('setoko_chat_package');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
