

import 'package:changshengh5/generated/json/base/json_convert_content.dart';

class CSClassMatchTrendEntity with JsonConvert<CSClassMatchTrendEntity> {
	CSClassMatchTrendMatchTrend ?csProMatchTrend;
}

class CSClassMatchTrendMatchTrend with JsonConvert<CSClassMatchTrendMatchTrend> {
  CSClassMatchTrendMatchTrendLoad ?one;
  CSClassMatchTrendMatchTrendLoad ?two;

  List<CSClassMatchTrendMatchTrendItem> getList(CSClassMatchTrendMatchTrendLoad value){
    if(value==null){
      return [];
    }else{
      List<CSClassMatchTrendMatchTrendItem> list=[];
      list.addAll(value.zon!);
      list.addAll(value.zhu!);
      list.addAll(value.ke!);
      return list;
    }
  }
}

class CSClassMatchTrendMatchTrendLoad with JsonConvert<CSClassMatchTrendMatchTrendLoad> {
	List<CSClassMatchTrendMatchTrendItem>  ?zon;
	List<CSClassMatchTrendMatchTrendItem> ?zhu;
	List<CSClassMatchTrendMatchTrendItem>? ke;
}

class CSClassMatchTrendMatchTrendItem with JsonConvert<CSClassMatchTrendMatchTrendItem> {
	String ?csProGuessMatchId;
	String ?type;
	String ?csProMatchNum;
	String? csProWinNum;
	String ?csProDrawNum;
	String ?csProLoseNum;
	String ?csProWinRate;
	String ?csProBigNum;
	String ?csProBigRate;
	String ?csProSmallNum;
	String ?csProSmallRate;
	String ?csProWhichTeam;

}
