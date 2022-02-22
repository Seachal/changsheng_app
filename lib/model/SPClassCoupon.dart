class SPClassCoupon {
  String ?spProCouponId;
  String ?spProCouponName;
  String ?spProMinMoney;
  String ?spPromoney;
  String ?spProAddTime;
  String ?spProExpireTime;

  String ?status;




  SPClassCoupon({Map? json}) {
    if (json != null) {
      fromJson(json);
    }
  }

  fromJson(Map<dynamic, dynamic> json) {
    spProCouponId = json["coupon_id"]?.toString();
    spProCouponName = json["coupon_name"]?.toString();
    spProMinMoney = json["min_money"]?.toString();
    spPromoney = json["money"]?.toString();
    spProAddTime = json["add_time"]?.toString();
    spProExpireTime = json["expire_time"]?.toString();


  }

  copyObject({dynamic json}){
    return new SPClassCoupon(json: json);
  }
}
