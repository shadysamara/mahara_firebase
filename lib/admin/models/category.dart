class Category {
  String? id;
  String? image;
  String? name;
  Category({this.image, this.name});
  toMap() {
    return {"image": image, "name": name};
  }

  Category.fromMap(Map<String, dynamic> map) {
    image = map['image'];
    name = map['name'];
  }
}
