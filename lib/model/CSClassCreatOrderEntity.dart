class CSClassCreatOrderEntity {
	String ?package;
	String ?appid;
	String ?sign;
	String ?partnerid;
	String ?csProPrepayid;
	String ?csProOrderNum;
	String ?noncestr;
	int ?timestamp;
  String ?csProOrderInfo;
  String ?url;

	CSClassCreatOrderEntity({this.package, this.appid, this.sign, this.partnerid, this.csProPrepayid, this.csProOrderNum, this.noncestr, this.timestamp});

	CSClassCreatOrderEntity.fromJson(Map<String, dynamic> json) {
		package = json["package"];
		appid = json["appid"];
		sign = json["sign"];
		partnerid = json["partnerid"];
		csProPrepayid = json["prepayid"];
		csProOrderNum = json["order_num"];
		noncestr = json["noncestr"];
		timestamp = json["timestamp"];
    csProOrderInfo = json["order_info"];
    url = json["url"];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data["package"] = this.package;
		data["appid"] = this.appid;
		data["sign"] = this.sign;
		data["partnerid"] = this.partnerid;
		data["prepayid"] = this.csProPrepayid;
		data["order_num"] = this.csProOrderNum;
		data["noncestr"] = this.noncestr;
		data["timestamp"] = this.timestamp;
		return data;
	}
}
