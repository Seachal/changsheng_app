


class CSClassSystemMsg{
  String  ?csProMsgId;
  String  ?csProUserId;
  String  ?content;
  String  ?title;
  String  ?csProAddTime;
  String  ?csProPageUrl;
  bool  ?csProIsRead;



  CSClassSystemMsg({Map<String,dynamic>? json}){
    if(json!=null){
      fromJson(json);
    }
  }
  fromJson(Map<String,dynamic> json){
    csProMsgId=json["msg_id"]?.toString();
    csProPageUrl=json["page_url"]?.toString();
    csProUserId=json["user_id"]?.toString();
    content=json["content"]?.toString();
    title=json["title"]?.toString();
    csProAddTime=json["push_time"]?.toString();
    csProIsRead=int.parse(json["is_read"].toString())==1 ? true:false;

  }

  copyObject({dynamic json}){
    return new CSClassSystemMsg(json: json);
  }
}

