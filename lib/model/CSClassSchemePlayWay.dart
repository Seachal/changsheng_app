class CSClassSchemePlayWay{
  String ?csProGuessType;
  String ?csProPlayingWay;
  String ?csProWinOddsOne;
  String ?csProDrawOdds;
  String ?csProWinOddsTwo;
  String ?csProAddScore;
  String ?csProAddScoreDesc;
  String ?csProMidScore;
  String ?csProBattleIndex;

  CSClassSchemePlayWay({Map ?json}) {
  if (json != null) {
  fromJson(json);
  }
  }

  fromJson(Map<dynamic, dynamic> json) {
    csProGuessType = json["guess_type"]?.toString();
    csProPlayingWay = json["playing_way"]?.toString();
    csProWinOddsOne = json["win_odds_one"]?.toString();
    csProDrawOdds = json["draw_odds"]?.toString();
    csProWinOddsTwo = json["win_odds_two"]?.toString();
    csProAddScore = json["add_score"]?.toString();
    csProAddScoreDesc = json["add_score_desc"]?.toString();
    csProMidScore = json["mid_score"]?.toString();
    csProBattleIndex = json["battle_index"]?.toString();
  }

  copyObject({dynamic json}){
  return new CSClassSchemePlayWay(json: json);
  }
}