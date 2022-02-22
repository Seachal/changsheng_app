

import 'package:changshengh5/generated/json/base/json_convert_content.dart';

import 'SPClassTextLiveListEntity.dart';

class SPClassMatchEventEntity with JsonConvert {
  List<SPClassMatchEventMatchEventItem> ?spProMatchEvent;
  SPClassTextLiveListGuessMatch ?spProGuessMatch;
}

class SPClassMatchEventMatchEventItem with JsonConvert {
	String ?spProWhichTeam;
	String ?spProEventName;
	String ?time;
	String ?spProPlayerName;
	String ?spProEventImage;
  String ?spProSeqNum;
  String spProTeamOneScore="0";
  String spProTeamTwoScore="0";
  String content="";

}


