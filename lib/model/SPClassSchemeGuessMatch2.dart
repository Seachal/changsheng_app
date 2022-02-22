class SPClassSchemeGuessMatch2 {
  String ?spProGuessMatchId;
  String ?spProLeagueName;
  String ?spProTeamOne;
  String ?spProTeamTwo;
  String ?spProStTime;

  SPClassSchemeGuessMatch2({Map<String, dynamic>? json}) {
    if (json != null) {
      fromJson(json);
    }
  }

  fromJson(Map<String, dynamic> json) {
    spProGuessMatchId = json["guess_match_id"]?.toString();
    spProTeamOne = json["team_one"]?.toString();
    spProTeamTwo = json["team_two"]?.toString();
    spProStTime = json["st_time"]?.toString();
    spProStTime = json["st_time"]?.toString();
    spProLeagueName=json["league_name"]?.toString();

  }


  SPClassSchemeGuessMatch2.newObject(this.spProGuessMatchId, this.spProLeagueName, this.spProTeamOne,
      this.spProTeamTwo, this.spProStTime);

  copyObject({dynamic json}){
    return new SPClassSchemeGuessMatch2(json: json);
  }
}
