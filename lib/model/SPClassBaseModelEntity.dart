
 import 'package:changshengh5/generated/json/base/json_convert_content.dart';
import 'package:changshengh5/untils/SPClassToastUtils.dart';

import 'SPClassAnylizeMatchList.dart';
import 'SPClassCreatOrderEntity.dart';
import 'SPClassExpertListEntity.dart';
import 'SPClassOddsHistoryListEntity.dart';
import 'SPClassSchemeDetailEntity.dart';
import 'SPClassSchemeListEntity.dart';
import 'SPClassShowPListEntity.dart';
import 'SPClassSsOddsList.dart';
import 'SPClassUserSchemeListEntity.dart';

class SPClassBaseModelEntity {
  Map<String, dynamic> ?response; // 所有返回值
  dynamic ?data; // 请求回来的data, 可能是list也可能是map
  String ?code; // 服务器的状态码
  String? msg; // 服务器给的提示信息
  /// true 请求成功 false 请求失败
  bool success = true;

  SPClassBaseModelEntity( this.code, this.msg, this.success); // 客户端是否请求成功false: HTTP错误



  SPClassBaseModelEntity.formJson(this.response){
    this.code = this.response!["code"].toString();
    this.msg = this.response!["msg"];
    this.data = this.response!["data"];
  }

  bool spFunIsFail() {
    return !spFunIsSuccess();
  }

  bool spFunIsSuccess() {
    bool successValue = success && code == "1";
    return successValue;
  }

  /// 失败情况下弹提示
  bool spFunToast() {
    if (spFunIsFail()) {
      SPClassToastUtils.spFunShowToast(msg: msg!);
      return true;
    } else {
      return false;
    }
  }

  T spFunGetObject<T>({dynamic object}) {
    return spFunGenerateOBJ<T>(data,object: object);
  }


  /// APP
  T spFunGenerateOBJ<T>(json,{dynamic object}) {
    print('GenerateOBJ  $T');
    if (T.toString() == this.runtimeType.toString()) {
      return this as T;
    } else if (T.toString() == "SPClassSchemeDetailEntity") {
      return SPClassSchemeDetailEntity.fromJson(json) as T;
    }else if (T.toString() == "SPClassSsOddsList") {
      return SPClassSsOddsList.fromJson(json) as T;
    } else if (T.toString() == "SPClassAnylizeMatchList") {
      return SPClassAnylizeMatchList.fromJson(json) as T;
    } else if (T.toString() == "SPClassCreatOrderEntity") {
      return SPClassCreatOrderEntity.fromJson(json) as T;
    } else if (T.toString() == "SPClassExpertListEntity") {  //web端多个 \$
      return SPClassExpertListEntity.fromJson(json) as T;
    }else if (T.toString() == "SPClassSchemeListEntity") {
      return SPClassSchemeListEntity.fromJson(json) as T;
    } else if (T.toString() == "SPClassUserSchemeListEntity") {
      return SPClassUserSchemeListEntity.fromJson(json) as T;
    } else if (T.toString() == "SPClassOddsHistoryListEntity") {
      return SPClassOddsHistoryListEntity.fromJson(json) as T;
    }else if (T.toString() == "SPClassShowPListEntity") {
      return SPClassShowPListEntity.fromJson(json) as T;
    } else if (object!=null) {
      object.fromJson(json);
      return object as T;
    }
    else {
      return JsonConvert.fromJsonAsT<T>(json)!;
    }
  }

  ///WEB
  //  T spFunGenerateOBJ<T>(json,{dynamic object}) {
  //    print('GenerateOBJ  $T');
  //   if (T.toString() == this.runtimeType.toString()) {
  //     return this as T;
  //   } else if (T.toString() == "SPClassSchemeDetailEntity\$") {
  //     return SPClassSchemeDetailEntity.fromJson(json) as T;
  //   }else if (T.toString() == "SPClassSsOddsList\$") {
  //     return SPClassSsOddsList.fromJson(json) as T;
  //   } else if (T.toString() == "SPClassAnylizeMatchList\$") {
  //     return SPClassAnylizeMatchList.fromJson(json) as T;
  //   } else if (T.toString() == "SPClassCreatOrderEntity\$") {
  //     return SPClassCreatOrderEntity.fromJson(json) as T;
  //   } else if (T.toString() == "SPClassExpertListEntity\$") {  //web端多个 \$
  //     return SPClassExpertListEntity.fromJson(json) as T;
  //   }else if (T.toString() == "SPClassSchemeListEntity\$") {
  //     return SPClassSchemeListEntity.fromJson(json) as T;
  //   } else if (T.toString() == "SPClassUserSchemeListEntity\$") {
  //     return SPClassUserSchemeListEntity.fromJson(json) as T;
  //   } else if (T.toString() == "SPClassOddsHistoryListEntity\$") {
  //     return SPClassOddsHistoryListEntity.fromJson(json) as T;
  //   }else if (T.toString() == "SPClassShowPListEntity\$") {
  //     return SPClassShowPListEntity.fromJson(json) as T;
  //   } else if (object!=null) {
  //     object.fromJson(json);
  //     return object as T;
  //   }
  //   else {
  //     return JsonConvert.fromJsonAsT<T>(json)!;
  //   }
  // }

}
