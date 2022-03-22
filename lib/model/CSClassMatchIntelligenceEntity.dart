
import 'package:changshengh5/generated/json/base/json_convert_content.dart';

class CSClassMatchIntelligenceEntity with JsonConvert {
	CSClassMatchIntelligenceMatchIntelligence ?csProMatchIntelligence;
}

class CSClassMatchIntelligenceMatchIntelligence with JsonConvert {
  List<CSClassMatchIntelligenceMatchIntelligenceItem> ?one;
	List<CSClassMatchIntelligenceMatchIntelligenceItem> ?two;
}
class CSClassMatchIntelligenceMatchIntelligenceItem with JsonConvert {
	String ?information;
	String ?status;
	String ?csProWhichTeam;
}


