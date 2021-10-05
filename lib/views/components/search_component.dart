import 'package:setoko_chat_package/views/atoms/cancel_button_widget.dart';
import 'package:setoko_chat_package/views/atoms/search_icon_widget.dart';
import 'package:setoko_chat_package/views/styles/colors.dart';
import 'package:setoko_chat_package/views/styles/text_styles.dart';
import 'package:flutter/material.dart';

class SearchComponent extends StatefulWidget {
  final ValueChanged<String> onTyping;
  final TextEditingController textEditingController;
  const SearchComponent({Key? key, required this.onTyping, required this.textEditingController}) : super(key: key);

  @override
  State<SearchComponent> createState() => _SearchComponentState();
}

class _SearchComponentState extends State<SearchComponent> {
  @override
  void initState() {
    widget.textEditingController.addListener(() {
      Future.delayed(Duration.zero, () {
        if (widget.textEditingController.value.text.length == 0 || widget.textEditingController.value.text.length == 1) {
          setState(() {});
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    widget.textEditingController.removeListener(() => this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: 336,
      margin: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: ChatColors.grayLight, style: BorderStyle.solid, width: 1.0),
      ),
      child: TextFormField(
        controller: widget.textEditingController,
        onChanged: widget.onTyping,
        style: ChatTextStyles.textStyle21,
        cursorColor: ChatColors.blackPrimary,
        maxLines: 1,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: ChatTextStyles.textStyle15,
          prefixIcon: SearchIconWidget(),
          suffixIcon: widget.textEditingController.value.text.length > 0
              ? CancelButtonWidget(
                  onPressed: () {
                    setState(() {
                      widget.textEditingController.clear();
                    });
                  },
                )
              : const SizedBox.shrink(),
        ),
      ),
    );
  }
}
