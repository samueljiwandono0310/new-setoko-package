import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:setoko_chat_package/core/utils/assets_path.dart';
import 'package:setoko_chat_package/views/widgets/svg_widget.dart';
import 'package:setoko_chat_package/views/atoms/circle_count_widget.dart';
import 'package:setoko_chat_package/core/viewmodels/chat/chat_mini/chat_viewmodel.dart';

class ChatView extends StatelessWidget {
  final String userId;
  ChatView({Key? key, required this.userId}) : super(key: key);

  final viewModel = ChatViewModel();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        viewModel.isDisposed = true;
        return true;
      },
      child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: () => viewModel.goToChat(context, userId),
        icon: Container(
          width: 42,
          height: 42,
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Center(
                child: SvgWidget(
                  iconData: AssetPath.svgsPath + 'chat.svg',
                ),
              ),
              Observer(
                builder: (context) {
                  return CircleCountWidget(count: viewModel.totalUnreadCount);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
