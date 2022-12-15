class Category {
  String? id;
  String? image;
  String? name;
 late bool isSlider;
  Category({this.image, this.name, this.isSlider = false});
  toMap() {
    return {"image": image, "name": name};
  }

  Category.fromMap(Map<String, dynamic> map) {
    image = map['image'];
    name = map['name'];
    isSlider = map['isSlider'] ?? false;
  }
}
