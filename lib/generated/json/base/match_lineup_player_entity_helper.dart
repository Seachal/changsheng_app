
import 'package:changshengh5/model/CSClassMatchLineupPlayerEntity.dart';

matchLineupPlayerEntityFromJson(CSClassMatchLineupPlayerEntity data, Map<String, dynamic> json) {
	if (json["match_lineup_player"] != null) {
		data.csProMatchLineupPlayer = new CSClassMatchLineupPlayerMatchLineupPlayer().fromJson(json["match_lineup_player"]);
	}
	return data;
}

Map<String, dynamic> matchLineupPlayerEntityToJson(CSClassMatchLineupPlayerEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.csProMatchLineupPlayer != null) {
		data["match_lineup_player"] = entity.csProMatchLineupPlayer?.toJson();
	}
	return data;
}

matchLineupPlayerMatchLineupPlayerFromJson(CSClassMatchLineupPlayerMatchLineupPlayer data, Map<String, dynamic> json) {
	if (json["1"] != null) {
		data.one = [];
		(json["1"] as List).forEach((v) {
			data.one?.add(new CSClassMatchLineupPlayerMatchLineupPlayerItem().fromJson(v));
		});
	}
	if (json["2"] != null) {
		data.two = [];
		(json["2"] as List).forEach((v) {
			data.two?.add(new CSClassMatchLineupPlayerMatchLineupPlayerItem().fromJson(v));
		});
	}
	return data;
}

Map<String, dynamic> matchLineupPlayerMatchLineupPlayerToJson(CSClassMatchLineupPlayerMatchLineupPlayer entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.one != null) {
		data["1"] =  entity.one?.map((v) => v.toJson()).toList();
	}
	if (entity.two != null) {
		data["2"] =  entity.two?.map((v) => v.toJson()).toList();
	}
	return data;
}

matchLineupPlayerMatchLineupPlayerItemFromJson(CSClassMatchLineupPlayerMatchLineupPlayerItem data, Map<String, dynamic> json) {
	if (json["player_name"] != null) {
		data.csProPlayerName = json["player_name"]?.toString();
	}
	if (json["avatar"] != null) {
		data.avatar = json["avatar"]?.toString();
	}
	if (json["shirt_number"] != null) {
		data.csProShirtNumber = json["shirt_number"]?.toString();
	}
	if (json["which_team"] != null) {
		data.csProWhichTeam = json["which_team"]?.toString();
	}
	if (json["is_regular"] != null) {
		data.csProIsRegular = json["is_regular"]?.toString();
	}
	if (json["seq_num"] != null) {
		data.csProSeqNum = json["seq_num"]?.toString();
	}
	return data;
}

Map<String, dynamic> matchLineupPlayerMatchLineupPlayerItemToJson(CSClassMatchLineupPlayerMatchLineupPlayerItem entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data["player_name"] = entity.csProPlayerName;
	data["avatar"] = entity.avatar;
	data["shirt_number"] = entity.csProShirtNumber;
	data["which_team"] = entity.csProWhichTeam;
	data["is_regular"] = entity.csProIsRegular;
	data["seq_num"] = entity.csProSeqNum;
	return data;
}