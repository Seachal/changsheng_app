

import 'package:changshengh5/model/SPClassMatchEventEntity.dart';
import 'package:changshengh5/model/SPClassTextLiveListEntity.dart';

matchEventEntityFromJson(SPClassMatchEventEntity data, Map<String, dynamic> json) {
	if (json['match_event_list'] != null) {
		data.spProMatchEvent = [];
		(json['match_event_list'] as List).forEach((v) {
			data.spProMatchEvent?.add(new SPClassMatchEventMatchEventItem().fromJson(v));
		});
	}
	if (json['guess_match'] != null) {
		data.spProGuessMatch = new SPClassTextLiveListGuessMatch().fromJson(json['guess_match']);
	}
	return data;
}

Map<String, dynamic> matchEventEntityToJson(SPClassMatchEventEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.spProMatchEvent != null) {
		data['match_event_list'] =  entity.spProMatchEvent?.map((v) => v.toJson()).toList();
	}
	if (entity.spProGuessMatch != null) {
		data['guess_match'] = entity.spProGuessMatch?.toJson();
	}
	return data;
}

matchEventMatchEventItemFromJson(SPClassMatchEventMatchEventItem data, Map<String, dynamic> json) {
	if (json['which_team'] != null) {
		data.spProWhichTeam = json['which_team']?.toString();
	}
	if (json['event_name'] != null) {
		data.spProEventName = json['event_name']?.toString();
	}
	if (json['time'] != null) {
		data.time = json['time']?.toString();
	}
	if (json['player_name'] != null) {
		data.spProPlayerName = json['player_name']?.toString();
	}
	if (json['spProEventImage'] != null) {
		data.spProEventImage = json['spProEventImage']?.toString();
	}
	if (json['seq_num'] != null) {
		data.spProSeqNum = json['seq_num']?.toString();
	}
	return data;
}

Map<String, dynamic> matchEventMatchEventItemToJson(SPClassMatchEventMatchEventItem entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['which_team'] = entity.spProWhichTeam;
	data['event_name'] = entity.spProEventName;
	data['time'] = entity.time;
	data['player_name'] = entity.spProPlayerName;
	data['spProEventImage'] = entity.spProEventImage;
	data['seq_num'] = entity.spProSeqNum;
	return data;
}