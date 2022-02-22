import 'package:changshengh5/generated/json/base/json_field.dart';
import 'package:changshengh5/generated/json/SPClassLogInfoEntity.g.dart';


@JsonSerializable()
class SPClassLogInfoEntity {

	SPClassLogInfoEntity();

	factory SPClassLogInfoEntity.fromJson(Map<String, dynamic> json) => $SPClassLogInfoEntityFromJson(json);

	Map<String, dynamic> toJson() => $SPClassLogInfoEntityToJson(this);

	 String? sydid;
	 List<String>? spProMenuList;

}
