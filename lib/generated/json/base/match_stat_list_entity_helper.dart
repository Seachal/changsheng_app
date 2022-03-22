
import 'package:changshengh5/model/SPClassMatchStatListEntity.dart';

matchStatListEntityFromJson(SPClassMatchStatListEntity data, Map<String, dynamic> json) {
	if (json["match_stat"] != null) {
		data.spProMatchStat = [];
		(json["match_stat"] as List).forEach((v) {
			data.spProMatchStat?.add(new SPClassMatchStatListMatchStat().fromJson(v));
		});
	}
	return data;
}

Map<String, dynamic> matchStatListEntityToJson(SPClassMatchStatListEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.spProMatchStat != null) {
		data["match_stat"] =  entity.spProMatchStat?.map((v) => v.toJson()).toList();
	}
	return data;
}

matchStatListMatchStatFromJson(SPClassMatchStatListMatchStat data, Map<String, dynamic> json) {
	if (json["stat_type"] != null) {
		data.spProStatType = json["stat_type"]?.toString();
	}
	if (json["team_one_val"] != null) {
		data.spProTeamOneVal = json["team_one_val"]?.toString();
	}
	if (json["team_two_val"] != null) {
		data.spProTeamTwoVal = json["team_two_val"]?.toString();
	}
	if (json["spProProgressOne"] != null) {
		data.spProProgressOne = json["spProProgressOne"]?.toDouble();
	}
	if (json["spProProgressTwo"] != null) {
		data.spProProgressTwo = json["spProProgressTwo"]?.toDouble();
	}
	return data;
}

Map<String, dynamic> matchStatListMatchStatToJson(SPClassMatchStatListMatchStat entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data["stat_type"] = entity.spProStatType;
	data["team_one_val"] = entity.spProTeamOneVal;
	data["team_two_val"] = entity.spProTeamTwoVal;
	data["spProProgressOne"] = entity.spProProgressOne;
	data["spProProgressTwo"] = entity.spProProgressTwo;
	return data;
}