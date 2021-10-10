import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:sendbird_sdk/core/models/user.dart';
import 'package:sendbird_sdk/core/message/base_message.dart';

extension Message on BaseMessage {
  bool isMyMessage({required User? currentUser}) => sender?.userId == currentUser?.userId;
}

extension NumberUtils on num? {
  String get readableUnreadCount => this! < 1
      ? ''
      : this! <= 99
          ? '$this'
          : '99+';

  String readableTimestamp() {
    final formatter = new DateFormat.MMMd();
    final date = new DateTime.fromMillisecondsSinceEpoch(int.parse('${this}'));
    return formatter.format(date);
  }

  String readableOnlinePresence() {
    final date = new DateTime.fromMillisecondsSinceEpoch(int.parse('${this}')).toLocal();
    final now = DateTime.now().toLocal();
    final online = 'Online';
    final lastSeen = 'Last seen';

    if (now.month != date.month) {
      final formatter = DateFormat('MMM dd, yyyy');
      return lastSeen + ' on ' + formatter.format(date);
    } else if (now.day != date.day) {
      final diff = now.day - date.day;
      return lastSeen + ' $diff day' + ((diff > 1) ? 's' : '') + ' a go';
    } else if (now.hour != date.hour) {
      final diff = now.hour - date.hour;
      return lastSeen + ' $diff hour' + ((diff > 1) ? 's' : '') + ' a go';
    } else if (now.minute != date.minute) {
      final diff = now.minute - date.minute;
      return lastSeen + ' $diff minute' + ((diff > 1) ? 's' : '') + ' a go';
    } else if (now.second - date.second < 60) {
      return online;
    }
    return '';
  }

  String get readablePrice => this != null ? NumberFormat.simpleCurrency(
          locale: Platform.localeName, decimalDigits: 0).format(this) : 'null';
}

extension CustomListExtension<T> on List<T> {
  /// Moves the first occurrence of the [item] to the start of the list.
  void moveToTheFront(T item) {
    int pos = indexOf(item);
    if (pos != -1 && pos != 0) {
      removeAt(pos);
      insert(0, item);
    }
  }

  /// Moves the first occurrence of the [item] to the end of the list.
  void moveToTheEnd(T item) {
    int pos = indexOf(item);
    if (pos != -1 && pos != length - 1) {
      removeAt(pos);
      add(item);
    }
  }

  /// Removes all `null`s from the [List].
  void removeNulls() {
    removeWhere((element) => element == null);
  }
}

extension NavigatorExtension on Widget {
  // push
  Future<T?> go<T extends Object?>(
    BuildContext context, {
    bool rootNav = false,
  }) {
    return Navigator.of(context, rootNavigator: rootNav).push(
      CupertinoPageRoute(builder: (context) => this),
    );
  }

  // push replacement
  Future removeCurrentAndGo(
    BuildContext context, {
    bool rootNav = false,
  }) {
    return Navigator.of(context, rootNavigator: rootNav).pushReplacement(
      CupertinoPageRoute(builder: (context) => this),
    );
  }

  // pop
  void back<T extends Object?>(
    BuildContext context, {
    bool rootNav = false,
  }) {
    return Navigator.of(context, rootNavigator: rootNav).pop(context);
  }
}
