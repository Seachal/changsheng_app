
import 'package:changshengh5/model/CSClassPlayerStatListEntity.dart';

playerStatListEntityFromJson(CSClassPlayerStatListEntity data, Map<String, dynamic> json) {
	if (json['has_data'] != null) {
		data.csProHasData = json['has_data'];
	}
	if (json['player_stat_list'] != null) {
		data.csProPlayerStatList = new CSClassPlayerStatListPlayerStatList().fromJson(json['player_stat_list']);
	}
	if (json['best_player_list'] != null) {
		data.csProBestPlayerList = new CSClassPlayerStatListBestPlayerList().fromJson(json['best_player_list']);
	}
	if (json['sum'] != null) {
		data.sum = new PlayerStatListSum().fromJson(json['sum']);
	}
	return data;
}

Map<String, dynamic> playerStatListEntityToJson(CSClassPlayerStatListEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['has_data'] = entity.csProHasData;
	if (entity.csProPlayerStatList != null) {
		data['player_stat_list'] = entity.csProPlayerStatList?.toJson();
	}
	if (entity.csProBestPlayerList != null) {
		data['best_player_list'] = entity.csProBestPlayerList?.toJson();
	}
	if (entity.sum != null) {
		data['sum'] = entity.sum?.toJson();
	}
	return data;
}

playerStatListPlayerStatListFromJson(CSClassPlayerStatListPlayerStatList data, Map<String, dynamic> json) {
	if (json['1'] != null) {
		data.one = [];
		(json['1'] as List).forEach((v) {
			data.one?.add(new CSClassPlayerStatListPlayerStatListItem().fromJson(v));
		});
	}
	if (json['2'] != null) {
		data.two =[];
		(json['2'] as List).forEach((v) {
			data.two?.add(new CSClassPlayerStatListPlayerStatListItem().fromJson(v));
		});
	}
	return data;
}

Map<String, dynamic> playerStatListPlayerStatListToJson(CSClassPlayerStatListPlayerStatList entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.one != null) {
		data['1'] =  entity.one?.map((v) => v.toJson()).toList();
	}
	if (entity.two != null) {
		data['2'] =  entity.two?.map((v) => v.toJson()).toList();
	}
	return data;
}

playerStatListPlayerStatListItemFromJson(CSClassPlayerStatListPlayerStatListItem data, Map<String, dynamic> json) {
	if (json['guess_match_id'] != null) {
		data.csProGuessMatchId = json['guess_match_id']?.toString();
	}
	if (json['shirt_number'] != null) {
		data.csProShirtNumber = json['shirt_number']?.toString();
	}
	if (json['player_name'] != null) {
		data.csProPlayerName = json['player_name']?.toString();
	}
	if (json['which_team'] != null) {
		data.csProWhichTeam = json['which_team']?.toString();
	}
	if (json['is_regular'] != null) {
		data.csProIsRegular = json['is_regular']?.toString();
	}
	if (json['score'] != null) {
		data.score = json['score']?.toString();
	}
	if (json['shot'] != null) {
		data.shot = json['shot']?.toString();
	}
	if (json['three_point'] != null) {
		data.csProThreePoint = json['three_point']?.toString();
	}
	if (json['free_throw'] != null) {
		data.csProFreeThrow = json['free_throw']?.toString();
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
		data.csProBlockShot = json['block_shot']?.toString();
	}
	if (json['turnover'] != null) {
		data.turnover = json['turnover']?.toString();
	}
	if (json['foul'] != null) {
		data.foul = json['foul']?.toString();
	}
	if (json['playing_time'] != null) {
		data.csProPlayingTime = json['playing_time']?.toString();
	}
	return data;
}

Map<String, dynamic> playerStatListPlayerStatListItemToJson(CSClassPlayerStatListPlayerStatListItem entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['guess_match_id'] = entity.csProGuessMatchId;
	data['shirt_number'] = entity.csProShirtNumber;
	data['player_name'] = entity.csProPlayerName;
	data['which_team'] = entity.csProWhichTeam;
	data['is_regular'] = entity.csProIsRegular;
	data['score'] = entity.score;
	data['shot'] = entity.shot;
	data['three_point'] = entity.csProThreePoint;
	data['free_throw'] = entity.csProFreeThrow;
	data['rebound'] = entity.rebound;
	data['assist'] = entity.assist;
	data['steal'] = entity.steal;
	data['block_shot'] = entity.csProBlockShot;
	data['turnover'] = entity.turnover;
	data['foul'] = entity.foul;
	data['playing_time'] = entity.csProPlayingTime;
	return data;
}

playerStatListBestPlayerListFromJson(CSClassPlayerStatListBestPlayerList data, Map<String, dynamic> json) {
	if (json['1'] != null) {
		data.oen = new CSClassPlayerStatListBestPlayerListItem().fromJson(json['1']);
	}
	if (json['2'] != null) {
		data.two = new CSClassPlayerStatListBestPlayerListItem().fromJson(json['2']);
	}
	return data;
}

Map<String, dynamic> playerStatListBestPlayerListToJson(CSClassPlayerStatListBestPlayerList entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.oen != null) {
		data['1'] = entity.oen?.toJson();
	}
	if (entity.two != null) {
		data['2'] = entity.two?.toJson();
	}
	return data;
}

playerStatListBestPlayerListItemFromJson(CSClassPlayerStatListBestPlayerListItem data, Map<String, dynamic> json) {
	if (json['score'] != null) {
		data.score = new CSClassPlayerStatListBestPlayerListScore().fromJson(json['score']);
	}
	if (json['rebound'] != null) {
		data.rebound = new CSClassPlayerStatListBestPlayerListRebound().fromJson(json['rebound']);
	}
	if (json['assist'] != null) {
		data.assist = new CSClassPlayerStatListBestPlayerListAssist().fromJson(json['assist']);
	}
	return data;
}

Map<String, dynamic> playerStatListBestPlayerListItemToJson(CSClassPlayerStatListBestPlayerListItem entity) {
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

playerStatListBestPlayerListScoreFromJson(CSClassPlayerStatListBestPlayerListScore data, Map<String, dynamic> json) {
	if (json['score'] != null) {
		data.score = json['score']?.toString();
	}
	if (json['player_name'] != null) {
		data.csProPlayerName = json['player_name']?.toString();
	}
	return data;
}

Map<String, dynamic> playerStatListBestPlayerListScoreToJson(CSClassPlayerStatListBestPlayerListScore entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['score'] = entity.score;
	data['player_name'] = entity.csProPlayerName;
	return data;
}

playerStatListBestPlayerListReboundFromJson(CSClassPlayerStatListBestPlayerListRebound data, Map<String, dynamic> json) {
	if (json['rebound'] != null) {
		data.rebound = json['rebound']?.toString();
	}
	if (json['player_name'] != null) {
		data.csProPlayerName = json['player_name']?.toString();
	}
	return data;
}

Map<String, dynamic> playerStatListBestPlayerListReboundToJson(CSClassPlayerStatListBestPlayerListRebound entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['rebound'] = entity.rebound;
	data['player_name'] = entity.csProPlayerName;
	return data;
}

playerStatListBestPlayerListAssistFromJson(CSClassPlayerStatListBestPlayerListAssist data, Map<String, dynamic> json) {
	if (json['assist'] != null) {
		data.assist = json['assist']?.toString();
	}
	if (json['player_name'] != null) {
		data.csProPlayerName = json['player_name']?.toString();
	}
	return data;
}

Map<String, dynamic> playerStatListBestPlayerListAssistToJson(CSClassPlayerStatListBestPlayerListAssist entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['assist'] = entity.assist;
	data['player_name'] = entity.csProPlayerName;
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
	if (json['csProProgressScore'] != null) {
		data.csProProgressScore = json['csProProgressScore']?.toDouble();
	}
	if (json['rebound'] != null) {
		data.rebound = json['rebound']?.toInt();
	}
	if (json['csProProgressRebound'] != null) {
		data.csProProgressRebound = json['csProProgressRebound']?.toDouble();
	}
	if (json['assist'] != null) {
		data.assist = json['assist']?.toInt();
	}
	if (json['csProProgressAssist'] != null) {
		data.csProProgressAssist = json['csProProgressAssist']?.toDouble();
	}
	if (json['block_shot'] != null) {
		data.csProBlockShot = json['block_shot']?.toInt();
	}
	if (json['csProProgressBlockShot'] != null) {
		data.csProProgressBlockShot = json['csProProgressBlockShot']?.toDouble();
	}
	if (json['steal'] != null) {
		data.steal = json['steal']?.toInt();
	}
	if (json['csProProgressSteal'] != null) {
		data.csProProgressSteal = json['csProProgressSteal']?.toDouble();
	}
	if (json['turnover'] != null) {
		data.turnover = json['turnover']?.toInt();
	}
	if (json['csProProgressTurnover'] != null) {
		data.csProProgressTurnover = json['csProProgressTurnover']?.toDouble();
	}
	return data;
}

Map<String, dynamic> playerStatListSumItemToJson(PlayerStatListSumItem entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['score'] = entity.score;
	data['csProProgressScore'] = entity.csProProgressScore;
	data['rebound'] = entity.rebound;
	data['csProProgressRebound'] = entity.csProProgressRebound;
	data['assist'] = entity.assist;
	data['csProProgressAssist'] = entity.csProProgressAssist;
	data['block_shot'] = entity.csProBlockShot;
	data['csProProgressBlockShot'] = entity.csProProgressBlockShot;
	data['steal'] = entity.steal;
	data['csProProgressSteal'] = entity.csProProgressSteal;
	data['turnover'] = entity.turnover;
	data['csProProgressTurnover'] = entity.csProProgressTurnover;
	return data;
}