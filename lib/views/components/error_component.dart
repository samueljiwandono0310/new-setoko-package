import 'package:setoko_chat_package/views/styles/text_styles.dart';
import 'package:setoko_chat_package/views/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class ErrorComponent extends StatelessWidget {
  const ErrorComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CTTextWidget(text: 'Oops error occured', textStyle: ChatTextStyles.textStyle25),
    );
  }
}
