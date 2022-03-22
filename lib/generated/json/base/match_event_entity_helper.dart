

import 'package:changshengh5/model/CSClassMatchEventEntity.dart';
import 'package:changshengh5/model/CSClassTextLiveListEntity.dart';

matchEventEntityFromJson(CSClassMatchEventEntity data, Map<String, dynamic> json) {
	if (json['match_event_list'] != null) {
		data.csProMatchEvent = [];
		(json['match_event_list'] as List).forEach((v) {
			data.csProMatchEvent?.add(new CSClassMatchEventMatchEventItem().fromJson(v));
		});
	}
	if (json['guess_match'] != null) {
		data.csProGuessMatch = new CSClassTextLiveListGuessMatch().fromJson(json['guess_match']);
	}
	return data;
}

Map<String, dynamic> matchEventEntityToJson(CSClassMatchEventEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.csProMatchEvent != null) {
		data['match_event_list'] =  entity.csProMatchEvent?.map((v) => v.toJson()).toList();
	}
	if (entity.csProGuessMatch != null) {
		data['guess_match'] = entity.csProGuessMatch?.toJson();
	}
	return data;
}

matchEventMatchEventItemFromJson(CSClassMatchEventMatchEventItem data, Map<String, dynamic> json) {
	if (json['which_team'] != null) {
		data.csProWhichTeam = json['which_team']?.toString();
	}
	if (json['event_name'] != null) {
		data.csProEventName = json['event_name']?.toString();
	}
	if (json['time'] != null) {
		data.time = json['time']?.toString();
	}
	if (json['player_name'] != null) {
		data.csProPlayerName = json['player_name']?.toString();
	}
	if (json['csProEventImage'] != null) {
		data.csProEventImage = json['csProEventImage']?.toString();
	}
	if (json['seq_num'] != null) {
		data.csProSeqNum = json['seq_num']?.toString();
	}
	return data;
}

Map<String, dynamic> matchEventMatchEventItemToJson(CSClassMatchEventMatchEventItem entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['which_team'] = entity.csProWhichTeam;
	data['event_name'] = entity.csProEventName;
	data['time'] = entity.time;
	data['player_name'] = entity.csProPlayerName;
	data['csProEventImage'] = entity.csProEventImage;
	data['seq_num'] = entity.csProSeqNum;
	return data;
}