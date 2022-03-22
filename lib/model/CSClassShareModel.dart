
class CSClassShareModel{

  String  ?title;
  String  ?content;
  String  ?csProIconUrl;
  String  ?csProPageUrl;

  CSClassShareModel({Map ?json}){
    if(json!=null){
      fromJson(json);
    }
  }

  fromJson(Map<dynamic,dynamic> json){
    title=json["title"];
    content=json["content"];
    csProIconUrl=json["icon_url"];
    csProPageUrl=json["page_url"];

  }


}

