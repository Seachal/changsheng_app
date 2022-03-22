
import 'package:changshengh5/generated/json/base/json_convert_content.dart';

class CSClassLogInfoEntity with JsonConvert<CSClassLogInfoEntity> {
  String ?sydid;
  List<String> ?csProMenuList;

}

// class CSClassLogInfoEntity {
//   String ?sydid;
//   List<String>? csProMenuList;
//   CSClassLogInfoEntity({this.sydid,this.csProMenuList});
//
//   CSClassLogInfoEntity.fromJson(Map<String, dynamic> json) {
//     sydid = json['sydid'];
//     if(json['menu_list'] != null){
//       csProMenuList = [];(json['menu_list'] as List).forEach((v) { csProMenuList!.add(v); });
//     }
//   }
//
// }
