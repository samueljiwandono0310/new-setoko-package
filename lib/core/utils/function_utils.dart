import 'dart:io';

import 'package:image_picker/image_picker.dart';

class FunctionUtils {
  FunctionUtils._constructor();

  static final FunctionUtils _instance = FunctionUtils._constructor();

  factory FunctionUtils() {
    return _instance;
  }

  Future<List<XFile>?> showPicker(ImageSource source) async {
    final picker = ImagePicker();
    List<XFile>? pickedFile;

    if (source == ImageSource.camera) {
      await picker.pickImage(source: ImageSource.camera).then((value) {
        if (value != null) {
          pickedFile = [value];
        }
      });
    } else {
      pickedFile = await picker.pickMultiImage();
    }

    if (pickedFile != null) {
      return pickedFile;
    }
    return null;
  }
}
