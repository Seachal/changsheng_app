class CSClassLeagueFilter {
  List<String> csProHotLeagueList = [];
  List<CSClassLeagueName> csProLeagueList = [];

  CSClassLeagueFilter({Map ?json}) {
    if (json != null) {
      fromJson(json);
    }
  }

  fromJson(Map<dynamic, dynamic> json) {
    csProLeagueList.clear();
    csProHotLeagueList.clear();

    json["league_list"]?.forEach((childJson) {
      csProLeagueList.add(CSClassLeagueName(json: childJson));
    });
    json["hot_league_list"]?.forEach((childJson) {
      csProHotLeagueList.add(childJson.toString());
    });
  }

  copyObject({dynamic json}) {
    return new CSClassLeagueFilter(json: json);
  }
}

class CSClassLeagueName {
  String ?csProMatchCnt;
  String ?csProLeagueName;
  String ?csProPinyinInitial;
  String ?csProIsHot;
  bool check = false;

  CSClassLeagueName({Map ?json}) {
    if (json != null) {
      fromJson(json);
    }
  }

  fromJson(Map<dynamic, dynamic> json) {
    if (json["match_cnt"] != null) {
      csProMatchCnt = json["match_cnt"]?.toString();
    }
    if (json["cnt"] != null) {
      csProMatchCnt = json["cnt"]?.toString();
    }
    csProIsHot = json["is_hot"]?.toString();
    csProLeagueName = json["league_name"]?.toString();
    csProPinyinInitial = json["pinyin_initial"]?.toString();
  }

  copyObject({dynamic json}) {
    return new CSClassLeagueName(json: json);
  }
}
