// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ChatViewModel on _ChatViewModel, Store {
  Computed<int>? _$totalUnreadCountComputed;

  @override
  int get totalUnreadCount => (_$totalUnreadCountComputed ??= Computed<int>(
          () => super.totalUnreadCount,
          name: '_ChatViewModel.totalUnreadCount'))
      .value;

  final _$isDisposedAtom = Atom(name: '_ChatViewModel.isDisposed');

  @override
  bool get isDisposed {
    _$isDisposedAtom.reportRead();
    return super.isDisposed;
  }

  @override
  set isDisposed(bool value) {
    _$isDisposedAtom.reportWrite(value, super.isDisposed, () {
      super.isDisposed = value;
    });
  }

  final _$isUserNotNullAtom = Atom(name: '_ChatViewModel.isUserNotNull');

  @override
  bool get isUserNotNull {
    _$isUserNotNullAtom.reportRead();
    return super.isUserNotNull;
  }

  @override
  set isUserNotNull(bool value) {
    _$isUserNotNullAtom.reportWrite(value, super.isUserNotNull, () {
      super.isUserNotNull = value;
    });
  }

  final _$_totalUnreadCountAtom =
      Atom(name: '_ChatViewModel._totalUnreadCount');

  @override
  int get _totalUnreadCount {
    _$_totalUnreadCountAtom.reportRead();
    return super._totalUnreadCount;
  }

  @override
  set _totalUnreadCount(int value) {
    _$_totalUnreadCountAtom.reportWrite(value, super._totalUnreadCount, () {
      super._totalUnreadCount = value;
    });
  }

  final _$_getAndListenToMessageAsyncAction =
      AsyncAction('_ChatViewModel._getAndListenToMessage');

  @override
  Future<dynamic> _getAndListenToMessage() {
    return _$_getAndListenToMessageAsyncAction
        .run(() => super._getAndListenToMessage());
  }

  final _$_ChatViewModelActionController =
      ActionController(name: '_ChatViewModel');

  @override
  void _setupDisposer() {
    final _$actionInfo = _$_ChatViewModelActionController.startAction(
        name: '_ChatViewModel._setupDisposer');
    try {
      return super._setupDisposer();
    } finally {
      _$_ChatViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _setupPeriodicTimerIfNoInternet() {
    final _$actionInfo = _$_ChatViewModelActionController.startAction(
        name: '_ChatViewModel._setupPeriodicTimerIfNoInternet');
    try {
      return super._setupPeriodicTimerIfNoInternet();
    } finally {
      _$_ChatViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  void goToChat(BuildContext context, String userId) {
    final _$actionInfo = _$_ChatViewModelActionController.startAction(
        name: '_ChatViewModel.goToChat');
    try {
      return super.goToChat(context, userId);
    } finally {
      _$_ChatViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isDisposed: ${isDisposed},
isUserNotNull: ${isUserNotNull},
totalUnreadCount: ${totalUnreadCount}
    ''';
  }
}
