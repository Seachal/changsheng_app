
import 'package:changshengh5/generated/json/base/json_convert_content.dart';

class CSClassTextLiveListEntity with JsonConvert {
	List<CSClassTextLiveListTextLiveList> ?csProTextLiveList;
	CSClassTextLiveListGuessMatch ?csProGuessMatch;
}

class CSClassTextLiveListTextLiveList with JsonConvert {
	String ?csProSeqNum;
	String ?section;
	String ?csProLeftTime;
	String ?msg;
	String ?csProTeamName;
}

class CSClassTextLiveListGuessMatch with JsonConvert {
	String ?csProIsRealtimeOver;
	String ?csProScoreOne;
	String ?csProScoreTwo;
	String ?csProIsOver;
	String ?csProStatusDesc;
}
