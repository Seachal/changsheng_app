class SPClassCreatOrderEntity {
	String ?package;
	String ?appid;
	String ?sign;
	String ?partnerid;
	String ?spProPrepayid;
	String ?spProOrderNum;
	String ?noncestr;
	int ?timestamp;
  String ?spProOrderInfo;
  String ?url;

	SPClassCreatOrderEntity({this.package, this.appid, this.sign, this.partnerid, this.spProPrepayid, this.spProOrderNum, this.noncestr, this.timestamp});

	SPClassCreatOrderEntity.fromJson(Map<String, dynamic> json) {
		package = json["package"];
		appid = json["appid"];
		sign = json["sign"];
		partnerid = json["partnerid"];
		spProPrepayid = json["prepayid"];
		spProOrderNum = json["order_num"];
		noncestr = json["noncestr"];
		timestamp = json["timestamp"];
    spProOrderInfo = json["order_info"];
    url = json["url"];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data["package"] = this.package;
		data["appid"] = this.appid;
		data["sign"] = this.sign;
		data["partnerid"] = this.partnerid;
		data["prepayid"] = this.spProPrepayid;
		data["order_num"] = this.spProOrderNum;
		data["noncestr"] = this.noncestr;
		data["timestamp"] = this.timestamp;
		return data;
	}
}
