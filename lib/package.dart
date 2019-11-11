class Package {
  String type;
  var content;

  Package(Map<String, dynamic> data) {
    type = data['type'];
    content = data['content'];
  }
}