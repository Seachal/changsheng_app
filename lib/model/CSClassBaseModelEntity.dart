
 import 'package:changshengh5/generated/json/base/json_convert_content.dart';
import 'package:changshengh5/utils/CSClassToastUtils.dart';

import 'CSClassAnylizeMatchList.dart';
import 'CSClassCreatOrderEntity.dart';
import 'CSClassExpertListEntity.dart';
import 'CSClassOddsHistoryListEntity.dart';
import 'CSClassSchemeDetailEntity.dart';
import 'CSClassSchemeListEntity.dart';
import 'CSClassShowPListEntity.dart';
import 'CSClassSsOddsList.dart';
import 'CSClassUserSchemeListEntity.dart';

class CSClassBaseModelEntity {
  Map<String, dynamic> ?response; // 所有返回值
  dynamic ?data; // 请求回来的data, 可能是list也可能是map
  String ?code; // 服务器的状态码
  String? msg; // 服务器给的提示信息
  /// true 请求成功 false 请求失败
  bool success = true;

  CSClassBaseModelEntity( this.code, this.msg, this.success); // 客户端是否请求成功false: HTTP错误



  CSClassBaseModelEntity.formJson(this.response){
    this.code = this.response!["code"].toString();
    this.msg = this.response!["msg"];
    this.data = this.response!["data"];
  }

  bool csMethodIsFail() {
    return !csMethodIsSuccess();
  }

  bool csMethodIsSuccess() {
    bool successValue = success && code == "1";
    return successValue;
  }

  /// 失败情况下弹提示
  bool csMethodToast() {
    if (csMethodIsFail()) {
      CSClassToastUtils.csMethodShowToast(msg: msg!);
      return true;
    } else {
      return false;
    }
  }

  T csMethodGetObject<T>({dynamic object}) {
    return csMethodGenerateOBJ<T>(data,object: object);
  }


  /// APP
  T csMethodGenerateOBJ<T>(json,{dynamic object}) {
    print('GenerateOBJ  $T');
    if (T.toString() == this.runtimeType.toString()) {
      return this as T;
    } else if (T.toString() == "CSClassSchemeDetailEntity") {
      return CSClassSchemeDetailEntity.fromJson(json) as T;
    }else if (T.toString() == "CSClassSsOddsList") {
      return CSClassSsOddsList.fromJson(json) as T;
    } else if (T.toString() == "CSClassAnylizeMatchList") {
      return CSClassAnylizeMatchList.fromJson(json) as T;
    } else if (T.toString() == "CSClassCreatOrderEntity") {
      return CSClassCreatOrderEntity.fromJson(json) as T;
    } else if (T.toString() == "CSClassExpertListEntity") {  //web端多个 \$
      return CSClassExpertListEntity.fromJson(json) as T;
    }else if (T.toString() == "CSClassSchemeListEntity") {
      return CSClassSchemeListEntity.fromJson(json) as T;
    } else if (T.toString() == "CSClassUserSchemeListEntity") {
      return CSClassUserSchemeListEntity.fromJson(json) as T;
    } else if (T.toString() == "CSClassOddsHistoryListEntity") {
      return CSClassOddsHistoryListEntity.fromJson(json) as T;
    }else if (T.toString() == "CSClassShowPListEntity") {
      return CSClassShowPListEntity.fromJson(json) as T;
    } else if (object!=null) {
      object.fromJson(json);
      return object as T;
    }
    else {
      return JsonConvert.fromJsonAsT<T>(json)!;
    }
  }

  ///WEB
  //  T csMethodGenerateOBJ<T>(json,{dynamic object}) {
  //    print('GenerateOBJ  $T');
  //   if (T.toString() == this.runtimeType.toString()) {
  //     return this as T;
  //   } else if (T.toString() == "CSClassSchemeDetailEntity\$") {
  //     return CSClassSchemeDetailEntity.fromJson(json) as T;
  //   }else if (T.toString() == "CSClassSsOddsList\$") {
  //     return CSClassSsOddsList.fromJson(json) as T;
  //   } else if (T.toString() == "CSClassAnylizeMatchList\$") {
  //     return CSClassAnylizeMatchList.fromJson(json) as T;
  //   } else if (T.toString() == "CSClassCreatOrderEntity\$") {
  //     return CSClassCreatOrderEntity.fromJson(json) as T;
  //   } else if (T.toString() == "CSClassExpertListEntity\$") {  //web端多个 \$
  //     return CSClassExpertListEntity.fromJson(json) as T;
  //   }else if (T.toString() == "CSClassSchemeListEntity\$") {
  //     return CSClassSchemeListEntity.fromJson(json) as T;
  //   } else if (T.toString() == "CSClassUserSchemeListEntity\$") {
  //     return CSClassUserSchemeListEntity.fromJson(json) as T;
  //   } else if (T.toString() == "CSClassOddsHistoryListEntity\$") {
  //     return CSClassOddsHistoryListEntity.fromJson(json) as T;
  //   }else if (T.toString() == "CSClassShowPListEntity\$") {
  //     return CSClassShowPListEntity.fromJson(json) as T;
  //   } else if (object!=null) {
  //     object.fromJson(json);
  //     return object as T;
  //   }
  //   else {
  //     return JsonConvert.fromJsonAsT<T>(json)!;
  //   }
  // }

}
