import 'package:flutter/material.dart';
import 'package:setoko_chat_package/views/atoms/general_error_widget.dart';
import 'package:setoko_chat_package/views/styles/text_styles.dart';
import 'package:setoko_chat_package/views/widgets/text_widget.dart';
import 'package:setoko_chat_package/views/components/button_component.dart';

class ErrorComponent extends StatelessWidget {
  final Function()? onPressed;
  const ErrorComponent({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                GeneralErrorWidget(
                  size: 200,
                ),
                CTTextWidget(
                  text: "Oops something went wrong, make sure you have a good internet connection and make sure you're logged in or already registered in the Setoko",
                  maxLines: 3,
                  textAlign: TextAlign.center,
                  textStyle: ChatTextStyles.textStyle21,
                ),
              ],
            ),
            SizedBox(
              width: size.width,
              height: 48,
              child: ButtonComponent(
                padding: EdgeInsets.zero,
                caption: 'Try again',
                onPressed: onPressed,
              ),
            )
          ],
        ),
      ),
    );
  }
}
