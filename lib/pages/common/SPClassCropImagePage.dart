


import 'dart:io';

import 'package:changshengh5/pages/common/SPClassDialogUtils.dart';
import 'package:flutter/material.dart';
import 'package:image_crop/image_crop.dart';

typedef CallbackFile = void Function(File result);
class SPClassCropImagePage  extends StatefulWidget{

  CallbackFile ?spProCallbackFile;
  File?  spProImageFile;

  SPClassCropImagePage(this.spProImageFile,this.spProCallbackFile);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SPClassCropImagePageState();
  }

}

class SPClassCropImagePageState extends State<SPClassCropImagePage>{
  final spProCropKey = GlobalKey<CropState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("图片编辑"),),
      body: Container(
        color: Colors.black,
        child: Crop(
          image: FileImage(widget.spProImageFile!),
          aspectRatio: 1 /1,
          key: spProCropKey,
        ),
      ),
      bottomNavigationBar: Container(
        color: Theme.of(context).primaryColor,
        height: 60,
        child: Row(
          children: <Widget>[
            Flexible(
              flex: 1,
              child:GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: Center(
                  child: Text("取消",style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
                ),
                onTap: (){
                  Navigator.of(context).pop();
                },
              ),
            ),
            Flexible(
              flex: 1,
              child:GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: Center(
                  child: Text("确定",style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
                ),
                onTap: () async {
                  SPClassDialogUtils.spFunShowLoadingDialog(context,content: "裁剪中");
                  final croppedFile = await ImageCrop.cropImage(
                    file: widget.spProImageFile!,
                    area: spProCropKey.currentState!.area!,
                  );
                  Navigator.of(context).pop();
                  widget.spProCallbackFile!(croppedFile);
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

}
