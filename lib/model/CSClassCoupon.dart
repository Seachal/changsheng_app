class CSClassCoupon {
  String ?csProCouponId;
  String ?csProCouponName;
  String ?csProMinMoney;
  String ?csPromoney;
  String ?csProAddTime;
  String ?csProExpireTime;

  String ?status;




  CSClassCoupon({Map? json}) {
    if (json != null) {
      fromJson(json);
    }
  }

  fromJson(Map<dynamic, dynamic> json) {
    csProCouponId = json["coupon_id"]?.toString();
    csProCouponName = json["coupon_name"]?.toString();
    csProMinMoney = json["min_money"]?.toString();
    csPromoney = json["money"]?.toString();
    csProAddTime = json["add_time"]?.toString();
    csProExpireTime = json["expire_time"]?.toString();


  }

  copyObject({dynamic json}){
    return new CSClassCoupon(json: json);
  }
}
