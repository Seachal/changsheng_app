class SPClassLeagueFilter {
  List<String> spProHotLeagueList = [];
  List<SPClassLeagueName> spProLeagueList = [];

  SPClassLeagueFilter({Map ?json}) {
    if (json != null) {
      fromJson(json);
    }
  }

  fromJson(Map<dynamic, dynamic> json) {
    spProLeagueList.clear();
    spProHotLeagueList.clear();

    json["league_list"]?.forEach((childJson) {
      spProLeagueList.add(SPClassLeagueName(json: childJson));
    });
    json["hot_league_list"]?.forEach((childJson) {
      spProHotLeagueList.add(childJson.toString());
    });
  }

  copyObject({dynamic json}) {
    return new SPClassLeagueFilter(json: json);
  }
}

class SPClassLeagueName {
  String ?spProMatchCnt;
  String ?spProLeagueName;
  String ?spProPinyinInitial;
  String ?spProIsHot;
  bool check = false;

  SPClassLeagueName({Map ?json}) {
    if (json != null) {
      fromJson(json);
    }
  }

  fromJson(Map<dynamic, dynamic> json) {
    if (json["match_cnt"] != null) {
      spProMatchCnt = json["match_cnt"]?.toString();
    }
    if (json["cnt"] != null) {
      spProMatchCnt = json["cnt"]?.toString();
    }
    spProIsHot = json["is_hot"]?.toString();
    spProLeagueName = json["league_name"]?.toString();
    spProPinyinInitial = json["pinyin_initial"]?.toString();
  }

  copyObject({dynamic json}) {
    return new SPClassLeagueName(json: json);
  }
}
