
import 'package:changshengh5/model/CSClassMatchInjuryEntity.dart';

matchInjuryEntityFromJson(CSClassMatchInjuryEntity data, Map<String, dynamic> json) {
	if (json['match_injury'] != null) {
		data.csProMatchInjury = new CSClassMatchInjuryMatchInjury().fromJson(json['match_injury']);
	}
	return data;
}

Map<String, dynamic> matchInjuryEntityToJson(CSClassMatchInjuryEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.csProMatchInjury != null) {
		data['match_injury'] = entity.csProMatchInjury?.toJson();
	}
	return data;
}

matchInjuryMatchInjuryFromJson(CSClassMatchInjuryMatchInjury data, Map<String, dynamic> json) {
	if (json['1'] != null) {
		data.one = [];
		(json['1'] as List).forEach((v) {
			data.one?.add(new CSClassMatchInjuryMatchInjuryItem().fromJson(v));
		});
	}
	if (json['2'] != null) {
		data.two = [];
		(json['2'] as List).forEach((v) {
			data.two?.add(new CSClassMatchInjuryMatchInjuryItem().fromJson(v));
		});
	}
	return data;
}

Map<String, dynamic> matchInjuryMatchInjuryToJson(CSClassMatchInjuryMatchInjury entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.one != null) {
		data['1'] =  entity.one?.map((v) => v.toJson()).toList();
	}
	if (entity.two != null) {
		data['2'] =  entity.two?.map((v) => v.toJson()).toList();
	}
	return data;
}

matchInjuryMatchInjuryItemFromJson(CSClassMatchInjuryMatchInjuryItem data, Map<String, dynamic> json) {
	if (json['which_team'] != null) {
		data.csProWhichTeam = json['which_team']?.toString();
	}
	if (json['reason'] != null) {
		data.reason = json['reason']?.toString();
	}
	if (json['player_name'] != null) {
		data.csProPlayerName = json['player_name']?.toString();
	}
	if (json['shirt_number'] != null) {
		data.csProShirtNumber = json['shirt_number']?.toString();
	}
	return data;
}

Map<String, dynamic> matchInjuryMatchInjuryItemToJson(CSClassMatchInjuryMatchInjuryItem entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['which_team'] = entity.csProWhichTeam;
	data['reason'] = entity.reason;
	data['player_name'] = entity.csProPlayerName;
	data['shirt_number'] = entity.csProShirtNumber;
	return data;
}