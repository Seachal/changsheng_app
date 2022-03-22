
import 'package:changshengh5/model/CSClassConfRewardEntity.dart';

csMethodConfRewardEntityFromJson(CSClassConfRewardEntity data, Map<String, dynamic> json) {
	if (json["invite_user"] != null) {
		data.csProInviteUser = json["invite_user"]?.toString();
	}
	return data;
}

Map<String, dynamic> confRewardEntityToJson(CSClassConfRewardEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data["invite_user"] = entity.csProInviteUser;
	return data;
}