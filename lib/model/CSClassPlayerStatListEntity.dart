
import 'package:changshengh5/generated/json/base/json_convert_content.dart';

class CSClassPlayerStatListEntity with JsonConvert<CSClassPlayerStatListEntity> {
	bool ?csProHasData;
	CSClassPlayerStatListPlayerStatList ?csProPlayerStatList;
	CSClassPlayerStatListBestPlayerList ?csProBestPlayerList;
	PlayerStatListSum ?sum;
}

class CSClassPlayerStatListPlayerStatList with JsonConvert<CSClassPlayerStatListPlayerStatList> {
  List<CSClassPlayerStatListPlayerStatListItem> ?one;
  List<CSClassPlayerStatListPlayerStatListItem> ?two;
}

class CSClassPlayerStatListPlayerStatListItem with JsonConvert<CSClassPlayerStatListPlayerStatListItem> {
	String? csProGuessMatchId;
	String ?csProShirtNumber;
	String ?csProPlayerName;
	String ?csProWhichTeam;
	String ?csProIsRegular;
	String ?score;
	String ?shot;
	String ?csProThreePoint;
	String ?csProFreeThrow;
	String ?rebound;
	String ?assist;
	String ?steal;
	String ?csProBlockShot;
	String ?turnover;
	String ?foul;
	String ?csProPlayingTime;
}


class CSClassPlayerStatListBestPlayerList with JsonConvert<CSClassPlayerStatListBestPlayerList> {
  CSClassPlayerStatListBestPlayerListItem ?oen;
  CSClassPlayerStatListBestPlayerListItem ?two;
}

class CSClassPlayerStatListBestPlayerListItem with JsonConvert<CSClassPlayerStatListBestPlayerListItem> {
	CSClassPlayerStatListBestPlayerListScore ?score;
	CSClassPlayerStatListBestPlayerListRebound ?rebound;
	CSClassPlayerStatListBestPlayerListAssist ?assist;
}

class CSClassPlayerStatListBestPlayerListScore with JsonConvert<CSClassPlayerStatListBestPlayerListScore> {
	String ?score;
	String ?csProPlayerName;
}

class CSClassPlayerStatListBestPlayerListRebound with JsonConvert<CSClassPlayerStatListBestPlayerListRebound> {
	String ?rebound;
	String ?csProPlayerName;
}

class CSClassPlayerStatListBestPlayerListAssist with JsonConvert<CSClassPlayerStatListBestPlayerListAssist> {
	String? assist;
	String ?csProPlayerName;
}



class PlayerStatListSum with JsonConvert<PlayerStatListSum> {
  PlayerStatListSumItem ?one;
  PlayerStatListSumItem? two;
}

class PlayerStatListSumItem with JsonConvert<PlayerStatListSumItem> {
	int ?score;
	double csProProgressScore=0;
	int ?rebound;
  double csProProgressRebound=0;
  int? assist;
  double csProProgressAssist=0;
	int? csProBlockShot;
  double csProProgressBlockShot=0;
  int ?steal;
  double csProProgressSteal=0;
  int? turnover;
  double csProProgressTurnover=0;
}


