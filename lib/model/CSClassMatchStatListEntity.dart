

import 'package:changshengh5/generated/json/base/json_convert_content.dart';

class CSClassMatchStatListEntity with JsonConvert {
	List<CSClassMatchStatListMatchStat> ?csProMatchStat;
}

class CSClassMatchStatListMatchStat with JsonConvert {
	String ?csProStatType;
	String ?csProTeamOneVal;
	String ?csProTeamTwoVal;
	double ?csProProgressOne;
	double ?csProProgressTwo;
}
