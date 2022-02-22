

import 'package:changshengh5/generated/json/base/json_convert_content.dart';

class SPClassMatchStatListEntity with JsonConvert {
	List<SPClassMatchStatListMatchStat> ?spProMatchStat;
}

class SPClassMatchStatListMatchStat with JsonConvert {
	String ?spProStatType;
	String ?spProTeamOneVal;
	String ?spProTeamTwoVal;
	double ?spProProgressOne;
	double ?spProProgressTwo;
}
