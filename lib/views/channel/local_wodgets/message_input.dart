import 'package:image_picker/image_picker.dart';
import 'package:setoko_chat_package/core/constants/enums.dart';
import 'package:setoko_chat_package/core/viewmodels/chat/channel/channel_viewmodel.dart';
import 'package:setoko_chat_package/views/atoms/add_attachment_button_widget.dart';
import 'package:setoko_chat_package/views/atoms/add_emoji_button_widget.dart';
import 'package:setoko_chat_package/views/atoms/message_media_widget.dart';
import 'package:setoko_chat_package/views/atoms/send_message_button_widget.dart';
import 'package:setoko_chat_package/views/styles/colors.dart';
import 'package:setoko_chat_package/views/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class MessageInput extends StatefulWidget {
  final Function(String) onPressSend;
  final Function(String) onChanged;

  MessageInput({
    required this.onPressSend,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  bool isShowMediaOption = false;
  final _formKey = GlobalKey<FormState>();
  final inputController = TextEditingController();

  void _validateForm(VoidCallback fn) {
    if (_formKey.currentState!.validate()) {
      fn();
    }
  }

  @override
  Widget build(BuildContext context) {
    final _viewModel = context.watch<ChannelViewModel>();

    return Observer(
      builder: (context) {
        isShowMediaOption = _viewModel.isShowMediaOption;

        if (_viewModel.selectedMessage != null) inputController.text = _viewModel.selectedMessage!.message;

        if (_viewModel.state == ChannelViewState.error && _viewModel.messages.isEmpty) {
          return const SizedBox.shrink();
        }

        return Container(
          padding: const EdgeInsets.only(bottom: 10, top: 10),
          color: Colors.white,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildMainInput(_viewModel, context),
                const SizedBox(height: 19),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  transitionBuilder: (child, animation) {
                    final _anim = Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0)).animate(animation);
                    return SlideTransition(
                      position: _anim,
                      child: child,
                    );
                  },
                  child: isShowMediaOption ? _buildMediaMessageView(_viewModel, context) : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMainInput(ChannelViewModel viewModel, BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        const SizedBox(width: 20),
        Expanded(
          child: Container(
            child: TextFormField(
              maxLines: 5,
              minLines: 1,
              controller: inputController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Message cannot be empty';
                }

                return null;
              },
              decoration: InputDecoration(
                hintText: "Write your message...",
                hintStyle: ChatTextStyles.textStyle11,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  borderSide: BorderSide.none,
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  borderSide: BorderSide(
                    color: ChatColors.red,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  borderSide: BorderSide(
                    color: ChatColors.red,
                  ),
                ),
                filled: true,
                isDense: true,
                fillColor: ChatColors.grayLighter,
                contentPadding: const EdgeInsets.all(11),
                prefixIcon: AddEmojiButtonWidget(
                  onPressed: () {},
                ),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AddAttachmentButtonWidget(onPressed: () {
                      viewModel.showMediaMessage(!isShowMediaOption);
                    }),
                    Container(
                      width: 47,
                      decoration: BoxDecoration(
                        color: ChatColors.orangePrimary,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                      ),
                      child: SendMessageButtonWidget(
                        onPressed: () {
                          _validateForm(() {
                            widget.onPressSend(inputController.text);
                            inputController.clear();
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              onChanged: (text) {
                widget.onChanged(text);
              },
            ),
          ),
        ),
        const SizedBox(width: 20),
      ],
    );
  }

  Widget _buildMediaMessageView(ChannelViewModel viewModel, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          MessageMediaWidget(
            icon: 'chat_add_product_info.svg',
            caption: 'Product',
            onPressed: () {
              viewModel.showMediaMessage(!isShowMediaOption);
            },
          ),
          MessageMediaWidget(
            icon: 'chat_add_photo.svg',
            caption: 'Photo',
            onPressed: () => viewModel.showPicker(ImageSource.gallery),
          ),
          MessageMediaWidget(
            icon: 'chat_open_camera.svg',
            caption: 'Camera',
            onPressed: () => viewModel.showPicker(ImageSource.camera),
          ),
          MessageMediaWidget(
            icon: 'chat_add_invoice.svg',
            caption: 'Invoice',
            onPressed: () {
              viewModel.showMediaMessage(!isShowMediaOption);
            },
          ),
        ],
      ),
    );
  }
}
