
import 'package:changshengh5/model/CSClassMatchTrendRecentEntity.dart';

matchTrendRecentEntityFromJson(CSClassMatchTrendRecentEntity data, Map<String, dynamic> json) {
	if (json['match_trend_recent'] != null) {
		data.csProMatchTrendRecent = new CSClassMatchTrendRecentMatchTrendRecent().fromJson(json['match_trend_recent']);
	}
	return data;
}

Map<String, dynamic> matchTrendRecentEntityToJson(CSClassMatchTrendRecentEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.csProMatchTrendRecent != null) {
		data['match_trend_recent'] = entity.csProMatchTrendRecent?.toJson();
	}
	return data;
}

matchTrendRecentMatchTrendRecentFromJson(CSClassMatchTrendRecentMatchTrendRecent data, Map<String, dynamic> json) {
	if (json['1'] != null) {
		data.one = [];
		(json['1'] as List).forEach((v) {
			data.one?.add(new CSClassMatchTrendRecentMatchTrendRecentItem().fromJson(v));
		});
	}
	if (json['2'] != null) {
		data.two = [];
		(json['2'] as List).forEach((v) {
			data.two?.add(new CSClassMatchTrendRecentMatchTrendRecentItem().fromJson(v));
		});
	}
	return data;
}

Map<String, dynamic> matchTrendRecentMatchTrendRecentToJson(CSClassMatchTrendRecentMatchTrendRecent entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.one != null) {
		data['1'] =  entity.one?.map((v) => v.toJson()).toList();
	}
	if (entity.two != null) {
		data['2'] =  entity.two?.map((v) => v.toJson()).toList();
	}
	return data;
}

matchTrendRecentMatchTrendRecentItemFromJson(CSClassMatchTrendRecentMatchTrendRecentItem data, Map<String, dynamic> json) {
	if (json['ya_pan_result'] != null) {
		data.csProYaPanResult = json['ya_pan_result']?.toString();
	}
	if (json['da_xiao_result'] != null) {
		data.csProDaXiaoResult = json['da_xiao_result']?.toString();
	}
	if (json['win_rate'] != null) {
		data.csProWinRate = json['win_rate']?.toString();
	}
	if (json['which_team'] != null) {
		data.csProWhichTeam = json['which_team']?.toString();
	}
	return data;
}

Map<String, dynamic> matchTrendRecentMatchTrendRecentItemToJson(CSClassMatchTrendRecentMatchTrendRecentItem entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['ya_pan_result'] = entity.csProYaPanResult;
	data['da_xiao_result'] = entity.csProDaXiaoResult;
	data['win_rate'] = entity.csProWinRate;
	data['which_team'] = entity.csProWhichTeam;
	return data;
}