
import 'package:changshengh5/generated/json/base/json_convert_content.dart';

class SPClassMatchIntelligenceEntity with JsonConvert {
	SPClassMatchIntelligenceMatchIntelligence ?spProMatchIntelligence;
}

class SPClassMatchIntelligenceMatchIntelligence with JsonConvert {
  List<SPClassMatchIntelligenceMatchIntelligenceItem> ?one;
	List<SPClassMatchIntelligenceMatchIntelligenceItem> ?two;
}
class SPClassMatchIntelligenceMatchIntelligenceItem with JsonConvert {
	String ?information;
	String ?status;
	String ?spProWhichTeam;
}


