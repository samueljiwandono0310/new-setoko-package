import 'package:sendbird_sdk/sendbird_sdk.dart';
import 'package:setoko_chat_package/core/services/sendbird/sb.dart';

class SendBirdUserService {
  SendBirdUserService._constructor();

  static final SendBirdUserService _instance = SendBirdUserService._constructor();

  factory SendBirdUserService() {
    return _instance;
  }

  final _sendbird = SB.sendbird;

  // User related
  Future<User> blockUser(String userId) async {
    final _result = await SB.callback<Future<User>>(() => _sendbird.blockUser(userId));

    return _result;
  }

  Future<void> markAsRead({required List<String> channelUrls}) async {
    await SB.callback<Future<void>>(() => _sendbird.markAsRead(channelUrls: channelUrls));
  }

  Future<void> markAsReadAll() async {
    await SB.callback<Future<void>>(() => _sendbird.markAsReadAll());
  }

  Future<void> unblockUser(String userId) async {
    await SB.callback<Future<void>>(() => _sendbird.unblockUser(userId));
  }

  Future<void> updateCurrentUserInfo() async {
    await SB.callback<Future<void>>(() => _sendbird.updateCurrentUserInfo());
  }

  User? get currentUser => SB.callback<User?>(() => _sendbird.currentUser);

  Future<EmojiContainer> getAllEmojis() async {
    final _result = await SB.callback<Future<EmojiContainer>>(() => _sendbird.getAllEmojis());

    return _result;
  }

  int? getLastConnectedAt() {
    return SB.callback<int?>(() => _sendbird.getLastConnectedAt());
  }

  Future<int> getTotalUnreadMessageCount() async {
    final _result = await SB.callback<Future<int>>(() => _sendbird.getTotalUnreadMessageCount());

    return _result;
  }

  Stream<int>? get totalUnreadMessageCountStream {
    return SB.callback<Stream<int>?>(() => _sendbird.totalUnreadMessageCountStream);
  }
}
