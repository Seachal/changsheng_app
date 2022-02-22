import 'package:changshengh5/generated/json/base/json_convert_content.dart';
import 'package:changshengh5/model/test_entity.dart';

TestEntity $TestEntityFromJson(Map<String, dynamic> json) {
	final TestEntity testEntity = TestEntity();
	final int? code = jsonConvert.convert<int>(json['code']);
	if (code != null) {
		testEntity.code = code;
	}
	final List<dynamic>? data = jsonConvert.convertListNotNull<dynamic>(json['data']);
	if (data != null) {
		testEntity.data = data;
	}
	return testEntity;
}

Map<String, dynamic> $TestEntityToJson(TestEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['code'] = entity.code;
	data['data'] =  entity.data;
	return data;
}