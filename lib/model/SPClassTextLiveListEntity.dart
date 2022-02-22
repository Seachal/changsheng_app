
import 'package:changshengh5/generated/json/base/json_convert_content.dart';

class SPClassTextLiveListEntity with JsonConvert {
	List<SPClassTextLiveListTextLiveList> ?spProTextLiveList;
	SPClassTextLiveListGuessMatch ?spProGuessMatch;
}

class SPClassTextLiveListTextLiveList with JsonConvert {
	String ?spProSeqNum;
	String ?section;
	String ?spProLeftTime;
	String ?msg;
	String ?spProTeamName;
}

class SPClassTextLiveListGuessMatch with JsonConvert {
	String ?spProIsRealtimeOver;
	String ?spProScoreOne;
	String ?spProScoreTwo;
	String ?spProIsOver;
	String ?spProStatusDesc;
}
