import 'dart:async';
import 'package:setoko_chat_package/views/channel/channel_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter/material.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';
import 'package:setoko_chat_package/core/constants/enums.dart';
import 'package:setoko_chat_package/core/constants/constan.dart';
import 'package:setoko_chat_package/core/services/sendbird/sendbird_user_service.dart';
import 'package:setoko_chat_package/core/services/sendbird/sendbird_handler_service.dart';
import 'package:setoko_chat_package/core/extensions/extensions.dart';

part 'channel_list_viewmodel.g.dart';

class ChannelListViewModel = _ChannelListViewModel with _$ChannelListViewModel;

abstract class _ChannelListViewModel with Store, ChannelEventHandler {
  static final _sbUserService = SendBirdUserService();
  static final _sbChannelService = SendBirdHandlerService();

  final ScrollController _allListController = ScrollController();
  final ScrollController _unreadListController = ScrollController();
  User? currentUser = _sbUserService.currentUser;

  @observable
  GroupChannelListQuery query = GroupChannelListQuery()..limit = 10;

  @observable
  List<GroupChannel> _groupChannels = [];

  @observable
  List<GroupChannel> _unreadGroupChannels = [];

  @observable
  ObservableFuture<List<GroupChannel>> _loadChannelListFuture = ObservableFuture<List<GroupChannel>>.value([]);

  @observable
  ChannelListTabState channelListTabState = ChannelListTabState.all;

  @computed
  List<GroupChannel> get channels => channelListTabState == ChannelListTabState.all ? _groupChannels : _unreadGroupChannels;

  @computed
  ScrollController get scrollController => channelListTabState == ChannelListTabState.all ? _allListController : _unreadListController;

  @computed
  ChannelViewState get state =>
      channels.isEmpty && _loadChannelListFuture.status != FutureStatus.pending && _loadChannelListFuture.status != FutureStatus.rejected
          ? ChannelViewState.initial
          : _loadChannelListFuture.status == FutureStatus.pending
              ? ChannelViewState.loading
              : _loadChannelListFuture.status == FutureStatus.fulfilled
                  ? ChannelViewState.loaded
                  : ChannelViewState.error;

  @computed
  int get itemCount => query.hasNext ? channels.length + 1 : channels.length;

  @computed
  bool get hasNext => query.hasNext;

  @action
  Future<void> loadChannelList({
    bool reload = false,
  }) async {
    try {
      if (reload)
        query = GroupChannelListQuery()
          ..limit = 10
          ..memberStateFilter = MemberStateFilter.joined
          ..order = GroupChannelListOrder.latestLastMessage
          ..unreadChannelFilter = channelListTabState == ChannelListTabState.all ? UnreadChannelFilter.all : UnreadChannelFilter.unreadMessage;

      _loadChannelListFuture = ObservableFuture<List<GroupChannel>>(query.loadNext());

      final res = await _loadChannelListFuture;
      if (reload) {
        channels = res;
      } else {
        channels = [...channels] + res;
      }
    } catch (e) {
      print('channel_list_view: getGroupChannel: ERROR: $e');
    }
  }

  @action
  void updateTabState(int page) {
    switch (page) {
      case 0:
        channelListTabState = ChannelListTabState.all;
        break;
      case 1:
        channelListTabState = ChannelListTabState.unread;
        break;
    }
  }

  @override
  @action
  void onMessageReceived(BaseChannel channel, BaseMessage message) {
    if (channel is! GroupChannel) return;

    channels = [...channels];
    final index = channels.indexWhere((element) => element.channelUrl == channel.channelUrl);

    if (index != -1) {
      channels[index] = channel;
      channels.moveToTheFront(channel);
    } else {
      channels.insert(0, channel);
    }
  }

  @override
  @action
  void onReadReceiptUpdated(GroupChannel channel) {
    channels = [...channels];
  }

  @override
  @action
  void onDeliveryReceiptUpdated(GroupChannel channel) {
    channels = [...channels];
  }

  @override
  @action
  void onUserLeaved(GroupChannel channel, User user) {
    channels = [...channels];

    if (user.userId == currentUser?.userId) {
      final index = channels.indexWhere((element) => element.channelUrl == channel.channelUrl);
      if (index != -1) {
        channels.removeAt(index);
      }
    }
  }

  @override
  @action
  void onChannelChanged(BaseChannel channel) {
    if (channel is! GroupChannel) return;

    channels = [...channels];
    final index = channels.indexWhere((element) => element.channelUrl == channel.channelUrl);

    if (index != -1) {
      channels[index] = channel;
      channels.moveToTheFront(channel);
    } else {
      channels.insert(0, channel);
    }
  }

  @action
  void gotoChannel(BuildContext context, GroupChannel channel) {
    ChannelView(channelUrl: channel.channelUrl).go(context).whenComplete(() => channels = [...channels]);
  }

  @action
  void _setChannels(List<GroupChannel> values) {
    if (channelListTabState == ChannelListTabState.all) {
      _groupChannels = values;
    } else {
      _unreadGroupChannels = values;
    }
  }

  set channels(List<GroupChannel> values) => _setChannels(values);

  void initState() {
    _sbChannelService.addChannelEventHandler(CHANNEL_LIST_HANDLER_KEY, this);
    _allListController.addListener(_scrollListener);
    _unreadListController.addListener(_scrollListener);
    loadChannelList();
  }

  void dispose() {
    _sbChannelService.removeChannelEventHandler(CHANNEL_LIST_HANDLER_KEY);
    _allListController.removeListener(_scrollListener);
    _unreadListController.removeListener(_scrollListener);
  }

  MessageState getMessageState(GroupChannel channel, BaseMessage? message) {
    bool readAll = false;
    bool deliverAll = false;
    if (message?.sender?.userId != currentUser?.userId) return MessageState.none;

    if (message != null) {
      readAll = channel.getUnreadMembers(message).length == 0;
      deliverAll = channel.getUndeliveredMembers(message).length == 0;
    }

    if (readAll)
      return MessageState.read;
    else if (deliverAll)
      return MessageState.delivered;
    else
      return MessageState.none;
  }

  _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent && !scrollController.position.outOfRange && !query.loading && hasNext) {
      loadChannelList();
    }
  }
}
