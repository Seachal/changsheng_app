
import 'package:changshengh5/generated/json/base/json_convert_content.dart';

class CSClassMatchLineupEntity with JsonConvert {
	List<CSClassMatchLineupMatchLineup>? csProMatchLineup;
}

class CSClassMatchLineupMatchLineup with JsonConvert {
	String ?csProTeamOneLineup;
	String ?csProTeamTwoLineup;
}
