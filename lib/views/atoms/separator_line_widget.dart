import 'package:setoko_chat_package/views/styles/colors.dart';
import 'package:flutter/material.dart';

class SeparatorLineWidget extends StatelessWidget {
  final Color? color;
  final double height;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  const SeparatorLineWidget({
    Key? key,
    this.height = 14,
    this.color,
    this.margin,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: height,
      width: size.width,
      padding: padding,
      margin: margin,
      color: color ?? ChatColors.calmWhite,
    );
  }
}
