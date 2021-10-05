// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_create_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CreateChannelViewModel on _CreateChannelViewModel, Store {
  Computed<int>? _$itemCountComputed;

  @override
  int get itemCount =>
      (_$itemCountComputed ??= Computed<int>(() => super.itemCount,
              name: '_CreateChannelViewModel.itemCount'))
          .value;
  Computed<bool>? _$hasNextComputed;

  @override
  bool get hasNext => (_$hasNextComputed ??= Computed<bool>(() => super.hasNext,
          name: '_CreateChannelViewModel.hasNext'))
      .value;
  Computed<List<UserSelection>>? _$selectedUsersComputed;

  @override
  List<UserSelection> get selectedUsers => (_$selectedUsersComputed ??=
          Computed<List<UserSelection>>(() => super.selectedUsers,
              name: '_CreateChannelViewModel.selectedUsers'))
      .value;

  final _$selectionsAtom = Atom(name: '_CreateChannelViewModel.selections');

  @override
  List<UserSelection> get selections {
    _$selectionsAtom.reportRead();
    return super.selections;
  }

  @override
  set selections(List<UserSelection> value) {
    _$selectionsAtom.reportWrite(value, super.selections, () {
      super.selections = value;
    });
  }

  final _$updateUsersAsyncAction =
      AsyncAction('_CreateChannelViewModel.updateUsers');

  @override
  Future<void> updateUsers() {
    return _$updateUsersAsyncAction.run(() => super.updateUsers());
  }

  final _$getUsersAsyncAction = AsyncAction('_CreateChannelViewModel.getUsers');

  @override
  Future<List<UserSelection>> getUsers() {
    return _$getUsersAsyncAction.run(() => super.getUsers());
  }

  final _$createChannelAsyncAction =
      AsyncAction('_CreateChannelViewModel.createChannel');

  @override
  Future<GroupChannel> createChannel() {
    return _$createChannelAsyncAction.run(() => super.createChannel());
  }

  final _$_CreateChannelViewModelActionController =
      ActionController(name: '_CreateChannelViewModel');

  @override
  void setSelection(UserSelection value) {
    final _$actionInfo = _$_CreateChannelViewModelActionController.startAction(
        name: '_CreateChannelViewModel.setSelection');
    try {
      return super.setSelection(value);
    } finally {
      _$_CreateChannelViewModelActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selections: ${selections},
itemCount: ${itemCount},
hasNext: ${hasNext},
selectedUsers: ${selectedUsers}
    ''';
  }
}
