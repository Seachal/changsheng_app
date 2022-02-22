
import 'package:changshengh5/generated/json/base/json_convert_content.dart';

class SPClassMatchLineupEntity with JsonConvert {
	List<SPClassMatchLineupMatchLineup>? spProMatchLineup;
}

class SPClassMatchLineupMatchLineup with JsonConvert {
	String ?spProTeamOneLineup;
	String ?spProTeamTwoLineup;
}
