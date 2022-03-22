
import 'package:changshengh5/generated/json/base/json_convert_content.dart';

class SPClassLogInfoEntity with JsonConvert<SPClassLogInfoEntity> {
  String ?sydid;
  List<String> ?spProMenuList;

}

// class SPClassLogInfoEntity {
//   String ?sydid;
//   List<String>? spProMenuList;
//   SPClassLogInfoEntity({this.sydid,this.spProMenuList});
//
//   SPClassLogInfoEntity.fromJson(Map<String, dynamic> json) {
//     sydid = json['sydid'];
//     if(json['menu_list'] != null){
//       spProMenuList = [];(json['menu_list'] as List).forEach((v) { spProMenuList!.add(v); });
//     }
//   }
//
// }
