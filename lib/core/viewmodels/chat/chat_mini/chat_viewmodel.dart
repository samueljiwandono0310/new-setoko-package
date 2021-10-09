import 'dart:async';
import 'package:setoko_chat_package/core/arguments/chat_argument.dart';
import 'package:setoko_chat_package/core/arguments/chat_user_argument.dart';
import 'package:setoko_chat_package/core/modules/chat/chat_module.dart';
import 'package:setoko_chat_package/views/channel_list/channel_list_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:setoko_chat_package/core/services/sendbird/sendbird_user_service.dart';
import 'package:setoko_chat_package/views/error/chat_error_view.dart';
import 'package:setoko_chat_package/core/extensions/logger_extension.dart';

part 'chat_viewmodel.g.dart';

class ChatViewModel = _ChatViewModel with _$ChatViewModel;

abstract class _ChatViewModel with Store {
  static final _chatModule = ChatModule();
  static final _sbUserService = SendBirdUserService();

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
  void goToChat(BuildContext context) {
    if (_chatModule.currentUser != null) {
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => ChannelListView(),
        ),
      );
    } else {
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => ChatErrorView(
            tryAgainAction: () async {
              if (isLogin) {
                try {
                  await connectToSendBird();
                  _getAndListenToMessage();
                  Navigator.pushReplacement(
                    context,
                    CupertinoPageRoute(builder: (context) => ChannelListView()),
                  );
                } catch (e) {
                  _chatModule.disconnect();
                  e.logger();
                }
              } else {
                await Future.delayed(const Duration(milliseconds: 500));
                'User is guest'.logger();
              }
            },
          ),
        ),
      );
    }
  }
}
