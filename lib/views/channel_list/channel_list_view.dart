import 'package:setoko_chat_package/core/viewmodels/chat/channel_list/channel_list_viewmodel.dart';
import 'package:setoko_chat_package/views/atoms/back_button_widget.dart';
import 'package:setoko_chat_package/views/atoms/separator_line_widget.dart';
import 'package:setoko_chat_package/views/atoms/settings_button_widget.dart';
import 'package:setoko_chat_package/views/channel_list/local_widgets/channel_list.dart';
import 'package:setoko_chat_package/views/components/app_bar_component.dart';
import 'package:setoko_chat_package/views/components/search_component.dart';
import 'package:setoko_chat_package/views/styles/colors.dart';
import 'package:setoko_chat_package/views/styles/text_styles.dart';
import 'package:setoko_chat_package/views/widgets/keyboard_dismissed_wodget.dart';
import 'package:setoko_chat_package/views/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChannelListView extends StatefulWidget {
  const ChannelListView({Key? key}) : super(key: key);

  @override
  State<ChannelListView> createState() => _ChannelListViewState();
}

class _ChannelListViewState extends State<ChannelListView> {
  ChannelListViewModel _viewModel = ChannelListViewModel();

  @override
  void initState() {
    _viewModel.initState();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Provider<ChannelListViewModel>(
        create: (_) => _viewModel,
        child: KeyboardDismissedWidget(
          child: Scaffold(
            appBar: PreferredSize(
              child: AppBar(
                elevation: 0.0,
                automaticallyImplyLeading: false,
                flexibleSpace: Column(
                  children: [
                    AppBarComponent(
                      useDefaultElevation: false,
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BackButtonWidget(onPressed: () => Navigator.pop(context)),
                          CTTextWidget(
                            text: 'CHAT',
                            textStyle: ChatTextStyles.textStyle1,
                          ),
                          SettingsButtonWidget(onPressed: () {}),
                        ],
                      ),
                    ),
                    SearchComponent(
                      textEditingController: TextEditingController(),
                      onTyping: (value) {},
                    ),
                    SeparatorLineWidget()
                  ],
                ),
                backgroundColor: ChatColors.white,
                bottom: TabBar(
                  tabs: [
                    Tab(text: "All"),
                    Tab(text: "Unread"),
                  ],
                  labelColor: ChatColors.blackPrimary,
                  labelStyle: ChatTextStyles.textStyle3,
                  indicatorColor: ChatColors.greenPrimary,
                  unselectedLabelColor: ChatColors.blackLight,
                  unselectedLabelStyle: ChatTextStyles.textStyle4,
                  onTap: (value) {
                    _viewModel.updateTabState(value);
                    _viewModel.loadChannelList(reload: true);
                  },
                ),
              ),
              preferredSize: Size.fromHeight(200),
            ),
            body: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                ChannelList(),
                ChannelList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
