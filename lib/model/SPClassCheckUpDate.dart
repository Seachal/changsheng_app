class SPClassCheckUpDate {
  bool ?spProNeedUpdate;
  String ?spProDownloadUrl;
  bool ?spProIsForced;
  String ?spProUpdateDesc;
  String ?spProAppVersion;


  SPClassCheckUpDate({Map<String,dynamic> ?json}){
    if(json!=null){
      fromJson(json);
    }
  }
  fromJson(Map<String, dynamic> json) {
    spProNeedUpdate = int.parse(json["need_update"].toString()) == 1 ? true : false;
    if (json["download_url"] != null) {
      spProDownloadUrl = json["download_url"];
      spProIsForced = int.parse(json["is_forced"].toString()) == 1 ? true : false;
      spProUpdateDesc = json["update_desc"];
      spProAppVersion = json["app_version"];
    }
  }
}
