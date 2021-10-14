import 'package:sendbird_sdk/sendbird_sdk.dart';
import 'package:setoko_chat_package/core/services/sendbird/sb.dart';

class SendBirdChannelService {
  SendBirdChannelService._constructor();

  static final SendBirdChannelService _instance = SendBirdChannelService._constructor();

  factory SendBirdChannelService() {
    return _instance;
  }

  // Channel related

  Future<GroupChannel> createChannel({
    String? name,
    String? channelUrl,
    FileInfo? fileInfo,
    required List<String> userIds,
    required List<String> operatorUserIds,
  }) async {
    final params = GroupChannelParams()
      ..name = name
      ..isDistinct = true
      ..coverImage = fileInfo
      ..channelUrl = channelUrl
      ..operatorUserIds = operatorUserIds
      ..userIds = [...userIds, ...operatorUserIds];
    final channel = await SB.callback<Future<GroupChannel>>(() => GroupChannel.createChannel(params));
    return channel;
  }

  Future<GroupChannel> getChannel(String channelUrl) async {
    final channel = await SB.callback<Future<GroupChannel>>(() => GroupChannel.getChannel(channelUrl));
    return channel;
  }
}
