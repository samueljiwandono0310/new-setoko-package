import 'package:flutter/material.dart';
import 'package:setoko_chat_package/core/extensions/extensions.dart';

class CircleCountWidget extends StatelessWidget {
  final int count;
  const CircleCountWidget({Key? key, required this.count}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (count < 1) return const SizedBox.shrink();
    return Container(
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white, width: 1),
      ),
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Text(
        count.readableUnreadCount,
        style: TextStyle(color: Colors.white, fontSize: 10),
      ),
    );
  }
}
