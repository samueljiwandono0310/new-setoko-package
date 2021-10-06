import 'package:setoko_chat_package/core/constants/enums.dart';
import 'package:setoko_chat_package/views/atoms/separator_line_widget.dart';
import 'package:setoko_chat_package/views/components/error_component.dart';
import 'package:setoko_chat_package/views/components/initial_component.dart';
import 'package:setoko_chat_package/views/components/loading_component.dart';
import 'package:setoko_chat_package/views/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:setoko_chat_package/views/channel_list/local_widgets/channel_list_item.dart';
import 'package:setoko_chat_package/core/viewmodels/chat/channel_list/channel_list_viewmodel.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class ChannelList extends StatelessWidget {
  const ChannelList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _viewModel = context.watch<ChannelListViewModel>();

    return Observer(
      builder: (context) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          transitionBuilder: (child, animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: _viewModel.state == ChannelViewState.initial
              ? InitialComponent()
              : _viewModel.state == ChannelViewState.loading && _viewModel.channels.isEmpty
                  ? LoadingComponent()
                  : _viewModel.state == ChannelViewState.error
                      ? ErrorComponent(onPressed: () => _viewModel.loadChannelList(reload: true))
                      : _buildView(_viewModel),
        );
      },
    );
  }

  Widget _buildView(ChannelListViewModel viewModel) {
    return Observer(
      builder: (context) {
        return RefreshIndicator(
          onRefresh: () async {
            await viewModel.loadChannelList(reload: true);
          },
          child: ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: viewModel.scrollController,
            itemCount: viewModel.itemCount,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            separatorBuilder: (context, index) {
              return SeparatorLineWidget(
                height: 1,
                color: ChatColors.grayLight,
                margin: const EdgeInsets.symmetric(horizontal: 20),
              );
            },
            itemBuilder: (context, index) {
              if (index == viewModel.channels.length && viewModel.hasNext) {
                return Container(
                  color: Colors.white,
                  child: Center(
                    child: Container(
                      color: Colors.white,
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      width: 30,
                      height: 30,
                      child: CircularProgressIndicator(),
                    ),
                  ),
                );
              }

              return Observer(
                builder: (context) {
                  return InkWell(
                    child: ChannelListItem(viewModel.channels[index]),
                    onTap: () => viewModel.gotoChannel(context, viewModel.channels[index]),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
