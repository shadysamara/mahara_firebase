import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class AppSlider {
  String? imageUrl;
  String? url;
  AppSlider({
    this.imageUrl,
    this.url,
  });
  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'imageUrl': imageUrl,
      'url': url,
    };
  }

  factory AppSlider.fromMap(Map<String, dynamic> map) {
    return AppSlider(
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
      url: map['url'] != null ? map['url'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppSlider.fromJson(String source) => AppSlider.fromMap(json.decode(source) as Map<String, dynamic>);
}
