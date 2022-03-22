
import 'package:changshengh5/model/SPClassMatchTrendRecentEntity.dart';

matchTrendRecentEntityFromJson(SPClassMatchTrendRecentEntity data, Map<String, dynamic> json) {
	if (json['match_trend_recent'] != null) {
		data.spProMatchTrendRecent = new SPClassMatchTrendRecentMatchTrendRecent().fromJson(json['match_trend_recent']);
	}
	return data;
}

Map<String, dynamic> matchTrendRecentEntityToJson(SPClassMatchTrendRecentEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.spProMatchTrendRecent != null) {
		data['match_trend_recent'] = entity.spProMatchTrendRecent?.toJson();
	}
	return data;
}

matchTrendRecentMatchTrendRecentFromJson(SPClassMatchTrendRecentMatchTrendRecent data, Map<String, dynamic> json) {
	if (json['1'] != null) {
		data.one = [];
		(json['1'] as List).forEach((v) {
			data.one?.add(new SPClassMatchTrendRecentMatchTrendRecentItem().fromJson(v));
		});
	}
	if (json['2'] != null) {
		data.two = [];
		(json['2'] as List).forEach((v) {
			data.two?.add(new SPClassMatchTrendRecentMatchTrendRecentItem().fromJson(v));
		});
	}
	return data;
}

Map<String, dynamic> matchTrendRecentMatchTrendRecentToJson(SPClassMatchTrendRecentMatchTrendRecent entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.one != null) {
		data['1'] =  entity.one?.map((v) => v.toJson()).toList();
	}
	if (entity.two != null) {
		data['2'] =  entity.two?.map((v) => v.toJson()).toList();
	}
	return data;
}

matchTrendRecentMatchTrendRecentItemFromJson(SPClassMatchTrendRecentMatchTrendRecentItem data, Map<String, dynamic> json) {
	if (json['ya_pan_result'] != null) {
		data.spProYaPanResult = json['ya_pan_result']?.toString();
	}
	if (json['da_xiao_result'] != null) {
		data.spProDaXiaoResult = json['da_xiao_result']?.toString();
	}
	if (json['win_rate'] != null) {
		data.spProWinRate = json['win_rate']?.toString();
	}
	if (json['which_team'] != null) {
		data.spProWhichTeam = json['which_team']?.toString();
	}
	return data;
}

Map<String, dynamic> matchTrendRecentMatchTrendRecentItemToJson(SPClassMatchTrendRecentMatchTrendRecentItem entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['ya_pan_result'] = entity.spProYaPanResult;
	data['da_xiao_result'] = entity.spProDaXiaoResult;
	data['win_rate'] = entity.spProWinRate;
	data['which_team'] = entity.spProWhichTeam;
	return data;
}