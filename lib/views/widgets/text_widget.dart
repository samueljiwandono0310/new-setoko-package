import 'package:flutter/material.dart';

class CTTextWidget extends StatelessWidget {
  final String text;
  final int maxLines;
  final TextStyle textStyle;
  final TextAlign? textAlign;
  const CTTextWidget({
    Key? key,
    required this.text,
    required this.textStyle, this.maxLines = 1, this.textAlign
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: textStyle,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: TextOverflow.ellipsis,
    );
  }
}
