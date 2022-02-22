
class SPClassStringUtils{


  static String spFunNumberConversion(String value,{int asFixed:-1}){
    var result=0.0;
    if(value==null){
      return result.toString();
    }else{
      result=double.parse(value);
      if(result>=100000){
         return "${(result/10000).toString()}"+
             "w";
      }else{
        return result==0 ? result.toStringAsFixed(0):asFixed==-1? result.toString():result.toStringAsFixed(asFixed);
      }
    }
  }
  static String spFunMaxLength(String string,{ int ?length}){
    if(string==null||string.isEmpty){
      return "";
    }
    if(string.length<=length!){
      return string;
    }
    return string.substring(0,length)+"..";
  }

  static String spFunSqlitZero(String string){
    if(string==null||string.isEmpty){
      return "";
    }

   var value=  int.tryParse(string);

    if(value!=null){
      return value.toString();
    }

    while((string.endsWith("0")||string.endsWith("."))&&string.length>1){
      bool spProCanReturn=string.endsWith(".");
      string=  string.substring(0,string.length-1);
      if(spProCanReturn){
        return string;
      }
    }
    return string;
  }

  static String spFunMatchStatusString(bool spProIsOver,String decStatus,spProStTime,{String ?status}){
     if(status!=null&&status=="abnormal"){
       return decStatus;
     }
    if(spProIsOver){
      return "完";
    }
    if(decStatus!=null&&decStatus.trim().isNotEmpty){
      if(decStatus.trim()=="未"){
        return "未";
      }
      return decStatus;
    }else{
        if(  DateTime.parse(spProStTime).difference(DateTime.now()).inSeconds>0){
          return "未";
        }else{
          return "进行中";
        }
    }
  }

  static bool spFunIsNum(String value){
    if(value==null){
      return false;
    }
    if(value.trim().isEmpty){
      return false;
    }
    try{

     return true;
    }catch(e){
      return false;
    }

  }

  static String spFunPanKouData(String value,{String showText:""}){
    var keyArrys=[0.25, -0.25, 0.5, -0.5, 0.75, -0.75, 1, -1, 1.25, -1.25, 1.5, -1.5, 1.75, -1.75, 2, -2, 2.25, -2.25, 2.5, -2.5, 2.75, -2.75, 3, -3, 3.25, -3.25, 3.5, -3.5, 3.75, -3.75, 4, -4, 4.25, -4.25, 4.5, -4.5, 4.75, -4.75, 5, -5, 5.25, -5.25, 5.5, -5.5, 5.75, -5.75, 6, -6, 6.25, -6.25, 6.5, -6.5, 6.75, -6.75, 7, -7, 7.25, -7.25, 7.5, -7.5, 7.75, -7.75, 8, -8, 8.25, -8.25, 8.5, -8.5, 8.75, -8.75, 9, -9, 9.25, -9.25, 9.5, -9.5, 9.75, -9.75,];
    var valueArrys=["+0/0.5", "-0/0.5", "+0.5", "-0.5", "+0.5/1", "-0.5/1", "+1", "-1", "+1/1.5", "-1/1.5", "+1.5", "-1.5", "+1.5/2", "-1.5/2", "+2", "-2", "+2/2.5", "-2/2.5", "+2.5", "-2.5", "+2.5/3", "-2.5/3", "+3", "-3", "+3/3.5", "-3/3.5", "+3.5", "-3.5", "+3.5/4", "-3.5/4", "+4", "-4", "+4/4.5", "-4/4.5", "+4.5", "-4.5", "+4.5/5", "-4.5/5", "+5","-5", "+5/5.5", "-5/5.5", "+5.5", "-5.5", "+5.5/6", "-5.5/6", "+6", "-6", "+6/6.5", "-6/6.5", "+6.5", "-6.5", "+6.5/7", "-6.5/7", "+7", "-7", "+7/7.5", "-7/7.5", "+7.5", "-7.5", "+7.5/8", "-7.5/8", "+8", "-8", "+8/8.5", "-8/8.5", "+8.5", "-8.5", "+8.5/9", "-8.5/9", "+9", "-9", "+9/9.5", "-9/9.5", "+9.5", "-9.5", "+9.5/10", "-9.5/10",];
    if(value==null){
      return "";
    }
    if(value.trim().isEmpty){
      return "";
    }
    try{
      var doubleValue=double.parse(value);
      var index =keyArrys.indexOf(doubleValue);
      if(doubleValue==0){
        return "0";
      }

      if(index==-1){
        return value;
      }else{
         return valueArrys[index];
      }


    }catch (e){
      return value;
    }

  }

  static String spFunNumK(String value)
  {
      if(!spFunIsNum(value)){
        return "";
      }
    var spProMoney=  double.parse(value);
      if(spProMoney>1000){
        return (spProMoney/1000).toStringAsFixed(1)+"K";
      }

    return spProMoney.toStringAsFixed(0);

  }

  static List<String> toList(String value){
    if(value==null||value.isEmpty){
      return [];
    }
    List<String> list=[];
    for(var i=0;i<value.length;i++){
      list.add(value.substring(i,i+1));
    }

    return list;
  }

  static spFunIsEmpty(String value){
    if(value==null||value.isEmpty){
      return true;
    }
    return false;
  }
}