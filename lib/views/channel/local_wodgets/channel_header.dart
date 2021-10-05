import 'package:setoko_chat_package/core/constants/enums.dart';
import 'package:setoko_chat_package/core/viewmodels/chat/channel/channel_viewmodel.dart';
import 'package:setoko_chat_package/views/atoms/back_button_widget.dart';
import 'package:setoko_chat_package/views/atoms/more_options_wodget.dart';
import 'package:setoko_chat_package/views/atoms/store_profile_widget.dart';
import 'package:setoko_chat_package/views/components/app_bar_component.dart';
import 'package:setoko_chat_package/views/components/channel_store_name_wodget.dart';
import 'package:setoko_chat_package/views/styles/text_styles.dart';
import 'package:setoko_chat_package/views/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class ChannelHeader extends StatelessWidget {
  const ChannelHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _viewModel = context.watch<ChannelViewModel>();

    return Observer(
      builder: (context) {
        if (_viewModel.messages.isEmpty && _viewModel.loadChannelState != ChannelViewState.loaded) return const SizedBox.shrink();

        return AppBarComponent(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BackButtonWidget(onPressed: () => Navigator.pop(context)),
                  StoreProfileWidget(
                    width: 25,
                    height: 25,
                    channel: _viewModel.channel,
                    currentUserId: _viewModel.currentUser.userId,
                  ),
                  const SizedBox(width: 8.0),
                  _buildTitle(_viewModel, _viewModel.engagementState),
                ],
              ),
              MoreOptionsWidget(onPressed: () {}),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTitle(ChannelViewModel viewModel, UserEngagementState ue) {
    return Observer(
      builder: (context) {
        final size = MediaQuery.of(context).size;
        List<Widget> headers = [
          SizedBox(width: size.width * 0.6, child: ChannelStoreNameWidget(viewModel.channel, viewModel.currentUser.userId)),
        ];

        switch (ue) {
          case UserEngagementState.typing:
            headers.addAll(
              [
                const SizedBox(height: 5),
                CTTextWidget(
                  text: viewModel.typersText,
                  textStyle: ChatTextStyles.textStyle26,
                )
              ],
            );
            break;
          default:
            headers.addAll(
              [
                const SizedBox(height: 5),
                CTTextWidget(
                  text: viewModel.lastSeenText ?? '',
                  textStyle: ChatTextStyles.textStyle26,
                )
              ],
            );
            break;
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: headers,
        );
      },
    );
  }
}
