import 'dart:convert';

class Package {
  String uuid;
  String color;

  Package(Map<String, dynamic> data) {
    uuid = data['id'];
    color = data['color'];
  }
}