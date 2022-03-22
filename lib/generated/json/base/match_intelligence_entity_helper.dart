
import 'package:changshengh5/model/CSClassMatchIntelligenceEntity.dart';

matchIntelligenceEntityFromJson(CSClassMatchIntelligenceEntity data, Map<String, dynamic> json) {
	if (json['match_intelligence'] != null) {
		data.csProMatchIntelligence = new CSClassMatchIntelligenceMatchIntelligence().fromJson(json['match_intelligence']);
	}
	return data;
}

Map<String, dynamic> matchIntelligenceEntityToJson(CSClassMatchIntelligenceEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.csProMatchIntelligence != null) {
		data['match_intelligence'] = entity.csProMatchIntelligence?.toJson();
	}
	return data;
}

matchIntelligenceMatchIntelligenceFromJson(CSClassMatchIntelligenceMatchIntelligence data, Map<String, dynamic> json) {
	if (json['1'] != null) {
		data.one = [];
		(json['1'] as List).forEach((v) {
			data.one?.add(new CSClassMatchIntelligenceMatchIntelligenceItem().fromJson(v));
		});
	}
	if (json['2'] != null) {
		data.two = [];
		(json['2'] as List).forEach((v) {
			data.two?.add(new CSClassMatchIntelligenceMatchIntelligenceItem().fromJson(v));
		});
	}
	return data;
}

Map<String, dynamic> matchIntelligenceMatchIntelligenceToJson(CSClassMatchIntelligenceMatchIntelligence entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.one != null) {
		data['1'] =  entity.one?.map((v) => v.toJson()).toList();
	}
	if (entity.two != null) {
		data['2'] =  entity.two?.map((v) => v.toJson()).toList();
	}
	return data;
}

matchIntelligenceMatchIntelligenceItemFromJson(CSClassMatchIntelligenceMatchIntelligenceItem data, Map<String, dynamic> json) {
	if (json['information'] != null) {
		data.information = json['information']?.toString();
	}
	if (json['status'] != null) {
		data.status = json['status']?.toString();
	}
	if (json['which_team'] != null) {
		data.csProWhichTeam = json['which_team']?.toString();
	}
	return data;
}

Map<String, dynamic> matchIntelligenceMatchIntelligenceItemToJson(CSClassMatchIntelligenceMatchIntelligenceItem entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['information'] = entity.information;
	data['status'] = entity.status;
	data['which_team'] = entity.csProWhichTeam;
	return data;
}