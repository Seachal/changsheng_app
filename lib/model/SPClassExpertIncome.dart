class SPClassExpertIncome {
  String ?spProStDate;
  String ?spProEdDate;
  String ?spProSchemeNum;
  String ?income;
  String ?spProSchemeAllDiamond;
  String ?proportion;
  String ?status;




  SPClassExpertIncome({Map ?json}) {
    if (json != null) {
      fromJson(json);
    }
  }

  fromJson(Map<dynamic, dynamic> json) {
    spProStDate = json["st_date"]?.toString();
    spProEdDate = json["ed_date"]?.toString();
    spProSchemeNum = json["scheme_num"]?.toString();
    income = json["income"]?.toString();
    spProSchemeAllDiamond = json["scheme_all_diamond"]?.toString();
    proportion=json['proportion']?.toString();
    status=json['status']?.toString();

  }

  copyObject({dynamic json}){
    return new SPClassExpertIncome(json: json);
  }
}
