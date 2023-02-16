import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class TravelModel {
  final String urlImage;
  final String nameTravel;
  final String timeTravel;
  final String addressTravel;
  TravelModel({
    required this.urlImage,
    required this.nameTravel,
    required this.timeTravel,
    required this.addressTravel,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'urlImage': urlImage,
      'nameTravel': nameTravel,
      'timeTravel': timeTravel,
      'addressTravel': addressTravel,
    };
  }

  factory TravelModel.fromMap(Map<String, dynamic> map) {
    return TravelModel(
      urlImage: (map['urlImage'] ?? '') as String,
      nameTravel: (map['nameTravel'] ?? '') as String,
      timeTravel: (map['timeTravel'] ?? '') as String,
      addressTravel: (map['addressTravel'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TravelModel.fromJson(String source) => TravelModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
