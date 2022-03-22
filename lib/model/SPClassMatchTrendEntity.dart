

import 'package:changshengh5/generated/json/base/json_convert_content.dart';

class SPClassMatchTrendEntity with JsonConvert<SPClassMatchTrendEntity> {
	SPClassMatchTrendMatchTrend ?spProMatchTrend;
}

class SPClassMatchTrendMatchTrend with JsonConvert<SPClassMatchTrendMatchTrend> {
  SPClassMatchTrendMatchTrendLoad ?one;
  SPClassMatchTrendMatchTrendLoad ?two;

  List<SPClassMatchTrendMatchTrendItem> getList(SPClassMatchTrendMatchTrendLoad value){
    if(value==null){
      return [];
    }else{
      List<SPClassMatchTrendMatchTrendItem> list=[];
      list.addAll(value.zon!);
      list.addAll(value.zhu!);
      list.addAll(value.ke!);
      return list;
    }
  }
}

class SPClassMatchTrendMatchTrendLoad with JsonConvert<SPClassMatchTrendMatchTrendLoad> {
	List<SPClassMatchTrendMatchTrendItem>  ?zon;
	List<SPClassMatchTrendMatchTrendItem> ?zhu;
	List<SPClassMatchTrendMatchTrendItem>? ke;
}

class SPClassMatchTrendMatchTrendItem with JsonConvert<SPClassMatchTrendMatchTrendItem> {
	String ?spProGuessMatchId;
	String ?type;
	String ?spProMatchNum;
	String? spProWinNum;
	String ?spProDrawNum;
	String ?spProLoseNum;
	String ?spProWinRate;
	String ?spProBigNum;
	String ?spProBigRate;
	String ?spProSmallNum;
	String ?spProSmallRate;
	String ?spProWhichTeam;

}
