import 'dart:io';

import 'package:image_picker/image_picker.dart';

class FunctionUtils {
  FunctionUtils._constructor();

  static final FunctionUtils _instance = FunctionUtils._constructor();

  factory FunctionUtils() {
    return _instance;
  }

  Future<File?> showPicker(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }
}
