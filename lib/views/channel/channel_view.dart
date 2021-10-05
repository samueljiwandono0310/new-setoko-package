import 'package:setoko_chat_package/core/viewmodels/chat/channel/channel_viewmodel.dart';
import 'package:setoko_chat_package/views/channel/local_wodgets/channel_content.dart';
import 'package:setoko_chat_package/views/channel/local_wodgets/channel_header.dart';
import 'package:setoko_chat_package/views/channel/local_wodgets/message_input.dart';
import 'package:setoko_chat_package/views/styles/colors.dart';
import 'package:setoko_chat_package/views/widgets/keyboard_dismissed_wodget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChannelView extends StatefulWidget {
  final String channelUrl;
  const ChannelView({required this.channelUrl, Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ChannelViewState();
}

class _ChannelViewState extends State<ChannelView> {
  ChannelViewModel _viewModel = ChannelViewModel();

  @override
  void initState() {
    _viewModel.initState(widget.channelUrl);
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => _viewModel,
      child: KeyboardDismissedWidget(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: ChatColors.white,
            flexibleSpace: ChannelHeader(),
          ),
          body: SafeArea(
            child: Column(
              children: [
                ChannelContent(),
                MessageInput(
                  onPressSend: (text) {
                    _viewModel.onSendUserMessage(text);
                  },
                  onEditing: (text) {
                    _viewModel.onUpdateMessage(text);
                  },
                  onChanged: (text) {
                    _viewModel.onTyping(text != '');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
