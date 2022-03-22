class CSClassExpertIncome {
  String ?csProStDate;
  String ?csProEdDate;
  String ?csProSchemeNum;
  String ?income;
  String ?csProSchemeAllDiamond;
  String ?proportion;
  String ?status;




  CSClassExpertIncome({Map ?json}) {
    if (json != null) {
      fromJson(json);
    }
  }

  fromJson(Map<dynamic, dynamic> json) {
    csProStDate = json["st_date"]?.toString();
    csProEdDate = json["ed_date"]?.toString();
    csProSchemeNum = json["scheme_num"]?.toString();
    income = json["income"]?.toString();
    csProSchemeAllDiamond = json["scheme_all_diamond"]?.toString();
    proportion=json['proportion']?.toString();
    status=json['status']?.toString();

  }

  copyObject({dynamic json}){
    return new CSClassExpertIncome(json: json);
  }
}
