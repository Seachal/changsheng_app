class SPClassListEntity<T>{
  List<T> spProDataList=[];

  String ?key;
  dynamic object;
  SPClassListEntity({this.key,this.object});

  fromJson(Map<String,dynamic> json){
    if(json[key]!=null){
      spProDataList.clear();
      (json[key] as List ).forEach((element) {
        if(T.toString()=="String"){
          spProDataList.add(element.toString() as T);
        }else{
          spProDataList.add(object.copyObject(json:element));
        }
      });
    }
  }

}