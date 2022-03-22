

import 'dart:io';

import 'package:changshengh5/api/CSClassApiManager.dart';
import 'package:changshengh5/api/CSClassHttpCallBack.dart';
import 'package:changshengh5/app/CSClassApplicaion.dart';
import 'package:changshengh5/model/CSClassBaseModelEntity.dart';
import 'package:changshengh5/pages/common/CSClassDialogUtils.dart';
import 'package:changshengh5/utils/CSClassCommonMethods.dart';
import 'package:changshengh5/utils/CSClassImageUtil.dart';
import 'package:changshengh5/utils/CSClassToastUtils.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:ota_update/ota_update.dart';
import 'package:open_file/open_file.dart';


class CSClassVersionCheckDialog extends StatefulWidget{

  String ?csProDownloadUrl;
  bool ?barrierDismissible;
  String ?csProContent;
  String ?csProVersion;
  VoidCallback ?csProCancelCallBack;
  CSClassVersionCheckDialog(this.barrierDismissible,this.csProContent,this.csProVersion,{this.csProDownloadUrl,this.csProCancelCallBack});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CSClassVersionCheckDialogState();
  }


}

class CSClassVersionCheckDialogState  extends State<CSClassVersionCheckDialog>{
  double ?csProDownProgress;
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
                  Image.asset(CSClassImageUtil.csMethodGetImagePath("bg_version_up"),
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
                        Text('v${widget.csProVersion}',style: TextStyle(fontSize: sp(17),color: Colors.white),),

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
                            child: Text(widget.csProContent!,style: TextStyle(fontSize: sp(13),color: Color(0xFF333333)),),
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
                                  child: Text(csProDownProgress!=null? "下载中:${(csProDownProgress!*100).toStringAsFixed(0)}%":"立即升级",style: TextStyle(fontSize: sp(19),color: Colors.white),),
                                ),
                                onPressed: () async {

                                  if(Platform.isAndroid){
                                    if(csProDownProgress!=null){
                                      return;
                                    }
                                    var tempDir = await getExternalStorageDirectory();
                                    var installPath="${tempDir?.path}/sport-v${widget.csProVersion}.apk";

                                    var isDown= await File(installPath).exists();
                                    if(isDown){
                                      csMethodInstallApk(installPath);
                                    }else{
                                      String  path = tempDir!.path+"/sport.apk";
                                      File file = File(path);
                                      if (await file.exists()) await file.delete();
                                      CSClassApiManager.csMethodGetInstance().csMethodDownLoad(url: widget.csProDownloadUrl,savePath: path,csProCallBack: CSClassHttpCallBack<CSClassBaseModelEntity>(
                                          onError: (error){
                                            csMethodShowInstallFail("下载失败，请跳转外部浏览器下载！");
                                          },
                                          csProOnProgress: (value){
                                            if(mounted){
                                              setState(() {csProDownProgress=value;});
                                            }
                                          },
                                          csProOnSuccess: (result) async {
                                            if(mounted){
                                              setState(() {csProDownProgress=null;});
                                            }
                                            file.rename(installPath);
                                            csMethodInstallApk(installPath);
                                          }
                                      ));
                                    }
                                  }else{
                                    var isLanch =await canLaunch(widget.csProDownloadUrl!);
                                    if(isLanch){
                                      await launch(widget.csProDownloadUrl!);
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
                                  widget.csProCancelCallBack!();
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

  void csMethodShowInstallFail(String title) {
    CSClassDialogUtils.csMethodShowConfirmDialog(context,RichText(
      text: TextSpan(
        text: title,
        style: TextStyle(fontSize: 16, color: Color(0xFF333333)),

      ),
    ), () async {
      var isLanch =await canLaunch(widget.csProDownloadUrl!);
      if(isLanch){
        await launch(widget.csProDownloadUrl!);
      }
    });
  }

  Future<void> csMethodInstallApk( installPath) async {
    Map<Permission, PermissionStatus> permissions = await [
      Permission.storage,
    ].request();
    if (await Permission.storage.isGranted) {
      OpenFile.open(installPath);
    } else {
      CSClassToastUtils.csMethodShowToast(msg: "权限不足，请检查文件权限");
      csMethodShowInstallFail("安装失败，请跳转外部浏览器下载安装！");

    }
  }



}