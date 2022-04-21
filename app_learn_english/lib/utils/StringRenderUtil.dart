import 'package:flutter/cupertino.dart';

class StringRenderUtil {
  static Widget rednerStringCustom(String content, int lengthCustom) {
    if (content.length > lengthCustom) {
      return Text(
        content.substring(0, lengthCustom) + " .....",
        style: TextStyle(fontWeight: FontWeight.bold),
      );
    } else {
      return Text(content, style: TextStyle(fontWeight: FontWeight.bold));
    }
  }
  static String reduceSentence(String content, int maxLength) {
    if (content.length > maxLength) {
      return content.substring(0,maxLength) + "...";
    } else {
      return content;
    }
  }
}
