import 'package:setoko_chat_package/core/constants/enums.dart';
import 'package:setoko_chat_package/core/extensions/extensions.dart';
import 'package:setoko_chat_package/views/channel/local_wodgets/admin_message_item.dart';
import 'package:setoko_chat_package/views/channel/local_wodgets/file_message_item.dart';
import 'package:setoko_chat_package/views/channel/local_wodgets/user_message_item.dart';
import 'package:setoko_chat_package/views/components/error_component.dart';
import 'package:setoko_chat_package/views/components/initial_component.dart';
import 'package:setoko_chat_package/views/components/loading_component.dart';
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

    return Expanded(
      child: Container(
        color: ChatColors.calmWhite,
        child: Observer(
          builder: (context) {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              transitionBuilder: (child, animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: _viewModel.state == ChannelViewState.initial
                  ? InitialComponent()
                  : _viewModel.state == ChannelViewState.loading && _viewModel.messages.isEmpty
                      ? LoadingComponent()
                      : _viewModel.state == ChannelViewState.error
                          ? ErrorComponent(onPressed: () => _viewModel.loadMessages(reload: true))
                          : _buildView(_viewModel),
            );
          },
        ),
      ),
    );
  }

  Widget _buildView(ChannelViewModel viewModel) {
    return Observer(
      builder: (context) {
        return ListView.builder(
          controller: viewModel.lstController,
          itemCount: viewModel.itemCount,
          reverse: true,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: EdgeInsets.only(top: 10, bottom: 10),
          itemBuilder: (context, index) {
            if (index == viewModel.messages.length && viewModel.hasNext) {
              return Center(
                child: Container(
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator(),
                ),
              );
            }

            final message = viewModel.messages[index];
            final prev = (index < viewModel.messages.length - 1) ? viewModel.messages[index + 1] : null;
            final next = index == 0 ? null : viewModel.messages[index - 1];

            if (message is FileMessage) {
              return Observer(
                builder: (context) {
                  return FileMessageItem(
                    curr: viewModel.messages[index] as FileMessage,
                    prev: prev,
                    next: next,
                    model: viewModel,
                    isMyMessage: message.isMyMessage(currentUser: viewModel.currentUser),
                    onPress: (pos) {
                      //
                    },
                    onLongPress: (pos) {
                      viewModel.showMessageMenu(
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
                  curr: viewModel.messages[index] as AdminMessage,
                  model: viewModel,
                ),
              );
            } else if (message is UserMessage) {
              return Observer(
                builder: (context) {
                  return UserMessageItem(
                    curr: viewModel.messages[index] as UserMessage,
                    prev: prev,
                    next: next,
                    model: viewModel,
                    isMyMessage: message.isMyMessage(currentUser: viewModel.currentUser),
                    onPress: (pos) {
                      //
                    },
                    onLongPress: (pos) {
                      viewModel.showMessageMenu(
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
        );
      },
    );
  }
}
