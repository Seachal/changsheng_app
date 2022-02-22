class SPClassShowPListEntity {
	List<SPClassShowPListPayList> ?spProPayList;
	List<String> ?spProPayedMoneyList;
	List<String>? spProMoneyList;
	List<String> ?spProDoubleMoneys;
	String  ?spProExchangeRate;
	bool ?spProOfficialPayOnly;
  Map<String,dynamic> ?spProMoney2Diamond;

	SPClassShowPListEntity({this.spProPayList, this.spProOfficialPayOnly});

	SPClassShowPListEntity.fromJson(Map<String, dynamic> json) {
		if (json["pay_list"] != null) {
			spProPayList = [];(json["pay_list"] as List).forEach((v) { spProPayList?.add(new SPClassShowPListPayList.fromJson(v)); });
		}

    if (json["payed_money_list"] != null) {
      spProPayedMoneyList = [];(json["payed_money_list"] as List).forEach((v) { spProPayedMoneyList?.add(v.toString()); });
    }
		if (json["money_list"] != null) {
			spProMoneyList = [];(json["money_list"] as List).forEach((v) { spProMoneyList?.add(v.toString()); });
		}
		if (json["first_pay_double_money"] != null) {
			spProDoubleMoneys = [];(json["first_pay_double_money"] as List).forEach((v) { spProDoubleMoneys?.add(v.toString()); });
		}
    if (json["money2diamond"] != null) {
      spProMoney2Diamond=json["money2diamond"];
    }
		spProOfficialPayOnly = json["official_pay_only"];
    spProExchangeRate = json["exchange_rate"].toString();
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.spProPayList != null) {
      data["pay_list"] =  this.spProPayList?.map((v) => v.toJson()).toList();
    }
		data["official_pay_only"] = this.spProOfficialPayOnly;
		return data;
	}
}

class SPClassShowPListPayList {
	String ?spProIconUrl;
	String ?spProPayTypeKey;
	String ?spProActiveContent;

	SPClassShowPListPayList({this.spProIconUrl, this.spProPayTypeKey});

	SPClassShowPListPayList.fromJson(Map<String, dynamic> json) {
		spProIconUrl = json["icon_url"];
		spProPayTypeKey = json["pay_type_key"];
    spProActiveContent = json["active_content"];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data["icon_url"] = this.spProIconUrl;
		data["pay_type_key"] = this.spProPayTypeKey;
		return data;
	}
}
