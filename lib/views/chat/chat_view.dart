import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:setoko_chat_package/core/arguments/chat_argument.dart';
import 'package:setoko_chat_package/core/arguments/chat_user_argument.dart';
import 'package:setoko_chat_package/core/models/merchant/merchant.dart';
import 'package:setoko_chat_package/core/models/product/product_detail.dart';
import 'package:setoko_chat_package/core/utils/assets_path.dart';
import 'package:setoko_chat_package/views/widgets/svg_widget.dart';
import 'package:setoko_chat_package/views/atoms/circle_count_widget.dart';
import 'package:setoko_chat_package/core/viewmodels/chat/chat_mini/chat_viewmodel.dart';

class ChatView extends StatefulWidget {
  final double? size;
  final Color? color;
  final bool directToDetail;
  final ChatArgument? chatArgument;
  final ChatUserArgument? chatUserArgument;
  final CTProductDetailData? productDetailData;
  final CTMerchant? merchant;

  const ChatView.fromHome({
    Key? key,
    this.size,
    this.color,
    this.chatArgument,
    this.chatUserArgument,
  })  : directToDetail = false,
        productDetailData = null,
        merchant = null,
        super(key: key);

  const ChatView.fromStore({
    Key? key,
    this.size,
    this.color,
    this.merchant,
  })  : directToDetail = true,
        chatArgument = null,
        chatUserArgument = null,
        productDetailData = null,
        super(key: key);

  const ChatView.fromPDP({
    Key? key,
    this.size,
    this.color,
    this.productDetailData,
  })  : directToDetail = true,
        chatArgument = null,
        chatUserArgument = null,
        merchant = null,
        super(key: key);

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final viewModel = ChatViewModel();

  @override
  void initState() {
    if (!widget.directToDetail) {
      Future.delayed(Duration.zero, () {
        viewModel.initState(
          chatArgument: widget.chatArgument!,
          chatUserArgument: widget.chatUserArgument!,
        );
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    if (!widget.directToDetail) {
      viewModel.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      onPressed: () => viewModel.goToChat(
        context,
        widget.merchant ?? widget.productDetailData ?? null,
      ),
      icon: Container(
        width: 42,
        height: 42,
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Center(
              child: SvgWidget(
                width: widget.size,
                height: widget.size,
                color: widget.color,
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
    );
  }
}
