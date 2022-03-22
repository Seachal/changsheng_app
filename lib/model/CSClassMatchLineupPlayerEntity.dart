
import 'package:changshengh5/generated/json/base/json_convert_content.dart';

class CSClassMatchLineupPlayerEntity with JsonConvert {
	CSClassMatchLineupPlayerMatchLineupPlayer ?csProMatchLineupPlayer;
}

class CSClassMatchLineupPlayerMatchLineupPlayer with JsonConvert {
  List<CSClassMatchLineupPlayerMatchLineupPlayerItem> ?one;
  List<CSClassMatchLineupPlayerMatchLineupPlayerItem> ?two;
}

class CSClassMatchLineupPlayerMatchLineupPlayerItem with JsonConvert {
	String ?csProPlayerName;
	String ?avatar;
	String ?csProShirtNumber;
	String ?csProWhichTeam;
	String ?csProIsRegular;
	String ?csProSeqNum;
}
