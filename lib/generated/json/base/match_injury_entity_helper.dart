
import 'package:changshengh5/model/SPClassMatchInjuryEntity.dart';

matchInjuryEntityFromJson(SPClassMatchInjuryEntity data, Map<String, dynamic> json) {
	if (json['match_injury'] != null) {
		data.spProMatchInjury = new SPClassMatchInjuryMatchInjury().fromJson(json['match_injury']);
	}
	return data;
}

Map<String, dynamic> matchInjuryEntityToJson(SPClassMatchInjuryEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.spProMatchInjury != null) {
		data['match_injury'] = entity.spProMatchInjury?.toJson();
	}
	return data;
}

matchInjuryMatchInjuryFromJson(SPClassMatchInjuryMatchInjury data, Map<String, dynamic> json) {
	if (json['1'] != null) {
		data.one = [];
		(json['1'] as List).forEach((v) {
			data.one?.add(new SPClassMatchInjuryMatchInjuryItem().fromJson(v));
		});
	}
	if (json['2'] != null) {
		data.two = [];
		(json['2'] as List).forEach((v) {
			data.two?.add(new SPClassMatchInjuryMatchInjuryItem().fromJson(v));
		});
	}
	return data;
}

Map<String, dynamic> matchInjuryMatchInjuryToJson(SPClassMatchInjuryMatchInjury entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.one != null) {
		data['1'] =  entity.one?.map((v) => v.toJson()).toList();
	}
	if (entity.two != null) {
		data['2'] =  entity.two?.map((v) => v.toJson()).toList();
	}
	return data;
}

matchInjuryMatchInjuryItemFromJson(SPClassMatchInjuryMatchInjuryItem data, Map<String, dynamic> json) {
	if (json['which_team'] != null) {
		data.spProWhichTeam = json['which_team']?.toString();
	}
	if (json['reason'] != null) {
		data.reason = json['reason']?.toString();
	}
	if (json['player_name'] != null) {
		data.spProPlayerName = json['player_name']?.toString();
	}
	if (json['shirt_number'] != null) {
		data.spProShirtNumber = json['shirt_number']?.toString();
	}
	return data;
}

Map<String, dynamic> matchInjuryMatchInjuryItemToJson(SPClassMatchInjuryMatchInjuryItem entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['which_team'] = entity.spProWhichTeam;
	data['reason'] = entity.reason;
	data['player_name'] = entity.spProPlayerName;
	data['shirt_number'] = entity.spProShirtNumber;
	return data;
}