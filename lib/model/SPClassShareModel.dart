
class SPClassShareModel{

  String  ?title;
  String  ?content;
  String  ?spProIconUrl;
  String  ?spProPageUrl;

  SPClassShareModel({Map ?json}){
    if(json!=null){
      fromJson(json);
    }
  }

  fromJson(Map<dynamic,dynamic> json){
    title=json["title"];
    content=json["content"];
    spProIconUrl=json["icon_url"];
    spProPageUrl=json["page_url"];

  }


}

