

import 'dart:io';

import 'package:changshengh5/api/SPClassApiManager.dart';
import 'package:changshengh5/api/SPClassHttpCallBack.dart';
import 'package:changshengh5/app/SPClassApplicaion.dart';
import 'package:changshengh5/model/SPClassBaseModelEntity.dart';
import 'package:changshengh5/pages/common/SPClassDialogUtils.dart';
import 'package:changshengh5/untils/SPClassCommonMethods.dart';
import 'package:changshengh5/untils/SPClassImageUtil.dart';
import 'package:changshengh5/untils/SPClassToastUtils.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ota_update/ota_update.dart';


class SPClassVersionCheckDialog extends StatefulWidget{

  String ?spProDownloadUrl;
  bool ?barrierDismissible;
  String ?spProContent;
  String ?spProVersion;
  VoidCallback ?spProCancelCallBack;
  SPClassVersionCheckDialog(this.barrierDismissible,this.spProContent,this.spProVersion,{this.spProDownloadUrl,this.spProCancelCallBack});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SPClassVersionCheckDialogState();
  }


}

class SPClassVersionCheckDialogState  extends State<SPClassVersionCheckDialog>{
  double ?spProDownProgress;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      child: Dialog(
        elevation: 0,
          backgroundColor: Colors.transparent,
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Image.asset(SPClassImageUtil.spFunGetImagePath("bg_version_up"),
                    width:width(268),
                    fit: BoxFit.fill,
                    height:width(380),
                  ),
                  Positioned(
                    top: width(39),
                    left: width(24),
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("发现新版本",style: TextStyle(fontSize: sp(21),color: Colors.white),),
                        Text('v${widget.spProVersion}',style: TextStyle(fontSize: sp(17),color: Colors.white),),

                      ],
                    ),
                  ),
                  Positioned(
                    top: width(150),
                    left: 0,
                    right: 0,
                    child: Column(
                      children: <Widget>[
                        Container(
                          height:width(144),
                          child: SingleChildScrollView(
                            padding: EdgeInsets.all(width(10)),
                            child: Text(widget.spProContent!,style: TextStyle(fontSize: sp(13),color: Color(0xFF333333)),),
                          ),

                        ),
                        Container(
                          child: Column(
                            children: <Widget>[
                              FlatButton(
                                padding: EdgeInsets.zero,
                                child: Container(
                                  alignment: Alignment.center,
                                  height:width(45),
                                  width: width(206),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(150),
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xFF1DBDF2),
                                        Color(0xFF1D99F2),
                                      ]
                                    )
                                  ),
                                  child: Text(spProDownProgress!=null? "下载中:${(spProDownProgress!*100).toStringAsFixed(0)}%":"立即升级",style: TextStyle(fontSize: sp(19),color: Colors.white),),
                                ),
                                onPressed: () async {

                                  if(Platform.isAndroid){
                                    if(spProDownProgress!=null){
                                      return;
                                    }
                                    var tempDir = await getExternalStorageDirectory();
                                    var installPath="${tempDir?.path}/sport-v${widget.spProVersion}.apk";

                                    var isDown= await File(installPath).exists();
                                    if(isDown){
                                      spFunInstallApk(installPath);
                                    }else{
                                      String  path = tempDir!.path+"/sport.apk";
                                      File file = File(path);
                                      if (await file.exists()) await file.delete();
                                      SPClassApiManager.spFunGetInstance().spFunDownLoad(url: widget.spProDownloadUrl,savePath: path,spProCallBack: SPClassHttpCallBack<SPClassBaseModelEntity>(
                                          onError: (error){
                                            spFunShowInstallFail("下载失败，请跳转外部浏览器下载！");
                                          },
                                          spProOnProgress: (value){
                                            if(mounted){
                                              setState(() {spProDownProgress=value;});
                                            }
                                          },
                                          spProOnSuccess: (result) async {
                                            if(mounted){
                                              setState(() {spProDownProgress=null;});
                                            }
                                            file.rename(installPath);
                                            spFunInstallApk(installPath);
                                          }
                                      ));
                                    }
                                  }else{
                                    var isLanch =await canLaunch(widget.spProDownloadUrl!);
                                    if(isLanch){
                                      await launch(widget.spProDownloadUrl!);
                                    }
                                  }
                                },
                              ),
                              !widget.barrierDismissible!? FlatButton(
                                padding: EdgeInsets.zero,
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text("暂不升级",style: TextStyle(fontSize: sp(15),color: Color(0xFF999999)),),
                                ),
                                onPressed: (){
                                  widget.spProCancelCallBack!();
                                },
                              ):Container(),

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),


               
            ],
          ),
      ),
      onWillPop: () async {
        return false;
      },
    );
  }

  void spFunShowInstallFail(String title) {
    SPClassDialogUtils.spFunShowConfirmDialog(context,RichText(
      text: TextSpan(
        text: title,
        style: TextStyle(fontSize: 16, color: Color(0xFF333333)),

      ),
    ), () async {
      var isLanch =await canLaunch(widget.spProDownloadUrl!);
      if(isLanch){
        await launch(widget.spProDownloadUrl!);
      }
    });
  }

  Future<void> spFunInstallApk( installPath) async {
    Map<Permission, PermissionStatus> permissions = await [
      Permission.storage,
    ].request();
    if (await Permission.storage.isGranted) {
      try {
        OtaUpdate()
            .execute(
          installPath,
          destinationFilename: SPClassApplicaion.spProPackageInfo?.packageName,
          //OPTIONAL, ANDROID ONLY - ABILITY TO VALIDATE CHECKSUM OF FILE:
          // sha256checksum: "d6da28451a1e15cf7a75f2c3f151befad3b80ad0bb232ab15c20897e54f21478",
        ).listen(
              (OtaEvent event) {

          },
        );
      } catch (e) {
        spFunShowInstallFail("安装失败，请跳转外部浏览器下载安装！");
      }
    } else {
      SPClassToastUtils.spFunShowToast(msg: "权限不足，请检查文件权限");
      spFunShowInstallFail("安装失败，请跳转外部浏览器下载安装！");

    }
  }



}