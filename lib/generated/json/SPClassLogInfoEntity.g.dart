import 'package:changshengh5/generated/json/base/json_convert_content.dart';
import 'package:changshengh5/model/SPClassLogInfoEntity.dart';

SPClassLogInfoEntity $SPClassLogInfoEntityFromJson(Map<String, dynamic> json) {
	final SPClassLogInfoEntity sPClassLogInfoEntity = SPClassLogInfoEntity();
	final String? sydid = jsonConvert.convert<String>(json['sydid']);
	if (sydid != null) {
		sPClassLogInfoEntity.sydid = sydid;
	}
	final List<String>? spProMenuList = jsonConvert.convertListNotNull<String>(json['spProMenuList']);
	if (spProMenuList != null) {
		sPClassLogInfoEntity.spProMenuList = spProMenuList;
	}
	return sPClassLogInfoEntity;
}

Map<String, dynamic> $SPClassLogInfoEntityToJson(SPClassLogInfoEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['sydid'] = entity.sydid;
	data['spProMenuList'] =  entity.spProMenuList;
	return data;
}