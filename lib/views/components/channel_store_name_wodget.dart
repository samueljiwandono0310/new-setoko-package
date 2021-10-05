import 'package:setoko_chat_package/views/styles/text_styles.dart';
import 'package:setoko_chat_package/views/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:sendbird_sdk/core/channel/group/group_channel.dart';

class ChannelStoreNameWidget extends StatelessWidget {
  final GroupChannel channel;
  final String? currentUserId;

  const ChannelStoreNameWidget(
    this.channel,
    this.currentUserId,
  );

  @override
  Widget build(BuildContext context) {
    String titleText;
    if (channel.name == '' || channel.name == 'Group Channel') {
      List<String> namesList = [
        for (final member in channel.members)
          if (member.userId != currentUserId) member.nickname
      ];
      titleText = namesList.join(", ");
    } else {
      titleText = channel.name ?? 'Channel';
    }

    return CTTextWidget(
      maxLines: 1,
      text: titleText,
      textStyle: ChatTextStyles.textStyle3,
    );
  }
}
