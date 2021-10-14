import 'package:setoko_chat_package/core/viewmodels/chat/channel/channel_viewmodel.dart';
import 'package:setoko_chat_package/views/styles/colors.dart';
import 'package:setoko_chat_package/views/styles/text_styles.dart';
import 'package:setoko_chat_package/views/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';
import 'package:setoko_chat_package/views/channel/local_wodgets/message_item.dart';

class UserMessageItem extends MessageItem {
  UserMessageItem({
    required UserMessage curr,
    BaseMessage? prev,
    BaseMessage? next,
    required ChannelViewModel model,
    bool? isMyMessage,
    Function(Offset)? onPress,
    Function(Offset)? onLongPress,
  }) : super(
          curr: curr,
          prev: prev,
          next: next,
          model: model,
          isMyMessage: isMyMessage,
          onPress: onPress,
          onLongPress: onLongPress,
        );

  @override
  Widget get content => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: (isMyMessage ?? false) ? ChatColors.white : ChatColors.greenPrimary,
        ),
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        child: CTTextWidget(
          maxLines: null,
          text: curr.message,
          textStyle: (isMyMessage ?? false) ? ChatTextStyles.textStyle9 : ChatTextStyles.textStyle8,
        ),
      );
}
