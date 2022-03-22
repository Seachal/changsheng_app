class CSClassListEntity<T>{
  List<T> csProDataList=[];

  String ?key;
  dynamic object;
  CSClassListEntity({this.key,this.object});

  fromJson(Map<String,dynamic> json){
    if(json[key]!=null){
      csProDataList.clear();
      (json[key] as List ).forEach((element) {
        if(T.toString()=="String"){
          csProDataList.add(element.toString() as T);
        }else{
          csProDataList.add(object.copyObject(json:element));
        }
      });
    }
  }

}