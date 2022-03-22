
import 'package:changshengh5/model/SPClassPlayerStatListEntity.dart';

playerStatListEntityFromJson(SPClassPlayerStatListEntity data, Map<String, dynamic> json) {
	if (json['has_data'] != null) {
		data.spProHasData = json['has_data'];
	}
	if (json['player_stat_list'] != null) {
		data.spProPlayerStatList = new SPClassPlayerStatListPlayerStatList().fromJson(json['player_stat_list']);
	}
	if (json['best_player_list'] != null) {
		data.spProBestPlayerList = new SPClassPlayerStatListBestPlayerList().fromJson(json['best_player_list']);
	}
	if (json['sum'] != null) {
		data.sum = new PlayerStatListSum().fromJson(json['sum']);
	}
	return data;
}

Map<String, dynamic> playerStatListEntityToJson(SPClassPlayerStatListEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['has_data'] = entity.spProHasData;
	if (entity.spProPlayerStatList != null) {
		data['player_stat_list'] = entity.spProPlayerStatList?.toJson();
	}
	if (entity.spProBestPlayerList != null) {
		data['best_player_list'] = entity.spProBestPlayerList?.toJson();
	}
	if (entity.sum != null) {
		data['sum'] = entity.sum?.toJson();
	}
	return data;
}

playerStatListPlayerStatListFromJson(SPClassPlayerStatListPlayerStatList data, Map<String, dynamic> json) {
	if (json['1'] != null) {
		data.one = [];
		(json['1'] as List).forEach((v) {
			data.one?.add(new SPClassPlayerStatListPlayerStatListItem().fromJson(v));
		});
	}
	if (json['2'] != null) {
		data.two =[];
		(json['2'] as List).forEach((v) {
			data.two?.add(new SPClassPlayerStatListPlayerStatListItem().fromJson(v));
		});
	}
	return data;
}

Map<String, dynamic> playerStatListPlayerStatListToJson(SPClassPlayerStatListPlayerStatList entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.one != null) {
		data['1'] =  entity.one?.map((v) => v.toJson()).toList();
	}
	if (entity.two != null) {
		data['2'] =  entity.two?.map((v) => v.toJson()).toList();
	}
	return data;
}

playerStatListPlayerStatListItemFromJson(SPClassPlayerStatListPlayerStatListItem data, Map<String, dynamic> json) {
	if (json['guess_match_id'] != null) {
		data.spProGuessMatchId = json['guess_match_id']?.toString();
	}
	if (json['shirt_number'] != null) {
		data.spProShirtNumber = json['shirt_number']?.toString();
	}
	if (json['player_name'] != null) {
		data.spProPlayerName = json['player_name']?.toString();
	}
	if (json['which_team'] != null) {
		data.spProWhichTeam = json['which_team']?.toString();
	}
	if (json['is_regular'] != null) {
		data.spProIsRegular = json['is_regular']?.toString();
	}
	if (json['score'] != null) {
		data.score = json['score']?.toString();
	}
	if (json['shot'] != null) {
		data.shot = json['shot']?.toString();
	}
	if (json['three_point'] != null) {
		data.spProThreePoint = json['three_point']?.toString();
	}
	if (json['free_throw'] != null) {
		data.spProFreeThrow = json['free_throw']?.toString();
	}
	if (json['rebound'] != null) {
		data.rebound = json['rebound']?.toString();
	}
	if (json['assist'] != null) {
		data.assist = json['assist']?.toString();
	}
	if (json['steal'] != null) {
		data.steal = json['steal']?.toString();
	}
	if (json['block_shot'] != null) {
		data.spProBlockShot = json['block_shot']?.toString();
	}
	if (json['turnover'] != null) {
		data.turnover = json['turnover']?.toString();
	}
	if (json['foul'] != null) {
		data.foul = json['foul']?.toString();
	}
	if (json['playing_time'] != null) {
		data.spProPlayingTime = json['playing_time']?.toString();
	}
	return data;
}

Map<String, dynamic> playerStatListPlayerStatListItemToJson(SPClassPlayerStatListPlayerStatListItem entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['guess_match_id'] = entity.spProGuessMatchId;
	data['shirt_number'] = entity.spProShirtNumber;
	data['player_name'] = entity.spProPlayerName;
	data['which_team'] = entity.spProWhichTeam;
	data['is_regular'] = entity.spProIsRegular;
	data['score'] = entity.score;
	data['shot'] = entity.shot;
	data['three_point'] = entity.spProThreePoint;
	data['free_throw'] = entity.spProFreeThrow;
	data['rebound'] = entity.rebound;
	data['assist'] = entity.assist;
	data['steal'] = entity.steal;
	data['block_shot'] = entity.spProBlockShot;
	data['turnover'] = entity.turnover;
	data['foul'] = entity.foul;
	data['playing_time'] = entity.spProPlayingTime;
	return data;
}

playerStatListBestPlayerListFromJson(SPClassPlayerStatListBestPlayerList data, Map<String, dynamic> json) {
	if (json['1'] != null) {
		data.oen = new SPClassPlayerStatListBestPlayerListItem().fromJson(json['1']);
	}
	if (json['2'] != null) {
		data.two = new SPClassPlayerStatListBestPlayerListItem().fromJson(json['2']);
	}
	return data;
}

Map<String, dynamic> playerStatListBestPlayerListToJson(SPClassPlayerStatListBestPlayerList entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.oen != null) {
		data['1'] = entity.oen?.toJson();
	}
	if (entity.two != null) {
		data['2'] = entity.two?.toJson();
	}
	return data;
}

playerStatListBestPlayerListItemFromJson(SPClassPlayerStatListBestPlayerListItem data, Map<String, dynamic> json) {
	if (json['score'] != null) {
		data.score = new SPClassPlayerStatListBestPlayerListScore().fromJson(json['score']);
	}
	if (json['rebound'] != null) {
		data.rebound = new SPClassPlayerStatListBestPlayerListRebound().fromJson(json['rebound']);
	}
	if (json['assist'] != null) {
		data.assist = new SPClassPlayerStatListBestPlayerListAssist().fromJson(json['assist']);
	}
	return data;
}

Map<String, dynamic> playerStatListBestPlayerListItemToJson(SPClassPlayerStatListBestPlayerListItem entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.score != null) {
		data['score'] = entity.score?.toJson();
	}
	if (entity.rebound != null) {
		data['rebound'] = entity.rebound?.toJson();
	}
	if (entity.assist != null) {
		data['assist'] = entity.assist?.toJson();
	}
	return data;
}

playerStatListBestPlayerListScoreFromJson(SPClassPlayerStatListBestPlayerListScore data, Map<String, dynamic> json) {
	if (json['score'] != null) {
		data.score = json['score']?.toString();
	}
	if (json['player_name'] != null) {
		data.spProPlayerName = json['player_name']?.toString();
	}
	return data;
}

Map<String, dynamic> playerStatListBestPlayerListScoreToJson(SPClassPlayerStatListBestPlayerListScore entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['score'] = entity.score;
	data['player_name'] = entity.spProPlayerName;
	return data;
}

playerStatListBestPlayerListReboundFromJson(SPClassPlayerStatListBestPlayerListRebound data, Map<String, dynamic> json) {
	if (json['rebound'] != null) {
		data.rebound = json['rebound']?.toString();
	}
	if (json['player_name'] != null) {
		data.spProPlayerName = json['player_name']?.toString();
	}
	return data;
}

Map<String, dynamic> playerStatListBestPlayerListReboundToJson(SPClassPlayerStatListBestPlayerListRebound entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['rebound'] = entity.rebound;
	data['player_name'] = entity.spProPlayerName;
	return data;
}

playerStatListBestPlayerListAssistFromJson(SPClassPlayerStatListBestPlayerListAssist data, Map<String, dynamic> json) {
	if (json['assist'] != null) {
		data.assist = json['assist']?.toString();
	}
	if (json['player_name'] != null) {
		data.spProPlayerName = json['player_name']?.toString();
	}
	return data;
}

Map<String, dynamic> playerStatListBestPlayerListAssistToJson(SPClassPlayerStatListBestPlayerListAssist entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['assist'] = entity.assist;
	data['player_name'] = entity.spProPlayerName;
	return data;
}

playerStatListSumFromJson(PlayerStatListSum data, Map<String, dynamic> json) {
	if (json['1'] != null) {
		data.one = new PlayerStatListSumItem().fromJson(json['1']);
	}
	if (json['2'] != null) {
		data.two = new PlayerStatListSumItem().fromJson(json['2']);
	}
	return data;
}

Map<String, dynamic> playerStatListSumToJson(PlayerStatListSum entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.one != null) {
		data['1'] = entity.one?.toJson();
	}
	if (entity.two != null) {
		data['2'] = entity.two?.toJson();
	}
	return data;
}

playerStatListSumItemFromJson(PlayerStatListSumItem data, Map<String, dynamic> json) {
	if (json['score'] != null) {
		data.score = json['score']?.toInt();
	}
	if (json['spProProgressScore'] != null) {
		data.spProProgressScore = json['spProProgressScore']?.toDouble();
	}
	if (json['rebound'] != null) {
		data.rebound = json['rebound']?.toInt();
	}
	if (json['spProProgressRebound'] != null) {
		data.spProProgressRebound = json['spProProgressRebound']?.toDouble();
	}
	if (json['assist'] != null) {
		data.assist = json['assist']?.toInt();
	}
	if (json['spProProgressAssist'] != null) {
		data.spProProgressAssist = json['spProProgressAssist']?.toDouble();
	}
	if (json['block_shot'] != null) {
		data.spProBlockShot = json['block_shot']?.toInt();
	}
	if (json['spProProgressBlockShot'] != null) {
		data.spProProgressBlockShot = json['spProProgressBlockShot']?.toDouble();
	}
	if (json['steal'] != null) {
		data.steal = json['steal']?.toInt();
	}
	if (json['spProProgressSteal'] != null) {
		data.spProProgressSteal = json['spProProgressSteal']?.toDouble();
	}
	if (json['turnover'] != null) {
		data.turnover = json['turnover']?.toInt();
	}
	if (json['spProProgressTurnover'] != null) {
		data.spProProgressTurnover = json['spProProgressTurnover']?.toDouble();
	}
	return data;
}

Map<String, dynamic> playerStatListSumItemToJson(PlayerStatListSumItem entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['score'] = entity.score;
	data['spProProgressScore'] = entity.spProProgressScore;
	data['rebound'] = entity.rebound;
	data['spProProgressRebound'] = entity.spProProgressRebound;
	data['assist'] = entity.assist;
	data['spProProgressAssist'] = entity.spProProgressAssist;
	data['block_shot'] = entity.spProBlockShot;
	data['spProProgressBlockShot'] = entity.spProProgressBlockShot;
	data['steal'] = entity.steal;
	data['spProProgressSteal'] = entity.spProProgressSteal;
	data['turnover'] = entity.turnover;
	data['spProProgressTurnover'] = entity.spProProgressTurnover;
	return data;
}