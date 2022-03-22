
import 'package:changshengh5/model/SPClassTextLiveListEntity.dart';

textLiveListEntityFromJson(SPClassTextLiveListEntity data, Map<String, dynamic> json) {
	if (json['text_live_list'] != null) {
		data.spProTextLiveList = [];
		(json['text_live_list'] as List).forEach((v) {
			data.spProTextLiveList?.add(new SPClassTextLiveListTextLiveList().fromJson(v));
		});
	}
	if (json['guess_match'] != null) {
		data.spProGuessMatch = new SPClassTextLiveListGuessMatch().fromJson(json['guess_match']);
	}
	return data;
}

Map<String, dynamic> textLiveListEntityToJson(SPClassTextLiveListEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.spProTextLiveList != null) {
		data['text_live_list'] =  entity.spProTextLiveList?.map((v) => v.toJson()).toList();
	}
	if (entity.spProGuessMatch != null) {
		data['guess_match'] = entity.spProGuessMatch?.toJson();
	}
	return data;
}

textLiveListTextLiveListFromJson(SPClassTextLiveListTextLiveList data, Map<String, dynamic> json) {
	if (json['seq_num'] != null) {
		data.spProSeqNum = json['seq_num']?.toString();
	}
	if (json['section'] != null) {
		data.section = json['section']?.toString();
	}
	if (json['left_time'] != null) {
		data.spProLeftTime = json['left_time']?.toString();
	}
	if (json['msg'] != null) {
		data.msg = json['msg']?.toString();
	}
	if (json['team_name'] != null) {
		data.spProTeamName = json['team_name']?.toString();
	}
	return data;
}

Map<String, dynamic> textLiveListTextLiveListToJson(SPClassTextLiveListTextLiveList entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['seq_num'] = entity.spProSeqNum;
	data['section'] = entity.section;
	data['left_time'] = entity.spProLeftTime;
	data['msg'] = entity.msg;
	data['team_name'] = entity.spProTeamName;
	return data;
}

textLiveListGuessMatchFromJson(SPClassTextLiveListGuessMatch data, Map<String, dynamic> json) {
	if (json['is_realtime_over'] != null) {
		data.spProIsRealtimeOver = json['is_realtime_over']?.toString();
	}
	if (json['score_one'] != null) {
		data.spProScoreOne = json['score_one']?.toString();
	}
	if (json['score_two'] != null) {
		data.spProScoreTwo = json['score_two']?.toString();
	}
	if (json['is_over'] != null) {
		data.spProIsOver = json['is_over']?.toString();
	}
	if (json['status_desc'] != null) {
		data.spProStatusDesc = json['status_desc']?.toString();
	}
	return data;
}

Map<String, dynamic> textLiveListGuessMatchToJson(SPClassTextLiveListGuessMatch entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['is_realtime_over'] = entity.spProIsRealtimeOver;
	data['score_one'] = entity.spProScoreOne;
	data['score_two'] = entity.spProScoreTwo;
	data['is_over'] = entity.spProIsOver;
	data['status_desc'] = entity.spProStatusDesc;
	return data;
}