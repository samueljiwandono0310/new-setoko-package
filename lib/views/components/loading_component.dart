import 'package:flutter/material.dart';
import 'package:setoko_chat_package/views/atoms/general_error_widget.dart';
import 'package:setoko_chat_package/views/styles/colors.dart';
import 'package:setoko_chat_package/views/styles/text_styles.dart';
import 'package:setoko_chat_package/views/widgets/text_widget.dart';

class LoadingComponent extends StatelessWidget {
  const LoadingComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GeneralErrorWidget(
            size: 200,
          ),
          CTTextWidget(
            text: 'Please wait, almost ready...',
            textStyle: ChatTextStyles.textStyle21,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
            child: LinearProgressIndicator(
              backgroundColor: ChatColors.greenLight,
              color: ChatColors.greenPrimary,
            ),
          )
        ],
      ),
    );
  }
}
