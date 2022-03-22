
import 'package:changshengh5/model/CSClassTextLiveListEntity.dart';

textLiveListEntityFromJson(CSClassTextLiveListEntity data, Map<String, dynamic> json) {
	if (json['text_live_list'] != null) {
		data.csProTextLiveList = [];
		(json['text_live_list'] as List).forEach((v) {
			data.csProTextLiveList?.add(new CSClassTextLiveListTextLiveList().fromJson(v));
		});
	}
	if (json['guess_match'] != null) {
		data.csProGuessMatch = new CSClassTextLiveListGuessMatch().fromJson(json['guess_match']);
	}
	return data;
}

Map<String, dynamic> textLiveListEntityToJson(CSClassTextLiveListEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.csProTextLiveList != null) {
		data['text_live_list'] =  entity.csProTextLiveList?.map((v) => v.toJson()).toList();
	}
	if (entity.csProGuessMatch != null) {
		data['guess_match'] = entity.csProGuessMatch?.toJson();
	}
	return data;
}

textLiveListTextLiveListFromJson(CSClassTextLiveListTextLiveList data, Map<String, dynamic> json) {
	if (json['seq_num'] != null) {
		data.csProSeqNum = json['seq_num']?.toString();
	}
	if (json['section'] != null) {
		data.section = json['section']?.toString();
	}
	if (json['left_time'] != null) {
		data.csProLeftTime = json['left_time']?.toString();
	}
	if (json['msg'] != null) {
		data.msg = json['msg']?.toString();
	}
	if (json['team_name'] != null) {
		data.csProTeamName = json['team_name']?.toString();
	}
	return data;
}

Map<String, dynamic> textLiveListTextLiveListToJson(CSClassTextLiveListTextLiveList entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['seq_num'] = entity.csProSeqNum;
	data['section'] = entity.section;
	data['left_time'] = entity.csProLeftTime;
	data['msg'] = entity.msg;
	data['team_name'] = entity.csProTeamName;
	return data;
}

textLiveListGuessMatchFromJson(CSClassTextLiveListGuessMatch data, Map<String, dynamic> json) {
	if (json['is_realtime_over'] != null) {
		data.csProIsRealtimeOver = json['is_realtime_over']?.toString();
	}
	if (json['score_one'] != null) {
		data.csProScoreOne = json['score_one']?.toString();
	}
	if (json['score_two'] != null) {
		data.csProScoreTwo = json['score_two']?.toString();
	}
	if (json['is_over'] != null) {
		data.csProIsOver = json['is_over']?.toString();
	}
	if (json['status_desc'] != null) {
		data.csProStatusDesc = json['status_desc']?.toString();
	}
	return data;
}

Map<String, dynamic> textLiveListGuessMatchToJson(CSClassTextLiveListGuessMatch entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['is_realtime_over'] = entity.csProIsRealtimeOver;
	data['score_one'] = entity.csProScoreOne;
	data['score_two'] = entity.csProScoreTwo;
	data['is_over'] = entity.csProIsOver;
	data['status_desc'] = entity.csProStatusDesc;
	return data;
}