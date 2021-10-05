import 'package:setoko_chat_package/core/viewmodels/chat/channel/channel_viewmodel.dart';
import 'package:setoko_chat_package/views/channel/local_wodgets/message_item.dart';
import 'package:setoko_chat_package/views/styles/text_styles.dart';
import 'package:setoko_chat_package/views/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';

class AdminMessageItem extends MessageItem {
  AdminMessageItem({
    required AdminMessage curr,
    required ChannelViewModel model,
  }) : super(curr: curr, model: model);

  @override
  Widget get content => Observer(
        builder: (context) {
          return Container(
            child: CTTextWidget(
              text: curr.message,
              textStyle: ChatTextStyles.textStyle10,
            ),
          );
        },
      );
}
