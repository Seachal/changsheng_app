
import 'package:changshengh5/model/CSClassLogInfoEntity.dart';

logInfoEntityFromJson(CSClassLogInfoEntity data, Map<String, dynamic> json) {
	if (json['sydid'] != null) {
		data.sydid = json['sydid']?.toString();
	}
	if (json['menu_list'] != null) {
		data.csProMenuList = json['menu_list']?.map((v) => v?.toString())?.toList()?.cast<String>();
	}
	return data;
}

Map<String, dynamic> logInfoEntityToJson(CSClassLogInfoEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['sydid'] = entity.sydid;
	data['menu_list'] = entity.csProMenuList;
	return data;
}