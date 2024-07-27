import 'dart:developer';
import 'dart:io';
import 'package:flutter/painting.dart';
import 'package:image/image.dart' as img;

class ImageConvert {
  static void convertToPng(String jpegPath, String pngPath) {

    File jpegFile = File(jpegPath);
    final jpegBytes = jpegFile.readAsBytesSync();
    img.Image? jpegImage = img.decodeImage(jpegBytes);
    
    if (jpegImage == null) {
      log('Could not decode image');
      return;
    }

    List<int> pngBytes = img.encodePng(jpegImage);
    File pngFile = File(pngPath);

    pngFile.writeAsBytesSync(pngBytes);
    PaintingBinding.instance.imageCache.clear();
  }
}
