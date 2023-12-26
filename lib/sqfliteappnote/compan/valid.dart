import 'package:untitled/sqfliteappnote/compan/massage.dart';

vailInput(String val, int min, int max) {
  if (val.length > max) {
    return "$messageInput $max";
  }
  if (val.length < min) {
    return "$messageInput $min";
  }
  if (val.isEmpty) {
    return "$messageInput";
  }
}
