

class CSClassIncomeReport{
  String ?csProPaidIncome;
  String ?csProUnpaidIncome;

  CSClassIncomeReport({Map ?json}){
    if(json!=null){
      fromJson(json);
    }
  }
  fromJson(Map<dynamic,dynamic> json){
    json=json["income_report"];
    csProPaidIncome=json["paid_income"]?.toString();
    csProUnpaidIncome=json["unpaid_income"]?.toString();
  }



}