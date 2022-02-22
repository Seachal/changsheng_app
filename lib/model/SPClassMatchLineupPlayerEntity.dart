
import 'package:changshengh5/generated/json/base/json_convert_content.dart';

class SPClassMatchLineupPlayerEntity with JsonConvert {
	SPClassMatchLineupPlayerMatchLineupPlayer ?spProMatchLineupPlayer;
}

class SPClassMatchLineupPlayerMatchLineupPlayer with JsonConvert {
  List<SPClassMatchLineupPlayerMatchLineupPlayerItem> ?one;
  List<SPClassMatchLineupPlayerMatchLineupPlayerItem> ?two;
}

class SPClassMatchLineupPlayerMatchLineupPlayerItem with JsonConvert {
	String ?spProPlayerName;
	String ?avatar;
	String ?spProShirtNumber;
	String ?spProWhichTeam;
	String ?spProIsRegular;
	String ?spProSeqNum;
}
