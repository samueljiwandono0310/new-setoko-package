// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_list_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ChannelListViewModel on _ChannelListViewModel, Store {
  Computed<List<GroupChannel>>? _$channelsComputed;

  @override
  List<GroupChannel> get channels =>
      (_$channelsComputed ??= Computed<List<GroupChannel>>(() => super.channels,
              name: '_ChannelListViewModel.channels'))
          .value;
  Computed<ScrollController>? _$scrollControllerComputed;

  @override
  ScrollController get scrollController => (_$scrollControllerComputed ??=
          Computed<ScrollController>(() => super.scrollController,
              name: '_ChannelListViewModel.scrollController'))
      .value;
  Computed<ChannelViewState>? _$stateComputed;

  @override
  ChannelViewState get state =>
      (_$stateComputed ??= Computed<ChannelViewState>(() => super.state,
              name: '_ChannelListViewModel.state'))
          .value;
  Computed<int>? _$itemCountComputed;

  @override
  int get itemCount =>
      (_$itemCountComputed ??= Computed<int>(() => super.itemCount,
              name: '_ChannelListViewModel.itemCount'))
          .value;
  Computed<bool>? _$hasNextComputed;

  @override
  bool get hasNext => (_$hasNextComputed ??= Computed<bool>(() => super.hasNext,
          name: '_ChannelListViewModel.hasNext'))
      .value;

  final _$queryAtom = Atom(name: '_ChannelListViewModel.query');

  @override
  GroupChannelListQuery get query {
    _$queryAtom.reportRead();
    return super.query;
  }

  @override
  set query(GroupChannelListQuery value) {
    _$queryAtom.reportWrite(value, super.query, () {
      super.query = value;
    });
  }

  final _$_groupChannelsAtom =
      Atom(name: '_ChannelListViewModel._groupChannels');

  @override
  List<GroupChannel> get _groupChannels {
    _$_groupChannelsAtom.reportRead();
    return super._groupChannels;
  }

  @override
  set _groupChannels(List<GroupChannel> value) {
    _$_groupChannelsAtom.reportWrite(value, super._groupChannels, () {
      super._groupChannels = value;
    });
  }

  final _$_unreadGroupChannelsAtom =
      Atom(name: '_ChannelListViewModel._unreadGroupChannels');

  @override
  List<GroupChannel> get _unreadGroupChannels {
    _$_unreadGroupChannelsAtom.reportRead();
    return super._unreadGroupChannels;
  }

  @override
  set _unreadGroupChannels(List<GroupChannel> value) {
    _$_unreadGroupChannelsAtom.reportWrite(value, super._unreadGroupChannels,
        () {
      super._unreadGroupChannels = value;
    });
  }

  final _$_loadChannelListFutureAtom =
      Atom(name: '_ChannelListViewModel._loadChannelListFuture');

  @override
  ObservableFuture<List<GroupChannel>> get _loadChannelListFuture {
    _$_loadChannelListFutureAtom.reportRead();
    return super._loadChannelListFuture;
  }

  @override
  set _loadChannelListFuture(ObservableFuture<List<GroupChannel>> value) {
    _$_loadChannelListFutureAtom
        .reportWrite(value, super._loadChannelListFuture, () {
      super._loadChannelListFuture = value;
    });
  }

  final _$channelListTabStateAtom =
      Atom(name: '_ChannelListViewModel.channelListTabState');

  @override
  ChannelListTabState get channelListTabState {
    _$channelListTabStateAtom.reportRead();
    return super.channelListTabState;
  }

  @override
  set channelListTabState(ChannelListTabState value) {
    _$channelListTabStateAtom.reportWrite(value, super.channelListTabState, () {
      super.channelListTabState = value;
    });
  }

  final _$loadChannelListAsyncAction =
      AsyncAction('_ChannelListViewModel.loadChannelList');

  @override
  Future<void> loadChannelList({bool reload = false}) {
    return _$loadChannelListAsyncAction
        .run(() => super.loadChannelList(reload: reload));
  }

  final _$_ChannelListViewModelActionController =
      ActionController(name: '_ChannelListViewModel');

  @override
  void updateTabState(int page) {
    final _$actionInfo = _$_ChannelListViewModelActionController.startAction(
        name: '_ChannelListViewModel.updateTabState');
    try {
      return super.updateTabState(page);
    } finally {
      _$_ChannelListViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onMessageReceived(BaseChannel channel, BaseMessage message) {
    final _$actionInfo = _$_ChannelListViewModelActionController.startAction(
        name: '_ChannelListViewModel.onMessageReceived');
    try {
      return super.onMessageReceived(channel, message);
    } finally {
      _$_ChannelListViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onReadReceiptUpdated(GroupChannel channel) {
    final _$actionInfo = _$_ChannelListViewModelActionController.startAction(
        name: '_ChannelListViewModel.onReadReceiptUpdated');
    try {
      return super.onReadReceiptUpdated(channel);
    } finally {
      _$_ChannelListViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onDeliveryReceiptUpdated(GroupChannel channel) {
    final _$actionInfo = _$_ChannelListViewModelActionController.startAction(
        name: '_ChannelListViewModel.onDeliveryReceiptUpdated');
    try {
      return super.onDeliveryReceiptUpdated(channel);
    } finally {
      _$_ChannelListViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onUserLeaved(GroupChannel channel, User user) {
    final _$actionInfo = _$_ChannelListViewModelActionController.startAction(
        name: '_ChannelListViewModel.onUserLeaved');
    try {
      return super.onUserLeaved(channel, user);
    } finally {
      _$_ChannelListViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onChannelChanged(BaseChannel channel) {
    final _$actionInfo = _$_ChannelListViewModelActionController.startAction(
        name: '_ChannelListViewModel.onChannelChanged');
    try {
      return super.onChannelChanged(channel);
    } finally {
      _$_ChannelListViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void gotoChannel(BuildContext context, GroupChannel channel) {
    final _$actionInfo = _$_ChannelListViewModelActionController.startAction(
        name: '_ChannelListViewModel.gotoChannel');
    try {
      return super.gotoChannel(context, channel);
    } finally {
      _$_ChannelListViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void gotoChannelCreate(BuildContext context) {
    final _$actionInfo = _$_ChannelListViewModelActionController.startAction(
        name: '_ChannelListViewModel.gotoChannelCreate');
    try {
      return super.gotoChannelCreate(context);
    } finally {
      _$_ChannelListViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _setChannels(List<GroupChannel> values) {
    final _$actionInfo = _$_ChannelListViewModelActionController.startAction(
        name: '_ChannelListViewModel._setChannels');
    try {
      return super._setChannels(values);
    } finally {
      _$_ChannelListViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
query: ${query},
channelListTabState: ${channelListTabState},
channels: ${channels},
scrollController: ${scrollController},
state: ${state},
itemCount: ${itemCount},
hasNext: ${hasNext}
    ''';
  }
}
