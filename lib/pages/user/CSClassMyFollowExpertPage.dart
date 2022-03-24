import 'package:changshengh5/api/CSClassApiManager.dart';
import 'package:changshengh5/api/CSClassHttpCallBack.dart';
import 'package:changshengh5/app/CSClassApplicaion.dart';
import 'package:changshengh5/model/CSClassBaseModelEntity.dart';
import 'package:changshengh5/model/CSClassExpertListEntity.dart';
import 'package:changshengh5/pages/anylise/CSClassExpertDetailPage.dart';
import 'package:changshengh5/pages/common/CSClassLoadingPage.dart';
import 'package:changshengh5/pages/common/CSClassNoDataView.dart';
import 'package:changshengh5/utils/CSClassCommonMethods.dart';
import 'package:changshengh5/utils/CSClassImageUtil.dart';
import 'package:changshengh5/utils/CSClassMatchDataUtils.dart';
import 'package:changshengh5/utils/CSClassNavigatorUtils.dart';
import 'package:changshengh5/utils/CSClassToastUtils.dart';
import 'package:changshengh5/utils/colors.dart';
import 'package:changshengh5/widgets/CSClassBallFooter.dart';
import 'package:changshengh5/widgets/CSClassBallHeader.dart';
import 'package:changshengh5/widgets/CSClassSkeletonList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

///关注专家
class CSClassMyFollowExpertPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CSClassMyFollowExpertPageState();
  }
}

class CSClassMyFollowExpertPageState extends State<CSClassMyFollowExpertPage> {
  List<CSClassExpertListExpertList> csProMyFollowingList = [];
  List<CSClassExpertListExpertList> recommendedExpertsList = [];
  late EasyRefreshController controller;
  int page = 1;
  bool isLoaded = false; //是否加载完成
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = EasyRefreshController();
    csMethodOnReFresh();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return !isLoaded
        ? CSClassLoadingPage()
        : csProMyFollowingList.isEmpty
            ? Container(
                color: Colors.white,
                child: Container(
                  child: EasyRefresh.custom(
                    firstRefresh: true,
                    controller: controller,
                    header: CSClassBallHeader(textColor: Color(0xFF666666)),
                    footer: CSClassBallFooter(textColor: Color(0xFF666666)),
                    firstRefreshWidget: CSClassSkeletonList(
                        length: 10,
                        builder: (c, index) => Container(
                              margin: EdgeInsets.only(bottom: 5),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 0.4, color: Colors.grey[300]!),
                              ),
                              padding: EdgeInsets.only(
                                  top: height(11),
                                  bottom: height(11),
                                  left: width(17)),
                              alignment: Alignment.center,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: width(40),
                                    height: width(40),
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(width(20))),
                                  ),
                                  SizedBox(
                                    width: width(7),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          height: height(10),
                                          width: width(60),
                                          color: Colors.red,
                                        ),
                                        SizedBox(
                                          height: height(5),
                                        ),
                                        Container(
                                          height: height(10),
                                          width: width(100),
                                          color: Colors.red,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )),
                    onRefresh: csMethodOnReFresh,
                    onLoad: csMethodOnLoad,
                    slivers: <Widget>[
                      SliverList(
                        delegate: SliverChildListDelegate([
                          CSClassNoDataView(
                            content: '你还没有关注的专家',
                            height: width(246),
                            iconSize: Size(width(180), height(173)),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: width(15), bottom: width(10)),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '推荐专家',
                              style: TextStyle(
                                  color: Color(0xFF333333),
                                  fontSize: sp(17),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ]),
                      ),
                      SliverList(
                        delegate: SliverChildListDelegate([
                          Container(
                            child: itemWidget(recommendedExpertsList),
                          )
                        ]),
                      ),
                    ],
                  ),
                ))
            : Container(
                color: Colors.white,
                child: Container(
                  child: EasyRefresh.custom(
                    firstRefresh: true,
                    controller: controller,
                    header: CSClassBallHeader(textColor: Color(0xFF666666)),
                    footer: CSClassBallFooter(textColor: Color(0xFF666666)),
                    firstRefreshWidget: CSClassSkeletonList(
                        length: 10,
                        builder: (c, index) => Container(
                              margin: EdgeInsets.only(bottom: 5),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 0.4, color: Colors.grey[300]!),
                              ),
                              padding: EdgeInsets.only(
                                  top: height(11),
                                  bottom: height(11),
                                  left: width(17)),
                              alignment: Alignment.center,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: width(40),
                                    height: width(40),
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(width(20))),
                                  ),
                                  SizedBox(
                                    width: width(7),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          height: height(10),
                                          width: width(60),
                                          color: Colors.red,
                                        ),
                                        SizedBox(
                                          height: height(5),
                                        ),
                                        Container(
                                          height: height(10),
                                          width: width(100),
                                          color: Colors.red,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )),
                    emptyWidget: csProMyFollowingList.length == 0
                        ? CSClassNoDataView(
                            content: '你还没有关注的专家',
                          )
                        : null,
                    onRefresh: csMethodOnReFresh,
                    onLoad: csMethodOnLoad,
                    slivers: <Widget>[
                      SliverToBoxAdapter(
                        child: Container(
                          // padding: EdgeInsets.only(top: width(12),bottom: width(12)),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(width(7))),
                          child: itemWidget(csProMyFollowingList),
                        ),
                      ),
                    ],
                  ),
                ));
  }

  Widget itemWidget(List<CSClassExpertListExpertList> data) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: data.length,
        itemBuilder: (c, index) {
          var item = data[index];
          return GestureDetector(
            child: Container(
              padding: EdgeInsets.only(
                  left: width(14),
                  right: width(14),
                  top: width(12),
                  bottom: width(12)),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      bottom:
                          BorderSide(width: 0.4, color: Colors.grey[300]!))),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(200),
                        child: (item.csProAvatarUrl == null ||
                                item.csProAvatarUrl!.isEmpty)
                            ? Image.asset(
                                CSClassImageUtil.csMethodGetImagePath(
                                    "cs_default_avater"),
                                width: width(46),
                                height: width(46),
                              )
                            : Image.network(
                                item.csProAvatarUrl!,
                                width: width(46),
                                height: width(46),
                                fit: BoxFit.fill,
                              ),
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: (item.csProNewSchemeNum != "null" &&
                                int.tryParse(item.csProNewSchemeNum!)! > 0)
                            ? Container(
                                alignment: Alignment.center,
                                width: width(12),
                                height: width(12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(width(6)),
                                  color: Color(0xFFE3494B),
                                ),
                                child: Text(
                                  item.csProNewSchemeNum!,
                                  style: TextStyle(
                                      fontSize: sp(8), color: Colors.white),
                                ),
                              )
                            : Container(),
                      )
                    ],
                  ),
                  SizedBox(
                    width: width(8),
                  ),
                  Expanded(
                    child: Text(
                      "${item.csProNickName}",
                      style:
                          TextStyle(fontSize: sp(17), color: Color(0xFF333333)),
                    ),
                  ),
                  // Text("胜率${(double.tryParse(item.csProCorrectRate) *100).toStringAsFixed(0)}%",
                  Text(
                      "胜率${(CSClassMatchDataUtils.csMethodCalcBestCorrectRate(item.csProLast10Result!) * 100).toStringAsFixed(0)}%",
                      style: TextStyle(
                        letterSpacing: 0,
                        wordSpacing: 0,
                        fontSize: sp(17),
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFE3494B),
                      )),
                  SizedBox(
                    width: width(15),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      if (csMethodIsLogin(context: context)) {
                          CSClassApiManager.csMethodGetInstance().csMethodFollowExpert(
                            isFollow: !item.csProIsFollowing!,
                            csProExpertUid: item.csProUserId,
                            context: context,
                            csProCallBack:
                                CSClassHttpCallBack<CSClassBaseModelEntity>(
                                    csProOnSuccess: (result) {
                              if (!item.csProIsFollowing!) {
                                CSClassToastUtils.csMethodShowToast(msg: "关注成功");
                                item.csProIsFollowing = true;
                              } else {
                                item.csProIsFollowing = false;
                              }
                              setState(() {});
                            },onError: (e){},csProOnProgress: (v){}
                            ));
                      }
                    },
                    child: Container(
                      // padding: EdgeInsets.symmetric(horizontal: width(8),vertical: width(4)),
                      width: width(61),
                      height: width(27),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                            color: item.csProIsFollowing!
                                ? MyColors.grey_cc
                                : MyColors.main1,
                            width: 0.5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            item.csProIsFollowing! ? Icons.check : Icons.add,
                            color: item.csProIsFollowing!
                                ? MyColors.grey_cc
                                : MyColors.main1,
                            size: width(15),
                          ),
                          Text(
                            item.csProIsFollowing! ? "已关注" : "关注",
                            style: TextStyle(
                                color: item.csProIsFollowing!
                                    ? MyColors.grey_cc
                                    : MyColors.main1,
                                fontSize: sp(12)),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              CSClassApiManager.csMethodGetInstance().csMethodExpertInfo(
                  queryParameters: {"expert_uid": item.csProUserId},
                  context: context,
                  csProCallBack: CSClassHttpCallBack(csProOnSuccess: (info) {
                    CSClassNavigatorUtils.csMethodPushRoute(
                        context, CSClassExpertDetailPage(info));
                  },onError: (e){},csProOnProgress: (v){}
                  ));
            },
          );
        });
  }

  Future<void> csMethodOnReFresh() async {
    page = 1;
    await CSClassApiManager.csMethodGetInstance().csMethodExpertList(
        queryParameters: {"fetch_type": "my_following", "page": "1"},
        csProCallBack: CSClassHttpCallBack<CSClassExpertListEntity>(
            csProOnSuccess: (list) {
              setState(() {
                isLoaded = true;
            csProMyFollowingList = list.csProExpertList!;
          });
          CSClassApiManager.csMethodGetInstance().csMethodExpertList(
              queryParameters: {
                "order_key": "correct_rate",
                "page": 1,
                'ranking_type': '近10场',
                "is_zq_expert": 1
              },
              csProCallBack: CSClassHttpCallBack<CSClassExpertListEntity>(
                  csProOnSuccess: (list) {
                        setState(() {
                      recommendedExpertsList = (list.csProExpertList!.length > 3
                          ? list.csProExpertList!.sublist(0, 3)
                          : list.csProExpertList)!;
                    });
                  },
                  onError: (result) {},
                  csProOnProgress: (v){},
              )
          );
        }, onError: (result) {
          setState(() {
            isLoaded = true;
          });
        }, csProOnProgress: (v){

        }
        ));
  }

  Future<void> csMethodOnLoad() async {
    await CSClassApiManager.csMethodGetInstance().csMethodExpertList(
        queryParameters: {"fetch_type": "my_following", "page": "${page + 1}"},
        csProCallBack: CSClassHttpCallBack<CSClassExpertListEntity>(
            csProOnSuccess: (list) {
              if (list.csProExpertList!.length == 0) {
                controller.finishLoad(noMore: true);
              } else {
                page++;
              }
              setState(() {
                csProMyFollowingList.addAll(list.csProExpertList!);
              });
            },
            onError: (result) {},
            csProOnProgress: (v){},
        ));
  }
}
