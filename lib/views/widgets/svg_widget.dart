import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgWidget extends StatelessWidget {
  final String iconData;
  final double? width;
  final double? height;
  final Color? color;
  const SvgWidget({
    Key? key,
    this.width,
    this.height,
    required this.iconData,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: SvgPicture.asset(
        iconData,
        color: color,
        width: width,
        height: height,
        package: 'setoko_chat_package',
        allowDrawingOutsideViewBox: true,
      ),
    );
  }
}
