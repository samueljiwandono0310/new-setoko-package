import 'package:setoko_chat_package/views/styles/colors.dart';
import 'package:flutter/material.dart';

class AppBarComponent extends StatelessWidget {
  final Widget content;
  final bool useDefaultElevation;

  const AppBarComponent({
    Key? key,
    required this.content,
    this.useDefaultElevation = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PhysicalModel(
        elevation: useDefaultElevation ? 0.0 : 0.8,
        color: Colors.black,
        child: Container(
          color: ChatColors.white,
          child: content,
        ),
      ),
    );
  }
}
