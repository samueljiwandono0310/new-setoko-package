import 'package:setoko_chat_package/core/constants/enums.dart';
import 'package:setoko_chat_package/core/utils/assets_path.dart';
import 'package:setoko_chat_package/views/widgets/svg_widget.dart';
import 'package:flutter/material.dart';

class MessageStatusWidget extends StatelessWidget {
  final bool isMyMessage;
  final MessageState messageState;
  const MessageStatusWidget({
    Key? key,
    required this.messageState,
    required this.isMyMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (messageState == MessageState.none && !isMyMessage) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.only(right: 5.87),
      child: SvgWidget(
        iconData: AssetPath.svgsPath + (messageState == MessageState.read ? 'chat_read.svg' : 'chat_delivered.svg'),
      ),
    );
  }
}
