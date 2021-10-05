import 'package:setoko_chat_package/core/utils/assets_path.dart';
import 'package:setoko_chat_package/views/styles/colors.dart';
import 'package:setoko_chat_package/views/styles/text_styles.dart';
import 'package:setoko_chat_package/views/widgets/svg_widget.dart';
import 'package:setoko_chat_package/views/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class MessageMediaWidget extends StatelessWidget {
  final String icon;
  final String caption;
  final Function onPressed;
  const MessageMediaWidget({
    Key? key,
    required this.icon,
    required this.caption,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          padding: EdgeInsets.zero,
          icon: Container(
            width: 56.57,
            height: 55.91,
            decoration: BoxDecoration(
              color: ChatColors.greenSmooth,
              borderRadius: BorderRadius.all(Radius.circular(16)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black54,
                  spreadRadius: 0,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: SvgWidget(iconData: AssetPath.svgsPath + icon),
          ),
          onPressed: () {
            onPressed();
          },
        ),
        const SizedBox(
          height: 12.66,
        ),
        CTTextWidget(
          text: caption,
          textStyle: ChatTextStyles.textStyle9,
        )
      ],
    );
  }
}
