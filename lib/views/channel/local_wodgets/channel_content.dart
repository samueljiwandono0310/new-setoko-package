import 'package:setoko_chat_package/core/extensions/extensions.dart';
import 'package:setoko_chat_package/views/channel/local_wodgets/admin_message_item.dart';
import 'package:setoko_chat_package/views/channel/local_wodgets/file_message_item.dart';
import 'package:setoko_chat_package/views/channel/local_wodgets/user_message_item.dart';
import 'package:setoko_chat_package/views/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:setoko_chat_package/core/viewmodels/chat/channel/channel_viewmodel.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';

class ChannelContent extends StatelessWidget {
  const ChannelContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _viewModel = context.watch<ChannelViewModel>();

    return Observer(
      builder: (context) {
        return Expanded(
          child: Container(
            color: ChatColors.calmWhite,
            child: ListView.builder(
              controller: _viewModel.lstController,
              itemCount: _viewModel.itemCount,
              reverse: true,
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: EdgeInsets.only(top: 10, bottom: 10),
              itemBuilder: (context, index) {
                if (index == _viewModel.messages.length && _viewModel.hasNext) {
                  return Center(
                    child: Container(
                      width: 30,
                      height: 30,
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                final message = _viewModel.messages[index];
                final prev = (index < _viewModel.messages.length - 1) ? _viewModel.messages[index + 1] : null;
                final next = index == 0 ? null : _viewModel.messages[index - 1];

                if (message is FileMessage) {
                  return Observer(
                    builder: (context) {
                      return FileMessageItem(
                        curr: _viewModel.messages[index] as FileMessage,
                        prev: prev,
                        next: next,
                        model: _viewModel,
                        isMyMessage: message.isMyMessage(currentUser: _viewModel.currentUser),
                        onPress: (pos) {
                          //
                        },
                        onLongPress: (pos) {
                          _viewModel.showMessageMenu(
                            context: context,
                            message: message,
                            pos: pos,
                          );
                        },
                      );
                    },
                  );
                } else if (message is AdminMessage) {
                  return Observer(
                    builder: (context) => AdminMessageItem(
                      curr: _viewModel.messages[index] as AdminMessage,
                      model: _viewModel,
                    ),
                  );
                } else if (message is UserMessage) {
                  return Observer(
                    builder: (context) {
                      return UserMessageItem(
                        curr: _viewModel.messages[index] as UserMessage,
                        prev: prev,
                        next: next,
                        model: _viewModel,
                        isMyMessage: message.isMyMessage(currentUser: _viewModel.currentUser),
                        onPress: (pos) {
                          //
                        },
                        onLongPress: (pos) {
                          _viewModel.showMessageMenu(
                            context: context,
                            message: message,
                            pos: pos,
                          );
                        },
                      );
                    },
                  );
                } else {
                  // undefined message type
                  return Container();
                }
              },
            ),
          ),
        );
      },
    );
  }
}
