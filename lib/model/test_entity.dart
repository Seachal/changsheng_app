import 'dart:convert';
import 'package:changshengh5/generated/json/base/json_field.dart';
import 'package:changshengh5/generated/json/test_entity.g.dart';

@JsonSerializable()
class TestEntity {

	late int code;
	late List<dynamic> data;
  
  TestEntity();

  factory TestEntity.fromJson(Map<String, dynamic> json) => $TestEntityFromJson(json);

  Map<String, dynamic> toJson() => $TestEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}