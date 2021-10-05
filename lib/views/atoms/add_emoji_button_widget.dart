import 'package:setoko_chat_package/core/utils/assets_path.dart';
import 'package:setoko_chat_package/views/widgets/svg_widget.dart';
import 'package:flutter/material.dart';

class AddEmojiButtonWidget extends StatelessWidget {
  final Function onPressed;
  const AddEmojiButtonWidget({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        onPressed();
      },
      icon: SvgWidget(
        iconData: AssetPath.svgsPath + 'chat_show_emoticon.svg',
      ),
    );
  }
}
