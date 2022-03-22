
import 'package:changshengh5/model/SPClassConfRewardEntity.dart';

spFunConfRewardEntityFromJson(SPClassConfRewardEntity data, Map<String, dynamic> json) {
	if (json["invite_user"] != null) {
		data.spProInviteUser = json["invite_user"]?.toString();
	}
	return data;
}

Map<String, dynamic> confRewardEntityToJson(SPClassConfRewardEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data["invite_user"] = entity.spProInviteUser;
	return data;
}