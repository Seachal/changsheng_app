class SPClassSchemePlayWay{
  String ?spProGuessType;
  String ?spProPlayingWay;
  String ?spProWinOddsOne;
  String ?spProDrawOdds;
  String ?spProWinOddsTwo;
  String ?spProAddScore;
  String ?spProAddScoreDesc;
  String ?spProMidScore;
  String ?spProBattleIndex;

  SPClassSchemePlayWay({Map ?json}) {
  if (json != null) {
  fromJson(json);
  }
  }

  fromJson(Map<dynamic, dynamic> json) {
    spProGuessType = json["guess_type"]?.toString();
    spProPlayingWay = json["playing_way"]?.toString();
    spProWinOddsOne = json["win_odds_one"]?.toString();
    spProDrawOdds = json["draw_odds"]?.toString();
    spProWinOddsTwo = json["win_odds_two"]?.toString();
    spProAddScore = json["add_score"]?.toString();
    spProAddScoreDesc = json["add_score_desc"]?.toString();
    spProMidScore = json["mid_score"]?.toString();
    spProBattleIndex = json["battle_index"]?.toString();
  }

  copyObject({dynamic json}){
  return new SPClassSchemePlayWay(json: json);
  }
}