import 'dart:convert';

class Package {
  String type;
  String content;

  Package(Map<String, dynamic> data) {
    type = data['type'];
    content = data['content'];
  }
}