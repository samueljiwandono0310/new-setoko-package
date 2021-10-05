import 'package:setoko_chat_package/core/services/sendbird/sendbird_handler_service.dart';
import 'package:setoko_chat_package/core/services/sendbird/sendbird_user_service.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';

part 'channel_create_viewmodel.g.dart';

class CreateChannelViewModel = _CreateChannelViewModel with _$CreateChannelViewModel;

abstract class _CreateChannelViewModel with Store {
  final query = ApplicationUserListQuery();
  static final _sbUserService = SendBirdUserService();
  static final _sbHandlerService = SendBirdHandlerService();
  final ScrollController lstController = ScrollController();
  final currentUser = _sbUserService.currentUser;

  @observable
  List<UserSelection> selections = [];

  @computed
  int get itemCount => query.hasNext && selections.length != 0 ? selections.length + 1 : selections.length;

  @computed
  bool get hasNext => query.hasNext;

  @computed
  List<UserSelection> get selectedUsers => selections.where((s) => s.isSelected).toList();

  void initState() {
    lstController.addListener(_scrollListener);
    updateUsers();
  }

  void dispose() {
    lstController.removeListener(_scrollListener);
  }

  @action
  void setSelection(UserSelection value) {
    final index = selections.indexOf(value);
    selections[index].isSelected = !selections[index].isSelected;
    selections = [...selections];
  }

  @action
  Future<void> updateUsers() async {
    List<UserSelection> newSelections = await getUsers();
    if (newSelections == this.selections) {
      return null;
    }

    selections = selections.isEmpty ? newSelections : selections + newSelections;
  }

  @action
  Future<List<UserSelection>> getUsers() async {
    try {
      List<User> users = await query.loadNext();
      return UserSelection.selectedUsersFrom(users);
    } catch (e) {
      print('create_channel_view: getUsers: ERROR: $e');
      return [];
    }
  }

  @action
  Future<GroupChannel> createChannel() async {
    try {
      final userIds = this.selections.where((selection) => selection.isSelected).map((selection) {
        return selection.user.userId;
      }).toList();
      final operatorUserIds =
          this.selections.where((selection) => selection.isSelected && selection.user.userId == currentUser?.userId).map((selection) {
        return selection.user.userId;
      }).toList();

      final newChannel = _sbHandlerService.createChannel(
        userIds: userIds,
        operatorUserIds: operatorUserIds,
      );
      return newChannel;
    } catch (e) {
      rethrow;
    }
  }

  _scrollListener() {
    if (lstController.offset >= lstController.position.maxScrollExtent && !lstController.position.outOfRange && !query.loading) {
      updateUsers();
    }
  }
}

class UserSelection {
  bool isSelected = false;
  User user;
  UserSelection(this.user);

  @override
  String toString() {
    return "UserSelection: {isSelected: $isSelected, user: $user}";
  }

  static List<UserSelection> selectedUsersFrom(List<User> users) {
    List<UserSelection> result = [];
    users.forEach((user) {
      result.add(new UserSelection(user));
    });

    return result;
  }
}
