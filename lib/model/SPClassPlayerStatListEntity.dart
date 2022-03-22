
import 'package:changshengh5/generated/json/base/json_convert_content.dart';

class SPClassPlayerStatListEntity with JsonConvert<SPClassPlayerStatListEntity> {
	bool ?spProHasData;
	SPClassPlayerStatListPlayerStatList ?spProPlayerStatList;
	SPClassPlayerStatListBestPlayerList ?spProBestPlayerList;
	PlayerStatListSum ?sum;
}

class SPClassPlayerStatListPlayerStatList with JsonConvert<SPClassPlayerStatListPlayerStatList> {
  List<SPClassPlayerStatListPlayerStatListItem> ?one;
  List<SPClassPlayerStatListPlayerStatListItem> ?two;
}

class SPClassPlayerStatListPlayerStatListItem with JsonConvert<SPClassPlayerStatListPlayerStatListItem> {
	String? spProGuessMatchId;
	String ?spProShirtNumber;
	String ?spProPlayerName;
	String ?spProWhichTeam;
	String ?spProIsRegular;
	String ?score;
	String ?shot;
	String ?spProThreePoint;
	String ?spProFreeThrow;
	String ?rebound;
	String ?assist;
	String ?steal;
	String ?spProBlockShot;
	String ?turnover;
	String ?foul;
	String ?spProPlayingTime;
}


class SPClassPlayerStatListBestPlayerList with JsonConvert<SPClassPlayerStatListBestPlayerList> {
  SPClassPlayerStatListBestPlayerListItem ?oen;
  SPClassPlayerStatListBestPlayerListItem ?two;
}

class SPClassPlayerStatListBestPlayerListItem with JsonConvert<SPClassPlayerStatListBestPlayerListItem> {
	SPClassPlayerStatListBestPlayerListScore ?score;
	SPClassPlayerStatListBestPlayerListRebound ?rebound;
	SPClassPlayerStatListBestPlayerListAssist ?assist;
}

class SPClassPlayerStatListBestPlayerListScore with JsonConvert<SPClassPlayerStatListBestPlayerListScore> {
	String ?score;
	String ?spProPlayerName;
}

class SPClassPlayerStatListBestPlayerListRebound with JsonConvert<SPClassPlayerStatListBestPlayerListRebound> {
	String ?rebound;
	String ?spProPlayerName;
}

class SPClassPlayerStatListBestPlayerListAssist with JsonConvert<SPClassPlayerStatListBestPlayerListAssist> {
	String? assist;
	String ?spProPlayerName;
}



class PlayerStatListSum with JsonConvert<PlayerStatListSum> {
  PlayerStatListSumItem ?one;
  PlayerStatListSumItem? two;
}

class PlayerStatListSumItem with JsonConvert<PlayerStatListSumItem> {
	int ?score;
	double spProProgressScore=0;
	int ?rebound;
  double spProProgressRebound=0;
  int? assist;
  double spProProgressAssist=0;
	int? spProBlockShot;
  double spProProgressBlockShot=0;
  int ?steal;
  double spProProgressSteal=0;
  int? turnover;
  double spProProgressTurnover=0;
}


