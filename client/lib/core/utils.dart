import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

String rgbToHex(Color color) {
  // ignore: deprecated_member_use
  return '${(color.r * 255).round().toRadixString(16).padLeft(2, '0')}${(color.g * 255).round().toRadixString(16).padLeft(2, '0')}${(color.b * 255).toInt().toRadixString(16).padLeft(2, '0')}';
}

Color hexToColor(String hex) {
  return Color(int.parse(hex, radix: 16) + 0xFF000000);
}

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(content)));
}

Future<File?> pickAudio() async {
  try {
    final filePickerResult = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3', 'wav', 'aac', 'flac', 'm4a', 'ogg'],
    );
    if (filePickerResult != null) {
      return File(filePickerResult.files.first.xFile.path);
    }
    return null;
  } catch (e) {
    return null;
  }
}

Future<File?> pickImage() async {
  try {
    final filePickerResult = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (filePickerResult != null) {
      return File(filePickerResult.files.first.xFile.path);
    }
    return null;
  } catch (e) {
    return null;
  }
}
