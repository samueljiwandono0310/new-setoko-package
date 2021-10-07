import 'package:flutter/material.dart';
import 'package:setoko_chat_package/core/utils/assets_path.dart';
import 'package:setoko_chat_package/views/widgets/svg_widget.dart';

class GeneralErrorWidget extends StatelessWidget {
  final double? size;
  const GeneralErrorWidget({Key? key, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgWidget(
      height: size,
      width: size,
      iconData: AssetPath.svgsPath + 'chat_search_not_found.svg',
    );
  }
}
