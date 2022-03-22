import 'package:changshengh5/generated/json/base/json_convert_content.dart';


class SPClassMatchTrendRecentEntity with JsonConvert<SPClassMatchTrendRecentEntity> {
	SPClassMatchTrendRecentMatchTrendRecent? spProMatchTrendRecent;
}

class SPClassMatchTrendRecentMatchTrendRecent with JsonConvert<SPClassMatchTrendRecentMatchTrendRecent> {
  List<SPClassMatchTrendRecentMatchTrendRecentItem>? one;
  List<SPClassMatchTrendRecentMatchTrendRecentItem> ?two;
}

class SPClassMatchTrendRecentMatchTrendRecentItem with JsonConvert<SPClassMatchTrendRecentMatchTrendRecentItem> {
	String ?spProYaPanResult;
	String ?spProDaXiaoResult;
	String ?spProWinRate;
	String? spProWhichTeam;
}


