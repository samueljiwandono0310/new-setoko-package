// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ChannelViewModel on _ChannelViewModel, Store {
  Computed<ChannelViewState>? _$stateComputed;

  @override
  ChannelViewState get state =>
      (_$stateComputed ??= Computed<ChannelViewState>(() => super.state,
              name: '_ChannelViewModel.state'))
          .value;
  Computed<ChannelViewState>? _$loadChannelStateComputed;

  @override
  ChannelViewState get loadChannelState => (_$loadChannelStateComputed ??=
          Computed<ChannelViewState>(() => super.loadChannelState,
              name: '_ChannelViewModel.loadChannelState'))
      .value;
  Computed<GroupChannel>? _$channelComputed;

  @override
  GroupChannel get channel =>
      (_$channelComputed ??= Computed<GroupChannel>(() => super.channel,
              name: '_ChannelViewModel.channel'))
          .value;
  Computed<int>? _$itemCountComputed;

  @override
  int get itemCount =>
      (_$itemCountComputed ??= Computed<int>(() => super.itemCount,
              name: '_ChannelViewModel.itemCount'))
          .value;
  Computed<bool>? _$displayOnlineComputed;

  @override
  bool get displayOnline =>
      (_$displayOnlineComputed ??= Computed<bool>(() => super.displayOnline,
              name: '_ChannelViewModel.displayOnline'))
          .value;
  Computed<UserEngagementState>? _$engagementStateComputed;

  @override
  UserEngagementState get engagementState => (_$engagementStateComputed ??=
          Computed<UserEngagementState>(() => super.engagementState,
              name: '_ChannelViewModel.engagementState'))
      .value;
  Computed<String>? _$typersTextComputed;

  @override
  String get typersText =>
      (_$typersTextComputed ??= Computed<String>(() => super.typersText,
              name: '_ChannelViewModel.typersText'))
          .value;
  Computed<String?>? _$lastSeenTextComputed;

  @override
  String? get lastSeenText =>
      (_$lastSeenTextComputed ??= Computed<String?>(() => super.lastSeenText,
              name: '_ChannelViewModel.lastSeenText'))
          .value;

  final _$productsAtom = Atom(name: '_ChannelViewModel.products');

  @override
  ObservableList<CTProductDetailData> get products {
    _$productsAtom.reportRead();
    return super.products;
  }

  @override
  set products(ObservableList<CTProductDetailData> value) {
    _$productsAtom.reportWrite(value, super.products, () {
      super.products = value;
    });
  }

  final _$messagesAtom = Atom(name: '_ChannelViewModel.messages');

  @override
  List<BaseMessage> get messages {
    _$messagesAtom.reportRead();
    return super.messages;
  }

  @override
  set messages(List<BaseMessage> value) {
    _$messagesAtom.reportWrite(value, super.messages, () {
      super.messages = value;
    });
  }

  final _$_channelAtom = Atom(name: '_ChannelViewModel._channel');

  @override
  GroupChannel? get _channel {
    _$_channelAtom.reportRead();
    return super._channel;
  }

  @override
  set _channel(GroupChannel? value) {
    _$_channelAtom.reportWrite(value, super._channel, () {
      super._channel = value;
    });
  }

  final _$selectedMessageAtom = Atom(name: '_ChannelViewModel.selectedMessage');

  @override
  BaseMessage? get selectedMessage {
    _$selectedMessageAtom.reportRead();
    return super.selectedMessage;
  }

  @override
  set selectedMessage(BaseMessage? value) {
    _$selectedMessageAtom.reportWrite(value, super.selectedMessage, () {
      super.selectedMessage = value;
    });
  }

  final _$hasNextAtom = Atom(name: '_ChannelViewModel.hasNext');

  @override
  bool get hasNext {
    _$hasNextAtom.reportRead();
    return super.hasNext;
  }

  @override
  set hasNext(bool value) {
    _$hasNextAtom.reportWrite(value, super.hasNext, () {
      super.hasNext = value;
    });
  }

  final _$isShowMediaOptionAtom =
      Atom(name: '_ChannelViewModel.isShowMediaOption');

  @override
  bool get isShowMediaOption {
    _$isShowMediaOptionAtom.reportRead();
    return super.isShowMediaOption;
  }

  @override
  set isShowMediaOption(bool value) {
    _$isShowMediaOptionAtom.reportWrite(value, super.isShowMediaOption, () {
      super.isShowMediaOption = value;
    });
  }

  final _$_userEngagementStateAtom =
      Atom(name: '_ChannelViewModel._userEngagementState');

  @override
  UserEngagementState get _userEngagementState {
    _$_userEngagementStateAtom.reportRead();
    return super._userEngagementState;
  }

  @override
  set _userEngagementState(UserEngagementState value) {
    _$_userEngagementStateAtom.reportWrite(value, super._userEngagementState,
        () {
      super._userEngagementState = value;
    });
  }

  final _$_getMessageFutureAtom =
      Atom(name: '_ChannelViewModel._getMessageFuture');

  @override
  ObservableFuture<List<BaseMessage>> get _getMessageFuture {
    _$_getMessageFutureAtom.reportRead();
    return super._getMessageFuture;
  }

  @override
  set _getMessageFuture(ObservableFuture<List<BaseMessage>> value) {
    _$_getMessageFutureAtom.reportWrite(value, super._getMessageFuture, () {
      super._getMessageFuture = value;
    });
  }

  final _$_getChannelFutureAtom =
      Atom(name: '_ChannelViewModel._getChannelFuture');

  @override
  ObservableFuture<GroupChannel>? get _getChannelFuture {
    _$_getChannelFutureAtom.reportRead();
    return super._getChannelFuture;
  }

  @override
  set _getChannelFuture(ObservableFuture<GroupChannel>? value) {
    _$_getChannelFutureAtom.reportWrite(value, super._getChannelFuture, () {
      super._getChannelFuture = value;
    });
  }

  final _$_loadChannelAsyncAction =
      AsyncAction('_ChannelViewModel._loadChannel');

  @override
  Future<void> _loadChannel() {
    return _$_loadChannelAsyncAction.run(() => super._loadChannel());
  }

  final _$loadMessagesAsyncAction =
      AsyncAction('_ChannelViewModel.loadMessages');

  @override
  Future<void> loadMessages({int? timestamp, bool reload = false}) {
    return _$loadMessagesAsyncAction
        .run(() => super.loadMessages(timestamp: timestamp, reload: reload));
  }

  final _$onSendUserMessageAsyncAction =
      AsyncAction('_ChannelViewModel.onSendUserMessage');

  @override
  Future<dynamic> onSendUserMessage(String message) {
    return _$onSendUserMessageAsyncAction
        .run(() => super.onSendUserMessage(message));
  }

  final _$onSendFileMessageAsyncAction =
      AsyncAction('_ChannelViewModel.onSendFileMessage');

  @override
  Future<dynamic> onSendFileMessage(File file) {
    return _$onSendFileMessageAsyncAction
        .run(() => super.onSendFileMessage(file));
  }

  final _$onSendProductMessageAsyncAction =
      AsyncAction('_ChannelViewModel.onSendProductMessage');

  @override
  Future<dynamic> onSendProductMessage(CTProductDetailData product) {
    return _$onSendProductMessageAsyncAction
        .run(() => super.onSendProductMessage(product));
  }

  final _$showMessageMenuAsyncAction =
      AsyncAction('_ChannelViewModel.showMessageMenu');

  @override
  Future<dynamic> showMessageMenu(
      {required BuildContext context,
      required BaseMessage message,
      required Offset pos}) {
    return _$showMessageMenuAsyncAction.run(() =>
        super.showMessageMenu(context: context, message: message, pos: pos));
  }

  final _$_ChannelViewModelActionController =
      ActionController(name: '_ChannelViewModel');

  @override
  void addProduct(CTProductDetailData? product) {
    final _$actionInfo = _$_ChannelViewModelActionController.startAction(
        name: '_ChannelViewModel.addProduct');
    try {
      return super.addProduct(product);
    } finally {
      _$_ChannelViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void deleteProduct(CTProductDetailData? product) {
    final _$actionInfo = _$_ChannelViewModelActionController.startAction(
        name: '_ChannelViewModel.deleteProduct');
    try {
      return super.deleteProduct(product);
    } finally {
      _$_ChannelViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void showMediaMessage(bool value) {
    final _$actionInfo = _$_ChannelViewModelActionController.startAction(
        name: '_ChannelViewModel.showMediaMessage');
    try {
      return super.showMediaMessage(value);
    } finally {
      _$_ChannelViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onTyping(bool hasText) {
    final _$actionInfo = _$_ChannelViewModelActionController.startAction(
        name: '_ChannelViewModel.onTyping');
    try {
      return super.onTyping(hasText);
    } finally {
      _$_ChannelViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void markAsReadDebounce() {
    final _$actionInfo = _$_ChannelViewModelActionController.startAction(
        name: '_ChannelViewModel.markAsReadDebounce');
    try {
      return super.markAsReadDebounce();
    } finally {
      _$_ChannelViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onMessageReceived(BaseChannel channel, BaseMessage message) {
    final _$actionInfo = _$_ChannelViewModelActionController.startAction(
        name: '_ChannelViewModel.onMessageReceived');
    try {
      return super.onMessageReceived(channel, message);
    } finally {
      _$_ChannelViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onMessageUpdated(BaseChannel channel, BaseMessage message) {
    final _$actionInfo = _$_ChannelViewModelActionController.startAction(
        name: '_ChannelViewModel.onMessageUpdated');
    try {
      return super.onMessageUpdated(channel, message);
    } finally {
      _$_ChannelViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onReadReceiptUpdated(GroupChannel channel) {
    final _$actionInfo = _$_ChannelViewModelActionController.startAction(
        name: '_ChannelViewModel.onReadReceiptUpdated');
    try {
      return super.onReadReceiptUpdated(channel);
    } finally {
      _$_ChannelViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onDeliveryReceiptUpdated(GroupChannel channel) {
    final _$actionInfo = _$_ChannelViewModelActionController.startAction(
        name: '_ChannelViewModel.onDeliveryReceiptUpdated');
    try {
      return super.onDeliveryReceiptUpdated(channel);
    } finally {
      _$_ChannelViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onTypingStatusUpdated(GroupChannel channel) {
    final _$actionInfo = _$_ChannelViewModelActionController.startAction(
        name: '_ChannelViewModel.onTypingStatusUpdated');
    try {
      return super.onTypingStatusUpdated(channel);
    } finally {
      _$_ChannelViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  PopupMenuEntry<dynamic> _buildPopupItem(
      String text, String imageName, PopupMenuType value) {
    final _$actionInfo = _$_ChannelViewModelActionController.startAction(
        name: '_ChannelViewModel._buildPopupItem');
    try {
      return super._buildPopupItem(text, imageName, value);
    } finally {
      _$_ChannelViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
products: ${products},
messages: ${messages},
selectedMessage: ${selectedMessage},
hasNext: ${hasNext},
isShowMediaOption: ${isShowMediaOption},
state: ${state},
loadChannelState: ${loadChannelState},
channel: ${channel},
itemCount: ${itemCount},
displayOnline: ${displayOnline},
engagementState: ${engagementState},
typersText: ${typersText},
lastSeenText: ${lastSeenText}
    ''';
  }
}
