


import 'dart:io';

import 'package:changshengh5/pages/common/CSClassDialogUtils.dart';
import 'package:flutter/material.dart';
import 'package:image_crop/image_crop.dart';

typedef CallbackFile = void Function(File result);
class CSClassCropImagePage  extends StatefulWidget{

  CallbackFile ?csProCallbackFile;
  File?  csProImageFile;

  CSClassCropImagePage(this.csProImageFile,this.csProCallbackFile);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CSClassCropImagePageState();
  }

}

class CSClassCropImagePageState extends State<CSClassCropImagePage>{
  final csProCropKey = GlobalKey<CropState>();

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
          image: FileImage(widget.csProImageFile!),
          aspectRatio: 1 /1,
          key: csProCropKey,
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
                  CSClassDialogUtils.csMethodShowLoadingDialog(context,content: "裁剪中");
                  final croppedFile = await ImageCrop.cropImage(
                    file: widget.csProImageFile!,
                    area: csProCropKey.currentState!.area!,
                  );
                  Navigator.of(context).pop();
                  widget.csProCallbackFile!(croppedFile);
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
