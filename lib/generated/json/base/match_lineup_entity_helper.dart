
import 'package:changshengh5/model/CSClassMatchLineupEntity.dart';

matchLineupEntityFromJson(CSClassMatchLineupEntity data, Map<String, dynamic> json) {
	if (json["match_lineup"] != null) {
		data.csProMatchLineup = [];
		(json["match_lineup"] as List).forEach((v) {
			data.csProMatchLineup?.add(new CSClassMatchLineupMatchLineup().fromJson(v));
		});
	}
	return data;
}

Map<String, dynamic> matchLineupEntityToJson(CSClassMatchLineupEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.csProMatchLineup != null) {
		data["match_lineup"] =  entity.csProMatchLineup?.map((v) => v.toJson()).toList();
	}
	return data;
}

matchLineupMatchLineupFromJson(CSClassMatchLineupMatchLineup data, Map<String, dynamic> json) {
	if (json["team_one_lineup"] != null) {
		data.csProTeamOneLineup = json["team_one_lineup"]?.toString();
	}
	if (json["team_two_lineup"] != null) {
		data.csProTeamTwoLineup = json["team_two_lineup"]?.toString();
	}
	return data;
}

Map<String, dynamic> matchLineupMatchLineupToJson(CSClassMatchLineupMatchLineup entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data["team_one_lineup"] = entity.csProTeamOneLineup;
	data["team_two_lineup"] = entity.csProTeamTwoLineup;
	return data;
}