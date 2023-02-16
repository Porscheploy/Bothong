import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ShopModel {
  final String urlImage;
  final String nameShop;
  final String timeShop;
  final String detailShoop;
  ShopModel({
    required this.urlImage,
    required this.nameShop,
    required this.timeShop,
    required this.detailShoop,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'urlImage': urlImage,
      'nameShop': nameShop,
      'timeShop': timeShop,
      'detailShoop': detailShoop,
    };
  }

  factory ShopModel.fromMap(Map<String, dynamic> map) {
    return ShopModel(
      urlImage: (map['urlImage'] ?? '') as String,
      nameShop: (map['nameShop'] ?? '') as String,
      timeShop: (map['timeShop'] ?? '') as String,
      detailShoop: (map['detailShoop'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ShopModel.fromJson(String source) => ShopModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
