
import 'package:changshengh5/model/CSClassMatchTrendEntity.dart';

matchTrendEntityFromJson(CSClassMatchTrendEntity data, Map<String, dynamic> json) {
	if (json["match_trend"] != null) {
		data.csProMatchTrend = new CSClassMatchTrendMatchTrend().fromJson(json["match_trend"]);
	}
	return data;
}

Map<String, dynamic> matchTrendEntityToJson(CSClassMatchTrendEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.csProMatchTrend != null) {
		data["match_trend"] = entity.csProMatchTrend?.toJson();
	}
	return data;
}

matchTrendMatchTrendFromJson(CSClassMatchTrendMatchTrend data, Map<String, dynamic> json) {
	if (json["1"] != null) {
		data.one = new CSClassMatchTrendMatchTrendLoad().fromJson(json["1"]);
	}
	if (json["2"] != null) {
		data.two = new CSClassMatchTrendMatchTrendLoad().fromJson(json["2"]);
	}
	return data;
}

Map<String, dynamic> matchTrendMatchTrendToJson(CSClassMatchTrendMatchTrend entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.one != null) {
		data["1"] = entity.one?.toJson();
	}
	if (entity.two != null) {
		data["2"] = entity.two?.toJson();
	}
	return data;
}

matchTrendMatchTrendLoadFromJson(CSClassMatchTrendMatchTrendLoad data, Map<String, dynamic> json) {
	if (json["总榜"] != null) {
		data.zon = [];
		(json["总榜"] as List).forEach((v) {
			data.zon?.add(new CSClassMatchTrendMatchTrendItem().fromJson(v));
		});
	}
	if (json["主场"] != null) {
		data.zhu = [];
		(json["主场"] as List).forEach((v) {
			data.zhu?.add(new CSClassMatchTrendMatchTrendItem().fromJson(v));
		});
	}
	if (json["客场"] != null) {
		data.ke = [];
		(json["客场"] as List).forEach((v) {
			data.ke?.add(new CSClassMatchTrendMatchTrendItem().fromJson(v));
		});
	}
	return data;
}

Map<String, dynamic> matchTrendMatchTrendLoadToJson(CSClassMatchTrendMatchTrendLoad entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.zon != null) {
		data["总榜"] =  entity.zon?.map((v) => v.toJson()).toList();
	}
	if (entity.zhu != null) {
		data["主场"] =  entity.zhu?.map((v) => v.toJson()).toList();
	}
	if (entity.ke != null) {
		data["客场"] =  entity.ke?.map((v) => v.toJson()).toList();
	}
	return data;
}

matchTrendMatchTrendItemFromJson(CSClassMatchTrendMatchTrendItem data, Map<String, dynamic> json) {
	if (json["guess_match_id"] != null) {
		data.csProGuessMatchId = json["guess_match_id"]?.toString();
	}
	if (json["type"] != null) {
		data.type = json["type"]?.toString();
	}
	if (json["match_num"] != null) {
		data.csProMatchNum = json["match_num"]?.toString();
	}
	if (json["win_num"] != null) {
		data.csProWinNum = json["win_num"]?.toString();
	}
	if (json["draw_num"] != null) {
		data.csProDrawNum = json["draw_num"]?.toString();
	}
	if (json["lose_num"] != null) {
		data.csProLoseNum = json["lose_num"]?.toString();
	}
	if (json["win_rate"] != null) {
		data.csProWinRate = json["win_rate"]?.toString();
	}
	if (json["big_num"] != null) {
		data.csProBigNum = json["big_num"]?.toString();
	}
	if (json["big_rate"] != null) {
		data.csProBigRate = json["big_rate"]?.toString();
	}
	if (json["small_num"] != null) {
		data.csProSmallNum = json["small_num"]?.toString();
	}
	if (json["small_rate"] != null) {
		data.csProSmallRate = json["small_rate"]?.toString();
	}
	if (json["which_team"] != null) {
		data.csProWhichTeam = json["which_team"]?.toString();
	}
	return data;
}

Map<String, dynamic> matchTrendMatchTrendItemToJson(CSClassMatchTrendMatchTrendItem entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data["guess_match_id"] = entity.csProGuessMatchId;
	data["type"] = entity.type;
	data["match_num"] = entity.csProMatchNum;
	data["win_num"] = entity.csProWinNum;
	data["draw_num"] = entity.csProDrawNum;
	data["lose_num"] = entity.csProLoseNum;
	data["win_rate"] = entity.csProWinRate;
	data["big_num"] = entity.csProBigNum;
	data["big_rate"] = entity.csProBigRate;
	data["small_num"] = entity.csProSmallNum;
	data["small_rate"] = entity.csProSmallRate;
	data["which_team"] = entity.csProWhichTeam;
	return data;
}