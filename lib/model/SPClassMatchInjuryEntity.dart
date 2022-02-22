
import 'package:changshengh5/generated/json/base/json_convert_content.dart';

class SPClassMatchInjuryEntity with JsonConvert {
	SPClassMatchInjuryMatchInjury ?spProMatchInjury;
}

class SPClassMatchInjuryMatchInjury with JsonConvert {
  List<SPClassMatchInjuryMatchInjuryItem> ?one;
  List<SPClassMatchInjuryMatchInjuryItem> ?two;
}

class SPClassMatchInjuryMatchInjuryItem with JsonConvert {
	String ?spProWhichTeam;
	String ?reason;
	String ?spProPlayerName;
	String ?spProShirtNumber;
}


