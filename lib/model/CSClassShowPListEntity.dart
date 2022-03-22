class CSClassShowPListEntity {
	List<CSClassShowPListPayList> ?csProPayList;
	List<String> ?csProPayedMoneyList;
	List<String>? csProMoneyList;
	List<String> ?csProDoubleMoneys;
	String  ?csProExchangeRate;
	bool ?csProOfficialPayOnly;
  Map<String,dynamic> ?csProMoney2Diamond;

	CSClassShowPListEntity({this.csProPayList, this.csProOfficialPayOnly});

	CSClassShowPListEntity.fromJson(Map<String, dynamic> json) {
		if (json["pay_list"] != null) {
			csProPayList = [];(json["pay_list"] as List).forEach((v) { csProPayList?.add(new CSClassShowPListPayList.fromJson(v)); });
		}

    if (json["payed_money_list"] != null) {
      csProPayedMoneyList = [];(json["payed_money_list"] as List).forEach((v) { csProPayedMoneyList?.add(v.toString()); });
    }
		if (json["money_list"] != null) {
			csProMoneyList = [];(json["money_list"] as List).forEach((v) { csProMoneyList?.add(v.toString()); });
		}
		if (json["first_pay_double_money"] != null) {
			csProDoubleMoneys = [];(json["first_pay_double_money"] as List).forEach((v) { csProDoubleMoneys?.add(v.toString()); });
		}
    if (json["money2diamond"] != null) {
      csProMoney2Diamond=json["money2diamond"];
    }
		csProOfficialPayOnly = json["official_pay_only"];
    csProExchangeRate = json["exchange_rate"].toString();
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.csProPayList != null) {
      data["pay_list"] =  this.csProPayList?.map((v) => v.toJson()).toList();
    }
		data["official_pay_only"] = this.csProOfficialPayOnly;
		return data;
	}
}

class CSClassShowPListPayList {
	String ?csProIconUrl;
	String ?csProPayTypeKey;
	String ?csProActiveContent;

	CSClassShowPListPayList({this.csProIconUrl, this.csProPayTypeKey});

	CSClassShowPListPayList.fromJson(Map<String, dynamic> json) {
		csProIconUrl = json["icon_url"];
		csProPayTypeKey = json["pay_type_key"];
    csProActiveContent = json["active_content"];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data["icon_url"] = this.csProIconUrl;
		data["pay_type_key"] = this.csProPayTypeKey;
		return data;
	}
}
