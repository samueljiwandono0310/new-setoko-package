import 'package:sendbird_sdk/sendbird_sdk.dart';
import 'package:setoko_chat_package/core/services/sendbird/sb.dart';

class SendBirdHandlerService {
  SendBirdHandlerService._constructor();

  static final SendBirdHandlerService _instance = SendBirdHandlerService._constructor();

  factory SendBirdHandlerService() {
    return _instance;
  }

  final _sendbird = SB.sendbird;

  // Handler related

  void addChannelEventHandler(String identifier, ChannelEventHandler handler) {
    SB.callback<void>(() => _sendbird.addChannelEventHandler(identifier, handler));
  }

  void removeChannelEventHandler(String identifier) {
    SB.callback<void>(() => _sendbird.removeChannelEventHandler(identifier));
  }

  void addConnectionEventHandler(String identifier, ConnectionEventHandler handler) {
    SB.callback<void>(() => _sendbird.addConnectionEventHandler(identifier, handler));
  }

  void removeConnectionEventHandler(String identifier) {
    SB.callback<void>(() => _sendbird.removeConnectionEventHandler(identifier));
  }

  void addSessionEventHandler(SessionEventHandler handler) {
    SB.callback<void>(() => _sendbird.addSessionEventHandler(handler));
  }

  void removeSessionEventHandler() {
    SB.callback<void>(() => _sendbird.removeSessionEventHandler());
  }

  void addUserEventHandler(String identifier, UserEventHandler handler) {
    SB.callback<void>(() => _sendbird.addUserEventHandler(identifier, handler));
  }

  void removeUserEventHandler(String identifier) {
    SB.callback<void>(() => _sendbird.removeUserEventHandler(identifier));
  }

  ChannelEventHandler? getChannelEventHandler(String identifier) {
    return SB.callback<ChannelEventHandler?>(() => _sendbird.getChannelEventHandler(identifier));
  }
}
