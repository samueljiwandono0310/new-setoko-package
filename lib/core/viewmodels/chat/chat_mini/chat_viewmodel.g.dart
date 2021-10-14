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

  final _$isLoginAtom = Atom(name: '_ChatViewModel.isLogin');

  @override
  bool get isLogin {
    _$isLoginAtom.reportRead();
    return super.isLogin;
  }

  @override
  set isLogin(bool value) {
    _$isLoginAtom.reportWrite(value, super.isLogin, () {
      super.isLogin = value;
    });
  }

  final _$loginPathStateAtom = Atom(name: '_ChatViewModel.loginPathState');

  @override
  bool get loginPathState {
    _$loginPathStateAtom.reportRead();
    return super.loginPathState;
  }

  @override
  set loginPathState(bool value) {
    _$loginPathStateAtom.reportWrite(value, super.loginPathState, () {
      super.loginPathState = value;
    });
  }

  final _$registerPathStateAtom =
      Atom(name: '_ChatViewModel.registerPathState');

  @override
  bool get registerPathState {
    _$registerPathStateAtom.reportRead();
    return super.registerPathState;
  }

  @override
  set registerPathState(bool value) {
    _$registerPathStateAtom.reportWrite(value, super.registerPathState, () {
      super.registerPathState = value;
    });
  }

  final _$initStateAsyncAction = AsyncAction('_ChatViewModel.initState');

  @override
  Future<void> initState(
      {required ChatArgument chatArgument,
      required ChatUserArgument chatUserArgument}) {
    return _$initStateAsyncAction.run(() => super.initState(
        chatArgument: chatArgument, chatUserArgument: chatUserArgument));
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
  void goToChat(BuildContext context) {
    final _$actionInfo = _$_ChatViewModelActionController.startAction(
        name: '_ChatViewModel.goToChat');
    try {
      return super.goToChat(context);
    } finally {
      _$_ChatViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLogin: ${isLogin},
loginPathState: ${loginPathState},
registerPathState: ${registerPathState},
totalUnreadCount: ${totalUnreadCount}
    ''';
  }
}
