class CSClassCheckUpDate {
  bool ?csProNeedUpdate;
  String ?csProDownloadUrl;
  bool ?csProIsForced;
  String ?csProUpdateDesc;
  String ?csProAppVersion;


  CSClassCheckUpDate({Map<String,dynamic> ?json}){
    if(json!=null){
      fromJson(json);
    }
  }
  fromJson(Map<String, dynamic> json) {
    csProNeedUpdate = int.parse(json["need_update"].toString()) == 1 ? true : false;
    if (json["download_url"] != null) {
      csProDownloadUrl = json["download_url"];
      csProIsForced = int.parse(json["is_forced"].toString()) == 1 ? true : false;
      csProUpdateDesc = json["update_desc"];
      csProAppVersion = json["app_version"];
    }
  }
}
