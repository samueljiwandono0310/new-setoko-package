import 'package:setoko_chat_package/core/viewmodels/chat/channel_create/channel_create_viewmodel.dart';
import 'package:setoko_chat_package/views/atoms/back_button_widget.dart';
import 'package:setoko_chat_package/views/atoms/separator_line_widget.dart';
import 'package:setoko_chat_package/views/channel/channel_view.dart';
import 'package:setoko_chat_package/views/styles/text_styles.dart';
import 'package:setoko_chat_package/views/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ChannelCreateView extends StatefulWidget {
  @override
  _ChannelCreateViewState createState() => _ChannelCreateViewState();
}

class _ChannelCreateViewState extends State<ChannelCreateView> {
  final _viewModel = CreateChannelViewModel();

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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: navigationBar(),
      body: SafeArea(child: body(context)),
    );
  }

  AppBar navigationBar() {
    return AppBar(
      leading: BackButtonWidget(onPressed: () => Navigator.pop(context)),
      toolbarHeight: 65,
      elevation: 1,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      title: CTTextWidget(text: 'New channel', textStyle: ChatTextStyles.textStyle1),
      actions: [
        Observer(
          builder: (context) {
            return TextButton(
              onPressed: () {
                _viewModel.createChannel().then((channel) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChannelView(channelUrl: channel.channelUrl),
                    ),
                  );
                }).catchError((error) {
                  _buildErrorAlert(error);
                });
              },
              child: CTTextWidget(
                text: "${_viewModel.selectedUsers.length == 0 ? '' : _viewModel.selectedUsers.length} Create",
                textStyle: ChatTextStyles.textStyle3,
              ),
            );
          },
        )
      ],
      centerTitle: true,
    );
  }

  Widget body(BuildContext context) {
    return Observer(
      builder: (context) {
        return ListView.separated(
          controller: _viewModel.lstController,
          itemCount: _viewModel.itemCount,
          itemBuilder: (context, index) {
            if (index == _viewModel.selections.length && _viewModel.hasNext) {
              return Center(
                child: Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return Observer(
              builder: (context) {
                return CheckboxListTile(
                  title: CTTextWidget(
                      text: _viewModel.selections[index].user.nickname.isEmpty
                          ? _viewModel.selections[index].user.userId
                          : _viewModel.selections[index].user.nickname,
                      maxLines: 1,
                      textStyle: ChatTextStyles.textStyle3),
                  controlAffinity: ListTileControlAffinity.platform,
                  value: _viewModel.currentUser?.userId == _viewModel.selections[index].user.userId || _viewModel.selections[index].isSelected,
                  activeColor: Theme.of(context).primaryColor,
                  onChanged: (bool? value) {
                    // Display chat view
                    _viewModel.setSelection(_viewModel.selections[index]);
                    // _viewModel.selections[index].isSelected = !_viewModel.selections[index].isSelected;
                  },
                  secondary: _viewModel.selections[index].user.profileUrl?.isEmpty == true
                      ? CircleAvatar(
                          child: Text(
                          (_viewModel.selections[index].user.nickname.isEmpty
                                  ? _viewModel.selections[index].user.userId
                                  : _viewModel.selections[index].user.nickname)
                              .substring(0, 1)
                              .toUpperCase(),
                        ))
                      : CircleAvatar(
                          backgroundImage: NetworkImage(_viewModel.selections[index].user.profileUrl ?? ''),
                        ),
                );
              },
            );
          },
          separatorBuilder: (context, index) {
            return SeparatorLineWidget(height: 1, margin: const EdgeInsets.symmetric(horizontal: 10));
          },
        );
      },
    );
  }

  void _buildErrorAlert(Error error) {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          title: new CTTextWidget(
            text: "Channel Creation Error: $error",
            textStyle: ChatTextStyles.textStyle1,
          ),
          shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
          actions: <Widget>[
            new TextButton(
              child: new CTTextWidget(
                text: "Ok",
                textStyle: ChatTextStyles.textStyle11,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
