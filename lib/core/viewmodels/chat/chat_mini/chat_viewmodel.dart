import 'dart:async';
import 'package:setoko_chat_package/core/modules/chat/chat_module.dart';
import 'package:setoko_chat_package/views/channel_list/channel_list_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:setoko_chat_package/core/services/sendbird/sendbird_user_service.dart';

part 'chat_viewmodel.g.dart';

class ChatViewModel = _ChatViewModel with _$ChatViewModel;

abstract class _ChatViewModel with Store {
  static final _sendbird = ChatModule();
  static final _sbUserService = SendBirdUserService();

  StreamSubscription<int>? _messageListener;
  Timer? _periodic;

  @observable
  bool isDisposed = false;

  @observable
  bool isUserNotNull = false;

  @observable
  int _totalUnreadCount = 0;

  @computed
  int get totalUnreadCount => _totalUnreadCount;

  _ChatViewModel() {
    Timer(const Duration(milliseconds: 1000), () {
      isUserNotNull = _sbUserService.currentUser != null;
      _setupPeriodicTimerIfNoInternet();
      _getAndListenToMessage();
      _setupDisposer();
    });
  }

  @action
  void _setupDisposer() {
    when((_) => isDisposed, () {
      _messageListener?.cancel();
      _periodic?.cancel();
      isDisposed = false;
    });
  }

  void _setupDelayedInitialization() {
    when((_) => isUserNotNull, () {
      _getAndListenToMessage();
    });
  }

  @action
  void _setupPeriodicTimerIfNoInternet() {
    if (!isUserNotNull) {
      _setupDelayedInitialization();
      _periodic = Timer.periodic(
        const Duration(seconds: 1),
        (timer) {
          isUserNotNull = _sbUserService.currentUser != null;
          if (isUserNotNull) {
            timer.cancel();
            _periodic?.cancel();
            _periodic = null;
          }
        },
      );
    }
  }

  @action
  Future _getAndListenToMessage() async {
    if (!isUserNotNull) return;
    await _sbUserService.getTotalUnreadMessageCount().then((value) => _totalUnreadCount = value);
    _messageListener = _sbUserService.totalUnreadMessageCountStream?.listen(
      (event) => _totalUnreadCount = event,
    );
  }

  @action
  void goToChat(BuildContext context, String userId) {
    if (!isUserNotNull) {
      _sendbird.connect(userId).then(
        (_) {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => ChannelListView(),
            ),
          );
        },
      );
    } else {
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => ChannelListView(),
        ),
      );
    }
  }
}
