
import 'package:changshengh5/model/SPClassMatchIntelligenceEntity.dart';

matchIntelligenceEntityFromJson(SPClassMatchIntelligenceEntity data, Map<String, dynamic> json) {
	if (json['match_intelligence'] != null) {
		data.spProMatchIntelligence = new SPClassMatchIntelligenceMatchIntelligence().fromJson(json['match_intelligence']);
	}
	return data;
}

Map<String, dynamic> matchIntelligenceEntityToJson(SPClassMatchIntelligenceEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.spProMatchIntelligence != null) {
		data['match_intelligence'] = entity.spProMatchIntelligence?.toJson();
	}
	return data;
}

matchIntelligenceMatchIntelligenceFromJson(SPClassMatchIntelligenceMatchIntelligence data, Map<String, dynamic> json) {
	if (json['1'] != null) {
		data.one = [];
		(json['1'] as List).forEach((v) {
			data.one?.add(new SPClassMatchIntelligenceMatchIntelligenceItem().fromJson(v));
		});
	}
	if (json['2'] != null) {
		data.two = [];
		(json['2'] as List).forEach((v) {
			data.two?.add(new SPClassMatchIntelligenceMatchIntelligenceItem().fromJson(v));
		});
	}
	return data;
}

Map<String, dynamic> matchIntelligenceMatchIntelligenceToJson(SPClassMatchIntelligenceMatchIntelligence entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.one != null) {
		data['1'] =  entity.one?.map((v) => v.toJson()).toList();
	}
	if (entity.two != null) {
		data['2'] =  entity.two?.map((v) => v.toJson()).toList();
	}
	return data;
}

matchIntelligenceMatchIntelligenceItemFromJson(SPClassMatchIntelligenceMatchIntelligenceItem data, Map<String, dynamic> json) {
	if (json['information'] != null) {
		data.information = json['information']?.toString();
	}
	if (json['status'] != null) {
		data.status = json['status']?.toString();
	}
	if (json['which_team'] != null) {
		data.spProWhichTeam = json['which_team']?.toString();
	}
	return data;
}

Map<String, dynamic> matchIntelligenceMatchIntelligenceItemToJson(SPClassMatchIntelligenceMatchIntelligenceItem entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['information'] = entity.information;
	data['status'] = entity.status;
	data['which_team'] = entity.spProWhichTeam;
	return data;
}