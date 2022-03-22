import 'package:changshengh5/model/CSClassBaseModelEntity.dart';
import 'package:flutter/cupertino.dart';


class CSClassHttpCallBack<T>{
  final ValueChanged<T> csProOnSuccess;
  final ValueChanged<double> csProOnProgress;
  final ValueChanged<CSClassBaseModelEntity> onError;

  CSClassHttpCallBack({
    ValueChanged<T> ?csProOnSuccess,
    ValueChanged<CSClassBaseModelEntity> ?onError,
     ValueChanged<double>? csProOnProgress,
  })  : csProOnSuccess = csProOnSuccess!,
        csProOnProgress=csProOnProgress!,
        onError = onError!;
}