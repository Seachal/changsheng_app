


class SPClassSystemMsg{
  String  ?spProMsgId;
  String  ?spProUserId;
  String  ?content;
  String  ?title;
  String  ?spProAddTime;
  String  ?spProPageUrl;
  bool  ?spProIsRead;



  SPClassSystemMsg({Map<String,dynamic>? json}){
    if(json!=null){
      fromJson(json);
    }
  }
  fromJson(Map<String,dynamic> json){
    spProMsgId=json["msg_id"]?.toString();
    spProPageUrl=json["page_url"]?.toString();
    spProUserId=json["user_id"]?.toString();
    content=json["content"]?.toString();
    title=json["title"]?.toString();
    spProAddTime=json["push_time"]?.toString();
    spProIsRead=int.parse(json["is_read"].toString())==1 ? true:false;

  }

  copyObject({dynamic json}){
    return new SPClassSystemMsg(json: json);
  }
}

