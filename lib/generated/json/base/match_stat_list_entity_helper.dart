
import 'package:changshengh5/model/CSClassMatchStatListEntity.dart';

matchStatListEntityFromJson(CSClassMatchStatListEntity data, Map<String, dynamic> json) {
	if (json["match_stat"] != null) {
		data.csProMatchStat = [];
		(json["match_stat"] as List).forEach((v) {
			data.csProMatchStat?.add(new CSClassMatchStatListMatchStat().fromJson(v));
		});
	}
	return data;
}

Map<String, dynamic> matchStatListEntityToJson(CSClassMatchStatListEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.csProMatchStat != null) {
		data["match_stat"] =  entity.csProMatchStat?.map((v) => v.toJson()).toList();
	}
	return data;
}

matchStatListMatchStatFromJson(CSClassMatchStatListMatchStat data, Map<String, dynamic> json) {
	if (json["stat_type"] != null) {
		data.csProStatType = json["stat_type"]?.toString();
	}
	if (json["team_one_val"] != null) {
		data.csProTeamOneVal = json["team_one_val"]?.toString();
	}
	if (json["team_two_val"] != null) {
		data.csProTeamTwoVal = json["team_two_val"]?.toString();
	}
	if (json["csProProgressOne"] != null) {
		data.csProProgressOne = json["csProProgressOne"]?.toDouble();
	}
	if (json["csProProgressTwo"] != null) {
		data.csProProgressTwo = json["csProProgressTwo"]?.toDouble();
	}
	return data;
}

Map<String, dynamic> matchStatListMatchStatToJson(CSClassMatchStatListMatchStat entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data["stat_type"] = entity.csProStatType;
	data["team_one_val"] = entity.csProTeamOneVal;
	data["team_two_val"] = entity.csProTeamTwoVal;
	data["csProProgressOne"] = entity.csProProgressOne;
	data["csProProgressTwo"] = entity.csProProgressTwo;
	return data;
}