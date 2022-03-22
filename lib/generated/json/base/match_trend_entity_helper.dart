
import 'package:changshengh5/model/SPClassMatchTrendEntity.dart';

matchTrendEntityFromJson(SPClassMatchTrendEntity data, Map<String, dynamic> json) {
	if (json["match_trend"] != null) {
		data.spProMatchTrend = new SPClassMatchTrendMatchTrend().fromJson(json["match_trend"]);
	}
	return data;
}

Map<String, dynamic> matchTrendEntityToJson(SPClassMatchTrendEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.spProMatchTrend != null) {
		data["match_trend"] = entity.spProMatchTrend?.toJson();
	}
	return data;
}

matchTrendMatchTrendFromJson(SPClassMatchTrendMatchTrend data, Map<String, dynamic> json) {
	if (json["1"] != null) {
		data.one = new SPClassMatchTrendMatchTrendLoad().fromJson(json["1"]);
	}
	if (json["2"] != null) {
		data.two = new SPClassMatchTrendMatchTrendLoad().fromJson(json["2"]);
	}
	return data;
}

Map<String, dynamic> matchTrendMatchTrendToJson(SPClassMatchTrendMatchTrend entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.one != null) {
		data["1"] = entity.one?.toJson();
	}
	if (entity.two != null) {
		data["2"] = entity.two?.toJson();
	}
	return data;
}

matchTrendMatchTrendLoadFromJson(SPClassMatchTrendMatchTrendLoad data, Map<String, dynamic> json) {
	if (json["总榜"] != null) {
		data.zon = [];
		(json["总榜"] as List).forEach((v) {
			data.zon?.add(new SPClassMatchTrendMatchTrendItem().fromJson(v));
		});
	}
	if (json["主场"] != null) {
		data.zhu = [];
		(json["主场"] as List).forEach((v) {
			data.zhu?.add(new SPClassMatchTrendMatchTrendItem().fromJson(v));
		});
	}
	if (json["客场"] != null) {
		data.ke = [];
		(json["客场"] as List).forEach((v) {
			data.ke?.add(new SPClassMatchTrendMatchTrendItem().fromJson(v));
		});
	}
	return data;
}

Map<String, dynamic> matchTrendMatchTrendLoadToJson(SPClassMatchTrendMatchTrendLoad entity) {
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

matchTrendMatchTrendItemFromJson(SPClassMatchTrendMatchTrendItem data, Map<String, dynamic> json) {
	if (json["guess_match_id"] != null) {
		data.spProGuessMatchId = json["guess_match_id"]?.toString();
	}
	if (json["type"] != null) {
		data.type = json["type"]?.toString();
	}
	if (json["match_num"] != null) {
		data.spProMatchNum = json["match_num"]?.toString();
	}
	if (json["win_num"] != null) {
		data.spProWinNum = json["win_num"]?.toString();
	}
	if (json["draw_num"] != null) {
		data.spProDrawNum = json["draw_num"]?.toString();
	}
	if (json["lose_num"] != null) {
		data.spProLoseNum = json["lose_num"]?.toString();
	}
	if (json["win_rate"] != null) {
		data.spProWinRate = json["win_rate"]?.toString();
	}
	if (json["big_num"] != null) {
		data.spProBigNum = json["big_num"]?.toString();
	}
	if (json["big_rate"] != null) {
		data.spProBigRate = json["big_rate"]?.toString();
	}
	if (json["small_num"] != null) {
		data.spProSmallNum = json["small_num"]?.toString();
	}
	if (json["small_rate"] != null) {
		data.spProSmallRate = json["small_rate"]?.toString();
	}
	if (json["which_team"] != null) {
		data.spProWhichTeam = json["which_team"]?.toString();
	}
	return data;
}

Map<String, dynamic> matchTrendMatchTrendItemToJson(SPClassMatchTrendMatchTrendItem entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data["guess_match_id"] = entity.spProGuessMatchId;
	data["type"] = entity.type;
	data["match_num"] = entity.spProMatchNum;
	data["win_num"] = entity.spProWinNum;
	data["draw_num"] = entity.spProDrawNum;
	data["lose_num"] = entity.spProLoseNum;
	data["win_rate"] = entity.spProWinRate;
	data["big_num"] = entity.spProBigNum;
	data["big_rate"] = entity.spProBigRate;
	data["small_num"] = entity.spProSmallNum;
	data["small_rate"] = entity.spProSmallRate;
	data["which_team"] = entity.spProWhichTeam;
	return data;
}