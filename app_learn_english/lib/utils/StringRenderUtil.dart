import 'package:flutter/cupertino.dart';

class StringRenderUtil {
  final vi = ['a'];

  static List<String> SOURCE_CHARACTERS = ['À', 'Á', 'Â', 'Ã', 'È', 'É',
  'Ê', 'Ì', 'Í', 'Ò', 'Ó', 'Ô', 'Õ', 'Ù', 'Ú', 'Ý', 'à', 'á', 'â',
  'ã', 'è', 'é', 'ê', 'ì', 'í', 'ò', 'ó', 'ô', 'õ', 'ù', 'ú', 'ý',
  'Ă', 'ă', 'Đ', 'đ', 'Ĩ', 'ĩ', 'Ũ', 'ũ', 'Ơ', 'ơ', 'Ư', 'ư', 'Ạ',
  'ạ', 'Ả', 'ả', 'Ấ', 'ấ', 'Ầ', 'ầ', 'Ẩ', 'ẩ', 'Ẫ', 'ẫ', 'Ậ', 'ậ',
  'Ắ', 'ắ', 'Ằ', 'ằ', 'Ẳ', 'ẳ', 'Ẵ', 'ẵ', 'Ặ', 'ặ', 'Ẹ', 'ẹ', 'Ẻ',
  'ẻ', 'Ẽ', 'ẽ', 'Ế', 'ế', 'Ề', 'ề', 'Ể', 'ể', 'Ễ', 'ễ', 'Ệ', 'ệ',
  'Ỉ', 'ỉ', 'Ị', 'ị', 'Ọ', 'ọ', 'Ỏ', 'ỏ', 'Ố', 'ố', 'Ồ', 'ồ', 'Ổ',
  'ổ', 'Ỗ', 'ỗ', 'Ộ', 'ộ', 'Ớ', 'ớ', 'Ờ', 'ờ', 'Ở', 'ở', 'Ỡ', 'ỡ',
  'Ợ', 'ợ', 'Ụ', 'ụ', 'Ủ', 'ủ', 'Ứ', 'ứ', 'Ừ', 'ừ', 'Ử', 'ử', 'Ữ',
  'ữ', 'Ự', 'ự',];
  static List<String> DESTINATION_CHARACTERS = ['A', 'A', 'A', 'A', 'E',
  'E', 'E', 'I', 'I', 'O', 'O', 'O', 'O', 'U', 'U', 'Y', 'a', 'a',
  'a', 'a', 'e', 'e', 'e', 'i', 'i', 'o', 'o', 'o', 'o', 'u', 'u',
  'y', 'A', 'a', 'D', 'd', 'I', 'i', 'U', 'u', 'O', 'o', 'U', 'u',
  'A', 'a', 'A', 'a', 'A', 'a', 'A', 'a', 'A', 'a', 'A', 'a', 'A',
  'a', 'A', 'a', 'A', 'a', 'A', 'a', 'A', 'a', 'A', 'a', 'E', 'e',
  'E', 'e', 'E', 'e', 'E', 'e', 'E', 'e', 'E', 'e', 'E', 'e', 'E',
  'e', 'I', 'i', 'I', 'i', 'O', 'o', 'O', 'o', 'O', 'o', 'O', 'o',
  'O', 'o', 'O', 'o', 'O', 'o', 'O', 'o', 'O', 'o', 'O', 'o', 'O',
  'o', 'O', 'o', 'U', 'u', 'U', 'u', 'U', 'u', 'U', 'u', 'U', 'u',
  'U', 'u', 'U', 'u',];


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
  // Chuyển đổi tiếng anh sang tiếng việt
  // In hoa hết
  // Kiểm tra xem S1 có chứa S2 không
  static bool searching(String s1,String s2) {
    s1 = s1.toUpperCase();
    s2 = s2.toUpperCase();
    return s1.contains(s2);
    /*String newS1 = "";
    String newS2 = "";
    Characters charS1 = s1.characters;
    Characters charS2 = s2.characters;
    if (!s1.trim().isEmpty) {
      charS1.forEach((eTwo) {
        bool flag = false;
        for (int i =0; i< SOURCE_CHARACTERS.length; i++) {
          if (SOURCE_CHARACTERS.elementAt(i) == eTwo.toString()) {
            newS1 = newS1 + DESTINATION_CHARACTERS.elementAt(i).toString();
            flag =true;
            break;
          }
          if (flag == false) {
            newS1 = newS1 + eTwo;
          }
        }
      });
    }
    if (!s2.trim().isEmpty) {
      charS2.forEach((eTwo) {
        bool flag = false;
        for (int i =0; i< SOURCE_CHARACTERS.length; i++) {
          if (SOURCE_CHARACTERS.elementAt(i) == eTwo.toString()) {
            newS2 = newS2 + DESTINATION_CHARACTERS.elementAt(i).toString();
            flag =true;
            break;
          }
          if (flag == false) {
            newS2 = newS2 + eTwo;
          }
        }
      });
    }


    newS1 = newS1.toUpperCase();
    newS2 = newS2.toUpperCase();

    return newS1.contains(newS2);*/
    // return false;
  }
}
