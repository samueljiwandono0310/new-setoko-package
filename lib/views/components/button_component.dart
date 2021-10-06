import 'package:flutter/material.dart';
import 'package:setoko_chat_package/views/styles/colors.dart';
import 'package:setoko_chat_package/views/styles/text_styles.dart';
import 'package:setoko_chat_package/views/widgets/text_widget.dart';

class ButtonComponent extends StatelessWidget {
  final Function()? onPressed;
  final String caption;
  final EdgeInsets padding;
  const ButtonComponent({
    Key? key,
    this.onPressed,
    required this.caption,
    this.padding = const EdgeInsets.symmetric(horizontal: 20),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            onPressed != null ? ChatColors.orangePrimary : ChatColors.gray,
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(24),
              ),
            ),
          ),
        ),
        onPressed: onPressed,
        child: CTTextWidget(
          text: caption,
          textStyle: ChatTextStyles.textStyle20,
        ),
      ),
    );
  }
}
