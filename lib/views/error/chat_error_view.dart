// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:setoko_chat_package/views/components/error_component.dart';
import 'package:setoko_chat_package/views/components/loading_component.dart';
import 'package:setoko_chat_package/views/styles/colors.dart';

class ChatErrorView extends StatelessWidget {
  final Function() tryAgainAction;
  ChatErrorView({
    Key? key,
    required this.tryAgainAction,
  }) : super(key: key);

  ValueNotifier<bool> _isLoading = ValueNotifier<bool>(false);

  Future<void> _onTryAgainAction(BuildContext context) async {
    try {
      _isLoading.value = true;
      await tryAgainAction();
      _isLoading.value = false;
    } catch (e) {
      _isLoading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ChatColors.white,
      body: Stack(
        children: [
          SafeArea(
            left: false,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: BackButton(),
            ),
          ),
          ValueListenableBuilder<bool>(
            valueListenable: _isLoading,
            builder: (_, value, __) {
              if (value) {
                return LoadingComponent();
              }

              return ErrorComponent(
                onPressed: () => _onTryAgainAction(context),
              );
            },
          ),
        ],
      ),
    );
  }
}
