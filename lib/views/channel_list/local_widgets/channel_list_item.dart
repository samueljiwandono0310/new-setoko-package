import 'package:setoko_chat_package/core/viewmodels/chat/channel_list/channel_list_viewmodel.dart';
import 'package:setoko_chat_package/views/atoms/circle_count_widget.dart';
import 'package:setoko_chat_package/views/atoms/message_status_widget.dart';
import 'package:setoko_chat_package/views/atoms/store_profile_widget.dart';
import 'package:setoko_chat_package/views/components/channel_store_name_wodget.dart';
import 'package:setoko_chat_package/views/styles/colors.dart';
import 'package:setoko_chat_package/views/styles/text_styles.dart';
import 'package:setoko_chat_package/views/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';
import 'package:setoko_chat_package/core/extensions/extensions.dart';

class ChannelListItem extends StatelessWidget {
  final GroupChannel channel;
  const ChannelListItem(this.channel);

  @override
  Widget build(BuildContext context) {
    final _viewModel = context.watch<ChannelListViewModel>();

    return Container(
      height: 88,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      color: channel.unreadMessageCount > 0 ? ChatColors.yellowLighter : ChatColors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          StoreProfileWidget(
            width: 45,
            height: 45,
            imageProfile: _viewModel.currentUser?.profileUrl,
          ),
          _buildContent(context, _viewModel),
          _buildTailing(context),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context, ChannelListViewModel viewModel) {
    BaseMessage? lastMessage = channel.lastMessage;
    String message;
    if (lastMessage is FileMessage) {
      message = lastMessage.name ?? '';
    } else {
      message = lastMessage?.message ?? '';
    }

    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ChannelStoreNameWidget(channel, viewModel.currentUser?.userId),
            const SizedBox(height: 8),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                MessageStatusWidget(
                  messageState: viewModel.getMessageState(channel, lastMessage),
                  isMyMessage: lastMessage?.sender?.userId == viewModel.currentUser?.userId,
                ),
                CTTextWidget(
                  text: message,
                  textStyle: ChatTextStyles.textStyle11,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTailing(BuildContext context) {
    int? lastDate = channel.lastMessage?.createdAt;
    String lastMessageDateString = lastDate?.readableTimestamp() ?? '';
    final count = channel.unreadMessageCount;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CTTextWidget(text: lastMessageDateString, textStyle: ChatTextStyles.textStyle7),
        const SizedBox(height: 10),
        if (channel.unreadMessageCount != 0) CircleCountWidget(count: count),
      ],
    );
  }
}
