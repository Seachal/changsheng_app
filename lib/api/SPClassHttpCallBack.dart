import 'package:changshengh5/model/SPClassBaseModelEntity.dart';
import 'package:flutter/cupertino.dart';


class SPClassHttpCallBack<T>{
  final ValueChanged<T> spProOnSuccess;
  final ValueChanged<double> spProOnProgress;
  final ValueChanged<SPClassBaseModelEntity> onError;

  SPClassHttpCallBack({
    ValueChanged<T> ?spProOnSuccess,
    ValueChanged<SPClassBaseModelEntity> ?onError,
     ValueChanged<double>? spProOnProgress,
  })  : spProOnSuccess = spProOnSuccess!,
        spProOnProgress=spProOnProgress!,
        onError = onError!;
}