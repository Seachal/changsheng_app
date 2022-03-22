
import 'package:changshengh5/generated/json/base/json_convert_content.dart';

class CSClassMatchInjuryEntity with JsonConvert {
	CSClassMatchInjuryMatchInjury ?csProMatchInjury;
}

class CSClassMatchInjuryMatchInjury with JsonConvert {
  List<CSClassMatchInjuryMatchInjuryItem> ?one;
  List<CSClassMatchInjuryMatchInjuryItem> ?two;
}

class CSClassMatchInjuryMatchInjuryItem with JsonConvert {
	String ?csProWhichTeam;
	String ?reason;
	String ?csProPlayerName;
	String ?csProShirtNumber;
}


