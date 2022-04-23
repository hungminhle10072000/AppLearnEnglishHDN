import 'package:flutter/cupertino.dart';

class StringRenderUtil {

  static List<String> SOURCE_CHARACTERS = [
  'À', 'Á', 'Â', 'Ã', 'È', 'É', 'Ê', 'Ì', 'Í', 'Ò',
  'Ó', 'Ô', 'Õ', 'Ù', 'Ú', 'Ý', 'Ă', 'Đ', 'Ĩ', 'Ũ',
  'Ơ', 'Ư', 'Ạ', 'Ả', 'Ấ', 'Ầ', 'Ẩ', 'Ẫ', 'Ậ', 'Ắ',
  'Ằ', 'Ẳ', 'Ẵ', 'Ặ', 'Ẹ', 'Ẻ', 'Ẽ', 'Ế', 'Ề', 'Ể',
  'Ễ', 'Ệ', 'Ỉ', 'Ị', 'Ọ', 'Ỏ', 'Ố', 'Ồ', 'Ổ', 'Ỗ',
  'Ộ', 'Ớ', 'Ờ', 'Ở', 'Ỡ', 'Ợ', 'Ụ', 'Ủ', 'Ứ', 'Ừ',
  'Ử', 'Ữ', 'Ự',];
  static List<String> DESTINATION_CHARACTERS = [
  'A', 'A', 'A', 'A', 'E', 'E', 'E', 'I', 'I', 'O',
  'O', 'O', 'O', 'U', 'U', 'Y', 'A', 'D', 'I', 'U',
  'O', 'U', 'A', 'A', 'A', 'A', 'A', 'A', 'A', 'A',
  'A', 'A', 'A', 'A', 'E', 'E', 'E', 'E', 'E', 'E',
  'E', 'E', 'I', 'I', 'O', 'O', 'O', 'O', 'O', 'O',
  'O', 'O', 'O', 'O', 'O', 'O', 'U', 'U', 'U', 'U',
  'U', 'U', 'U',];


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

  static bool searching(String s1,String s2) {
    s1 = s1.toUpperCase();
    s2 = s2.toUpperCase();
    String newS1 = "";
    String newS2 = "";
    Characters charS1 = s1.characters;
    Characters charS2 = s2.characters;
    if (s1.trim().isNotEmpty) {
      for (var eTwo in charS1) {
        bool flag = false;
        for (int i =0; i< SOURCE_CHARACTERS.length; i++) {
          if (SOURCE_CHARACTERS.elementAt(i) == eTwo.toString()) {
            newS1 = newS1 + DESTINATION_CHARACTERS.elementAt(i).toString();
            flag =true;
            break;
          }
        }
        if (flag == false) {
          newS1 = newS1 + eTwo;
        }
      }
    }
    if (s2.trim().isNotEmpty) {
      for (var eTwo in charS2) {
        bool flag = false;
        for (int i =0; i< SOURCE_CHARACTERS.length; i++) {
          if (SOURCE_CHARACTERS.elementAt(i) == eTwo.toString()) {
            newS2 = newS2 + DESTINATION_CHARACTERS.elementAt(i).toString();
            flag =true;
            break;
          }
        }
        if (flag == false) {
          newS2 = newS2 + eTwo;
        }
      }
    }
    newS1 = newS1.toUpperCase();
    newS2 = newS2.toUpperCase();
    return newS1.contains(newS2);
  }
}
