
import 'package:changshengh5/model/SPClassMatchLineupEntity.dart';

matchLineupEntityFromJson(SPClassMatchLineupEntity data, Map<String, dynamic> json) {
	if (json["match_lineup"] != null) {
		data.spProMatchLineup = [];
		(json["match_lineup"] as List).forEach((v) {
			data.spProMatchLineup?.add(new SPClassMatchLineupMatchLineup().fromJson(v));
		});
	}
	return data;
}

Map<String, dynamic> matchLineupEntityToJson(SPClassMatchLineupEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.spProMatchLineup != null) {
		data["match_lineup"] =  entity.spProMatchLineup?.map((v) => v.toJson()).toList();
	}
	return data;
}

matchLineupMatchLineupFromJson(SPClassMatchLineupMatchLineup data, Map<String, dynamic> json) {
	if (json["team_one_lineup"] != null) {
		data.spProTeamOneLineup = json["team_one_lineup"]?.toString();
	}
	if (json["team_two_lineup"] != null) {
		data.spProTeamTwoLineup = json["team_two_lineup"]?.toString();
	}
	return data;
}

Map<String, dynamic> matchLineupMatchLineupToJson(SPClassMatchLineupMatchLineup entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data["team_one_lineup"] = entity.spProTeamOneLineup;
	data["team_two_lineup"] = entity.spProTeamTwoLineup;
	return data;
}