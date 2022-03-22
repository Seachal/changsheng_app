

import 'package:changshengh5/generated/json/base/json_convert_content.dart';

import 'CSClassTextLiveListEntity.dart';



class CSClassMatchEventEntity with JsonConvert {
  List<CSClassMatchEventMatchEventItem> ?csProMatchEvent;
  CSClassTextLiveListGuessMatch ?csProGuessMatch;
}

class CSClassMatchEventMatchEventItem with JsonConvert {
	String ?csProWhichTeam;
	String ?csProEventName;
	String ?time;
	String ?csProPlayerName;
	String ?csProEventImage;
  String ?csProSeqNum;
  String csProTeamOneScore="0";
  String csProTeamTwoScore="0";
  String content="";

}


