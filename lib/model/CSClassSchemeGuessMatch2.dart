class CSClassSchemeGuessMatch2 {
  String ?csProGuessMatchId;
  String ?csProLeagueName;
  String ?csProTeamOne;
  String ?csProTeamTwo;
  String ?csProStTime;

  CSClassSchemeGuessMatch2({Map<String, dynamic>? json}) {
    if (json != null) {
      fromJson(json);
    }
  }

  fromJson(Map<String, dynamic> json) {
    csProGuessMatchId = json["guess_match_id"]?.toString();
    csProTeamOne = json["team_one"]?.toString();
    csProTeamTwo = json["team_two"]?.toString();
    csProStTime = json["st_time"]?.toString();
    csProStTime = json["st_time"]?.toString();
    csProLeagueName=json["league_name"]?.toString();

  }


  CSClassSchemeGuessMatch2.newObject(this.csProGuessMatchId, this.csProLeagueName, this.csProTeamOne,
      this.csProTeamTwo, this.csProStTime);

  copyObject({dynamic json}){
    return new CSClassSchemeGuessMatch2(json: json);
  }
}
