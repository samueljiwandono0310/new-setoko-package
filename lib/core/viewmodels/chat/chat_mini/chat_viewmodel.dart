import 'dart:async';
import 'package:sendbird_sdk/sendbird_sdk.dart';
import 'package:setoko_chat_package/core/arguments/chat_argument.dart';
import 'package:setoko_chat_package/core/arguments/chat_user_argument.dart';
import 'package:setoko_chat_package/core/models/merchant/merchant.dart';
import 'package:setoko_chat_package/core/models/product/product_detail.dart';
import 'package:setoko_chat_package/core/modules/chat/chat_module.dart';
import 'package:setoko_chat_package/core/services/sendbird/sendbird_channel_service.dart';
import 'package:setoko_chat_package/views/channel/channel_view.dart';
import 'package:setoko_chat_package/views/channel_list/channel_list_view.dart';
import 'package:flutter/material.dart' show BuildContext;
import 'package:mobx/mobx.dart';
import 'package:setoko_chat_package/core/services/sendbird/sendbird_user_service.dart';
import 'package:setoko_chat_package/views/error/chat_error_view.dart';
import 'package:setoko_chat_package/core/extensions/logger_extension.dart';
import 'package:setoko_chat_package/core/extensions/extensions.dart';

part 'chat_viewmodel.g.dart';

class ChatViewModel = _ChatViewModel with _$ChatViewModel;

abstract class _ChatViewModel with Store {
  static final _chatModule = ChatModule();
  static final _sbUserService = SendBirdUserService();
  static final _sbChannelService = SendBirdChannelService();

  StreamSubscription<int>? _messageListener;
  late ChatUserArgument _chatUserArgument;

  @observable
  int _totalUnreadCount = 0;

  @observable
  bool isLogin = false;

  @observable
  bool loginPathState = false;

  @observable
  bool registerPathState = false;

  @computed
  int get totalUnreadCount => _totalUnreadCount;

  Future<void> connectToSendBird() async {
    await _chatModule.connect(
      _chatUserArgument.userId,
      nickname: _chatUserArgument.nickname,
      accessToken: _chatUserArgument.accessToken,
    );
  }

  void _setupDelayedInitialization() {
    when((_) => loginPathState || registerPathState, () async {
      await connectToSendBird();
      _getAndListenToMessage();
    });
  }

  void dispose() {
    _messageListener?.cancel();
    _chatModule.disconnect();
  }

  @action
  Future<void> initState({
    required ChatArgument chatArgument,
    required ChatUserArgument chatUserArgument,
  }) async {
    this.isLogin = chatArgument.isLogin;
    this.loginPathState = chatArgument.loginPathState;
    this.registerPathState = chatArgument.registerPathState;
    this._chatUserArgument = chatUserArgument;

    try {
      if (chatArgument.isLogin) {
        await connectToSendBird();
        _getAndListenToMessage();
      } else {
        _setupDelayedInitialization();
      }
    } catch (e) {
      _chatModule.disconnect();
      e.logger();
    }
  }

  @action
  Future _getAndListenToMessage() async {
    await _sbUserService.getTotalUnreadMessageCount().then((value) => _totalUnreadCount = value);
    _messageListener = _sbUserService.totalUnreadMessageCountStream?.listen(
      (event) => _totalUnreadCount = event,
    );
  }

  @action
  void goToChat(BuildContext context, dynamic argument) {
    if (_chatModule.currentUser != null) {
      if (argument == null) {
        ChannelListView().go(context);
      } else if (argument is CTMerchant) {
        createChannelWithMerchanInfo(argument).then((channel) {
          ChannelView(channelUrl: channel.channelUrl).go(context);
        });
      } else {
        createChannelWithProductInfo(argument).then((channel) {
          ChannelView(channelUrl: channel.channelUrl, ctProductDetailData: argument).go(context);
        });
      }
    } else {
      ChatErrorView(
        tryAgainAction: () async {
          if (isLogin) {
            try {
              await connectToSendBird();
              if (argument == null) {
                _getAndListenToMessage();
                ChannelListView().removeCurrentAndGo(context);
              } else if (argument is CTMerchant) {
                createChannelWithMerchanInfo(argument).then((channel) {
                  ChannelView(channelUrl: channel.channelUrl).removeCurrentAndGo(context);
                });
              } else {
                createChannelWithProductInfo(argument).then((channel) {
                  ChannelView(channelUrl: channel.channelUrl, ctProductDetailData: argument).removeCurrentAndGo(context);
                });
              }
            } catch (e) {
              _chatModule.disconnect();
              e.logger();
            }
          } else {
            await Future.delayed(const Duration(milliseconds: 500));
            'User is guest'.logger();
          }
        },
      ).go(context);
    }
  }

  Future<GroupChannel> createChannelWithMerchanInfo(CTMerchant param) async {
    try {
      final newChannel = await _sbChannelService.createChannel(
        name: param.name,
        operatorUserIds: [],
        userIds: [
          _chatModule.currentUser!.userId,
          param.code!,
        ],
        fileInfo: FileInfo.fromUrl(
          url: param.profilePicture?.url,
          mimeType: param.profilePicture?.kind,
          name: param.profilePicture?.filename,
        ),
      );
      return newChannel;
    } catch (e) {
      rethrow;
    }
  }

  Future<GroupChannel> createChannelWithProductInfo(CTProductDetailData param) async {
    try {
      final newChannel = await _sbChannelService.createChannel(
        name: param.merchant?.name,
        operatorUserIds: [],
        userIds: [
          _chatModule.currentUser!.userId,
          param.merchant!.code!,
        ],
        fileInfo: FileInfo.fromUrl(
          url: param.merchant?.profilePicture?.url,
          mimeType: param.merchant?.profilePicture?.kind,
          name: param.merchant?.profilePicture?.filename,
        ),
      );
      return newChannel;
    } catch (e) {
      rethrow;
    }
  }
}
