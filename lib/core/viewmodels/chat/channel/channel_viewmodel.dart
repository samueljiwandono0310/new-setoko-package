import 'dart:io';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'package:setoko_chat_package/core/utils/assets_path.dart';
import 'package:setoko_chat_package/core/utils/function_utils.dart';
import 'package:setoko_chat_package/views/styles/colors.dart';
import 'package:setoko_chat_package/views/styles/text_styles.dart';
import 'package:setoko_chat_package/views/widgets/svg_widget.dart';
import 'package:setoko_chat_package/views/widgets/text_widget.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';
import 'package:setoko_chat_package/core/constants/enums.dart';
import 'package:setoko_chat_package/core/constants/constan.dart';
import 'package:setoko_chat_package/core/extensions/extensions.dart';
import 'package:setoko_chat_package/core/services/sendbird/sendbird_user_service.dart';
import 'package:setoko_chat_package/core/services/sendbird/sendbird_handler_service.dart';

part 'channel_viewmodel.g.dart';

class ChannelViewModel = _ChannelViewModel with _$ChannelViewModel;

abstract class _ChannelViewModel with Store, ChannelEventHandler {
  static final _funtionUtils = FunctionUtils();
  static final _sbUserService = SendBirdUserService();
  static final _sbHandlerService = SendBirdHandlerService();

  late String channelUrl;

  User currentUser = _sbUserService.currentUser!;
  final ScrollController lstController = ScrollController();
  Timer? _typingTimer;

  @observable
  List<BaseMessage> messages = [];

  @observable
  GroupChannel? _channel;

  @observable
  BaseMessage? selectedMessage;

  @observable
  bool hasNext = false;

  @observable
  bool isShowMediaOption = false;

  @observable
  UserEngagementState _userEngagementState = UserEngagementState.none;

  @observable
  ObservableFuture<List<BaseMessage>> _getMessageFuture = ObservableFuture<List<BaseMessage>>.value([]);

  @observable
  ObservableFuture<GroupChannel>? _getChannelFuture;

  @computed
  ChannelViewState get state =>
      messages.isEmpty && _getMessageFuture.status != FutureStatus.pending && _getMessageFuture.status != FutureStatus.rejected
          ? ChannelViewState.initial
          : _getMessageFuture.status == FutureStatus.pending
              ? ChannelViewState.loading
              : _getMessageFuture.status == FutureStatus.fulfilled
                  ? ChannelViewState.loaded
                  : ChannelViewState.error;

  @computed
  ChannelViewState get loadChannelState => _channel == null
      ? ChannelViewState.initial
      : _getChannelFuture?.status == FutureStatus.pending
          ? ChannelViewState.loading
          : _getChannelFuture?.status == FutureStatus.fulfilled
              ? ChannelViewState.loaded
              : ChannelViewState.error;

  @computed
  GroupChannel get channel => _channel!;

  @computed
  int get itemCount => hasNext ? messages.length + 1 : messages.length;

  @computed
  bool get displayOnline => channel.members.length == 2;

  @computed
  UserEngagementState get engagementState => _userEngagementState;

  @computed
  String get typersText {
    final users = channel.getTypingUsers();
    if (users.length == 1)
      return '${users.first.nickname} is typing...';
    else if (users.length == 2)
      return '${users.first.nickname} and ${users.last.nickname} is typing...';
    else if (users.length > 2) return '${users.first.nickname} and ${users.length - 1} more are typing...';
    return '';
  }

  @computed
  String? get lastSeenText {
    if (channel.memberCount != 2) return null;
    final other = channel.members.where((e) => e.userId != currentUser.userId).first;
    final readStatus = channel.getReadStatus(false);
    final receipt = readStatus[other.userId] ?? {};
    return (receipt['last_seen_at'] as int).readableOnlinePresence();
  }

  void initState(String channelUrl) {
    this.channelUrl = channelUrl;
    _sbHandlerService.addChannelEventHandler(CHANNEL_HANDLER_KEY, this);
    lstController.addListener(_scrollListener);
    _loadChannel().then((value) => loadMessages());
  }

  void dispose() {
    _sbHandlerService.removeChannelEventHandler(CHANNEL_HANDLER_KEY);
    channel.endTyping();
  }

  @action
  Future<void> _loadChannel() async {
    _getChannelFuture = ObservableFuture<GroupChannel>(_sbHandlerService.getChannel(channelUrl));
    final res = await _getChannelFuture;
    _channel = res;
    channel.markAsRead();
  }

  @action
  Future<void> loadMessages({
    int? timestamp,
    bool reload = false,
  }) async {
    if (state == ChannelViewState.loading) {
      return;
    }

    final _timeStamp = reload ? DateTime.now().millisecondsSinceEpoch : timestamp ?? DateTime.now().millisecondsSinceEpoch;

    try {
      final params = MessageListParams()
        ..isInclusive = false
        ..includeThreadInfo = true
        ..reverse = true
        ..previousResultSize = 20;

      _getMessageFuture = ObservableFuture<List<BaseMessage>>(channel.getMessagesByTimestamp(_timeStamp, params));
      final res = await _getMessageFuture;

      messages = reload ? res : messages + res;
      hasNext = res.length == 20;
    } catch (e) {
      print('group_channel_view.dart: getMessages: ERROR: $e');
    }
  }

  @action
  void showMediaMessage(bool value) {
    isShowMediaOption = value;
  }

  @action
  Future onSendUserMessage(String message) async {
    if (message == '') {
      return;
    }

    final preMessage = channel.sendUserMessageWithText(message.trim(), onCompleted: (msg, error) {
      final index = messages.indexWhere((element) => element.requestId == msg.requestId);
      if (index != -1) messages.removeAt(index);
      messages = [msg, ...messages];
      messages.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      markAsReadDebounce();
    });

    messages = [preMessage, ...messages];

    lstController.animateTo(
      0.0,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @action
  Future onSendFileMessage(File file) async {
    final params = FileMessageParams.withFile(file);
    final preMessage = channel.sendFileMessage(params, onCompleted: (msg, error) {
      final index = messages.indexWhere((element) => element.requestId == msg.requestId);
      if (index != -1) messages.removeAt(index);
      messages = [msg, ...messages];
      messages.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      markAsReadDebounce();
    });

    messages = [preMessage, ...messages];

    lstController.animateTo(
      0.0,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @action
  void onTyping(bool hasText) {
    if (!hasText) {
      channel.endTyping();
    } else {
      channel.startTyping();
      _typingTimer?.cancel();
      _typingTimer = Timer(Duration(milliseconds: 3000), () {
        channel.endTyping();
      });
    }
  }

  void onCopyText(String text) {
    Clipboard.setData(new ClipboardData(text: text));
  }

  MessageState getMessageState(BaseMessage message) {
    if (message.sendingStatus != MessageSendingStatus.succeeded) return MessageState.none;

    final readAll = channel.getUnreadMembers(message).length == 0;
    final deliverAll = channel.getUndeliveredMembers(message).length == 0;

    if (readAll)
      return MessageState.read;
    else if (deliverAll)
      return MessageState.delivered;
    else
      return MessageState.none;
  }

  _scrollListener() {
    if (lstController.offset >= lstController.position.maxScrollExtent && !lstController.position.outOfRange && state != ChannelViewState.loading) {
      final offset = lstController.offset;

      loadMessages(
        timestamp: messages.last.createdAt,
      );

      lstController.animateTo(
        offset,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    }
  }

  // handlers

  @action
  void markAsReadDebounce() {
    this.channel.markAsRead();
  }

  @action
  @override
  void onMessageReceived(BaseChannel channel, BaseMessage message) {
    if (channel.channelUrl != this.channel.channelUrl) return;
    final index = messages.indexWhere((e) => e.messageId == message.messageId);
    if (index != -1 && messages.length != 0) {
      messages[index] = message;
    } else {
      messages.insert(0, message);
    }

    markAsReadDebounce();
    messages = [...messages];
  }

  @action
  @override
  void onMessageUpdated(BaseChannel channel, BaseMessage message) {
    if (channel.channelUrl != this.channel.channelUrl) return;
    final index = messages.indexWhere((e) => e.messageId == message.messageId);
    if (index != -1 && messages.length != 0) {
      messages[index] = message;
    } else {
      messages.insert(0, message);
    }

    messages = [...messages];
  }

  @action
  @override
  void onReadReceiptUpdated(GroupChannel channel) {
    messages = [...messages];
  }

  @action
  @override
  void onDeliveryReceiptUpdated(GroupChannel channel) {
    messages = [...messages];
  }

  @action
  @override
  void onTypingStatusUpdated(GroupChannel channel) {
    if (channel.channelUrl == this.channel.channelUrl) {
      final users = channel.getTypingUsers();
      if (users.length > 0)
        _userEngagementState = UserEngagementState.typing;
      else
        _userEngagementState = UserEngagementState.none;

      print(channel.lastMessage?.sender?.connectionStatus);
    }
  }

  // ui helper

  @action
  Future showMessageMenu({
    required BuildContext context,
    required BaseMessage message,
    required Offset pos,
  }) async {
    List<PopupMenuEntry> items = [];
    if (message is UserMessage) {
      items.add(_buildPopupItem(
        'Copy',
        AssetPath.svgsPath + 'chat.svg',
        PopupMenuType.copy,
      ));
    }

    if (items.isEmpty) return;

    selectedMessage = message;

    double x = pos.dx, y = pos.dy;
    final height = MediaQuery.of(context).size.height;
    if (height - pos.dy <= height / 3) y = pos.dy - 140;

    final selected = await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(x, y, pos.dx + 1, pos.dy + 1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      items: items,
    );

    switch (selected) {
      case PopupMenuType.copy:
        onCopyText(message.message);
        selectedMessage = null;
        break;

      default:
        selectedMessage = null;
        break;
    }
  }

  @action
  PopupMenuEntry _buildPopupItem(String text, String imageName, PopupMenuType value) {
    return PopupMenuItem(
      height: 40,
      child: Container(
        constraints: BoxConstraints(minWidth: 180),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CTTextWidget(
              text: text,
              textStyle: ChatTextStyles.textStyle10,
            ),
            const SizedBox(width: 8),
            SvgWidget(
              iconData: imageName,
              color: ChatColors.greenMedium,
            ),
          ],
        ),
      ),
      value: value,
    );
  }

  void showPicker(ImageSource source) async {
    final files = await _funtionUtils.showPicker(source);
    if (files != null) {
      for (var file in files) {
        onSendFileMessage(File(file.path));
      }
    }
    showMediaMessage(false);
  }
}
