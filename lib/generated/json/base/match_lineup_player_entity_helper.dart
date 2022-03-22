
import 'package:changshengh5/model/SPClassMatchLineupPlayerEntity.dart';

matchLineupPlayerEntityFromJson(SPClassMatchLineupPlayerEntity data, Map<String, dynamic> json) {
	if (json["match_lineup_player"] != null) {
		data.spProMatchLineupPlayer = new SPClassMatchLineupPlayerMatchLineupPlayer().fromJson(json["match_lineup_player"]);
	}
	return data;
}

Map<String, dynamic> matchLineupPlayerEntityToJson(SPClassMatchLineupPlayerEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.spProMatchLineupPlayer != null) {
		data["match_lineup_player"] = entity.spProMatchLineupPlayer?.toJson();
	}
	return data;
}

matchLineupPlayerMatchLineupPlayerFromJson(SPClassMatchLineupPlayerMatchLineupPlayer data, Map<String, dynamic> json) {
	if (json["1"] != null) {
		data.one = [];
		(json["1"] as List).forEach((v) {
			data.one?.add(new SPClassMatchLineupPlayerMatchLineupPlayerItem().fromJson(v));
		});
	}
	if (json["2"] != null) {
		data.two = [];
		(json["2"] as List).forEach((v) {
			data.two?.add(new SPClassMatchLineupPlayerMatchLineupPlayerItem().fromJson(v));
		});
	}
	return data;
}

Map<String, dynamic> matchLineupPlayerMatchLineupPlayerToJson(SPClassMatchLineupPlayerMatchLineupPlayer entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.one != null) {
		data["1"] =  entity.one?.map((v) => v.toJson()).toList();
	}
	if (entity.two != null) {
		data["2"] =  entity.two?.map((v) => v.toJson()).toList();
	}
	return data;
}

matchLineupPlayerMatchLineupPlayerItemFromJson(SPClassMatchLineupPlayerMatchLineupPlayerItem data, Map<String, dynamic> json) {
	if (json["player_name"] != null) {
		data.spProPlayerName = json["player_name"]?.toString();
	}
	if (json["avatar"] != null) {
		data.avatar = json["avatar"]?.toString();
	}
	if (json["shirt_number"] != null) {
		data.spProShirtNumber = json["shirt_number"]?.toString();
	}
	if (json["which_team"] != null) {
		data.spProWhichTeam = json["which_team"]?.toString();
	}
	if (json["is_regular"] != null) {
		data.spProIsRegular = json["is_regular"]?.toString();
	}
	if (json["seq_num"] != null) {
		data.spProSeqNum = json["seq_num"]?.toString();
	}
	return data;
}

Map<String, dynamic> matchLineupPlayerMatchLineupPlayerItemToJson(SPClassMatchLineupPlayerMatchLineupPlayerItem entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data["player_name"] = entity.spProPlayerName;
	data["avatar"] = entity.avatar;
	data["shirt_number"] = entity.spProShirtNumber;
	data["which_team"] = entity.spProWhichTeam;
	data["is_regular"] = entity.spProIsRegular;
	data["seq_num"] = entity.spProSeqNum;
	return data;
}