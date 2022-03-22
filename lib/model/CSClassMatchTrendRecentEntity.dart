import 'package:changshengh5/generated/json/base/json_convert_content.dart';


class CSClassMatchTrendRecentEntity with JsonConvert<CSClassMatchTrendRecentEntity> {
	CSClassMatchTrendRecentMatchTrendRecent? csProMatchTrendRecent;
}

class CSClassMatchTrendRecentMatchTrendRecent with JsonConvert<CSClassMatchTrendRecentMatchTrendRecent> {
  List<CSClassMatchTrendRecentMatchTrendRecentItem>? one;
  List<CSClassMatchTrendRecentMatchTrendRecentItem> ?two;
}

class CSClassMatchTrendRecentMatchTrendRecentItem with JsonConvert<CSClassMatchTrendRecentMatchTrendRecentItem> {
	String ?csProYaPanResult;
	String ?csProDaXiaoResult;
	String ?csProWinRate;
	String? csProWhichTeam;
}


