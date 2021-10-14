import 'package:flutter/material.dart' show runApp;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';
import 'package:setoko_chat_package/chat_module.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SessionEventHandler {
  bool _isLoggedIn = false;
  final ValueNotifier<bool> _isLoading = ValueNotifier(false);
  final TextEditingController userNameController = TextEditingController(text: 'hen1');
  final TextEditingController nickNameController = TextEditingController(text: 'Hendi');

  final _formKey = GlobalKey<FormState>();

  void _validateForm(VoidCallback fn) {
    if (_formKey.currentState!.validate()) {
      fn();
    }
  }

  void connectSB() async {
    _isLoading.value = true;
    await Future.delayed(const Duration(seconds: 1));
    _isLoggedIn = true;
    _isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        if (!FocusScope.of(context).hasPrimaryFocus) FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: false,
          leadingWidth: 20,
          title: const Text(
            'Setoko Chat',
          ),
          // actions: [
          //   ValueListenableBuilder<bool>(
          //     valueListenable: _isLoading,
          //     builder: (context, value, child) {
          //       return ChatView(
          //         key: ValueKey<bool>(_isLoggedIn),
          //         chatArgument: ChatArgument()
          //           ..isLogin = _isLoggedIn
          //           ..loginPathState = _isLoggedIn
          //           ..registerPathState = _isLoggedIn,
          //         chatUserArgument: ChatUserArgument(
          //           userId: userNameController.text,
          //           nickname: nickNameController.text,
          //         ),
          //       );
          //     },
          //   )
          // ],
        ),
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            scrollDirection: Axis.vertical,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SpacerWidget(),
                  MovieFormField(
                    label: 'Username',
                    textEditingController: userNameController,
                  ),
                  const SpacerWidget(),
                  MovieFormField(label: 'Nickname', textEditingController: nickNameController),
                  const SpacerWidget(),
                  ValueListenableBuilder<bool>(
                    valueListenable: _isLoading,
                    builder: (context, value, child) {
                      if (!value) {
                        return ButtonWidget(
                          onPressed: () => _validateForm(() => connectSB()),
                          caption: 'Sign In',
                        );
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SpacerWidget extends StatelessWidget {
  final double size;
  const SpacerWidget({Key? key, this.size = 10}) : super(key: key);

  @override
  Widget build(BuildContext context) => SizedBox(height: size, width: size);
}

class ButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String caption;
  final Color buttonColor;

  const ButtonWidget({
    Key? key,
    required this.onPressed,
    required this.caption,
    this.buttonColor = Colors.green,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(caption),
        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(buttonColor)),
      ),
    );
  }
}

class MovieFormField extends StatelessWidget {
  final String label;
  final int? maxLines;
  final TextEditingController textEditingController;
  const MovieFormField({Key? key, required this.label, this.maxLines = 1, required this.textEditingController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      controller: textEditingController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field is required';
        }

        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blueAccent,
            width: 1.0,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: 1.0,
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
            width: 1.0,
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
            width: 1.0,
          ),
        ),
      ),
    );
  }
}
