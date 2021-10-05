import 'package:setoko_chat_package/core/viewmodels/chat/channel/channel_viewmodel.dart';
import 'package:setoko_chat_package/views/channel/local_wodgets/message_item.dart';
import 'package:setoko_chat_package/views/widgets/cacheable_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';

class FileMessageItem extends MessageItem {
  FileMessageItem({
    required FileMessage curr,
    BaseMessage? prev,
    BaseMessage? next,
    required ChannelViewModel model,
    required bool isMyMessage,
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
  Widget get content => ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: (curr as FileMessage).localFile != null
            ? Container(
                child: FittedBox(
                  child: Image.file((curr as FileMessage).localFile!),
                  fit: BoxFit.cover,
                ),
                height: 160,
                width: 240,
              )
            : CacheableImageWidget(
                height: 160,
                width: 240,
                imageUrl: (curr as FileMessage).secureUrl ?? (curr as FileMessage).url,
              ),
      );
}
