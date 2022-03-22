
import 'package:changshengh5/app/CSClassApplicaion.dart';
import 'package:changshengh5/utils/CSClassCommonMethods.dart';
import 'package:changshengh5/utils/CSClassImageUtil.dart';
import 'package:changshengh5/utils/CSClassNavigatorUtils.dart';
import 'package:changshengh5/widgets/CSClassNestedScrollViewRefreshBallStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

import 'ProductDetail.dart';
import 'ShopCar.dart';
import 'SpecialArea.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({Key ?key}) : super(key: key);

  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> with TickerProviderStateMixin {
  TabController ?_controller;
  ScrollController ?_scrollController;

  List tabBarList = ['热卖', '新品','特惠','NBA','英超',];
  List clothesList = [
    // {
    //   'name': '安踏运动套装',
    //   'image': 'clothes1',
    //   'price': 88,
    //   'sell': 66,
    //   'detailImages':
    //       'clothes1_detail1;clothes1_detail2;clothes1_detail3;clothes1_detail4;clothes1_detail5',
    // },
  ];

  List equipmentList = [
    // {
    //   'name': '骆驼游泳干包',
    //   'image': 'equipment1',
    //   'price': 168,
    //   'sell': 42,
    //   'detailImages':
    //       'equipment1_detail1;equipment1_detail2;equipment1_detail3;equipment1_detail4'
    // },
  ];

  List shopTypeList = [
    {
      'name': '球衣',
      'image': 'qiuyi',
      'data':[
        {
          'name':'湖人队詹姆斯球衣 SW球迷版 篮球运动比赛球衣篮球服 NBA-Nike',
          'image':'smqiumiban',
          'price': 488,
          'sell':348,
          'count':1,
          'color':'',
          'size':'',
        },
        {
          'name':'金州勇士队 库里 Dri-FIT SW 男子球迷版球衣 NBA-Nike',
          'image':'kuli Dri-FIT SW',
          'price': 599,
          'sell':651,
          'count':1,
          'color':'',
          'size':'',
        },
        {
          'name':'2020赛季湖人队 詹姆斯城市限定 City Edition 球迷款SW男子球衣NBA Nike',
          'image':'City Edition SM',
          'price': 399,
          'sell':321,
          'count':1,
          'color':'',
          'size':'',
        },
        {
          'name':'篮网队杜兰特球衣 SW球迷版 篮球运动比赛球衣篮球服 NBA-Nike',
          'image':'dulante SM',
          'price': 299,
          'sell':654,
          'count':1,
          'color':'',
          'size':'',
        },
        {
          'name':'篮网队 凯文杜兰特 Dri-FIT SW 男子球迷版球衣 NBA-Nike',
          'image':'kaiwu Dri-FIT SW',
          'price': 499,
          'sell':325,
          'count':1,
          'color':'',
          'size':'',
        },

        {
          'name':'灰熊队莫兰特 Diamond IE Dri-FIT SW 男子球衣 NBA-Nike',
          'image':'Diamond IE Dri-FIT SW',
          'price': 299,
          'sell':535,
          'count':1,
          'color':'',
          'size':'',
        },
        {
          'name':'阿森纳93-94经典复古短袖球衣 阿迪达斯',
          'image':'asen',
          'price': 599,
          'sell':654,
          'count':1,
          'color':'',
          'size':'',
        },
        {
          'name':'2020 赛季波特兰开拓者队 Association Edition Nike NBA Swingman Jersey 男子球衣',
          'image':'Association Edition',
          'price': 299,
          'sell':221,
          'count':1,
          'color':'',
          'size':'',
        },
        {
          'name':'NBA-Nike 金州勇士队 库里 Select Series 男子球衣',
          'image':'kuli Select Series',
          'price': 499,
          'sell':351,
          'count':1,
          'color':'',
          'size':'',
        },
        {
          'name':'复古球衣-SW球迷版-独行侠队 德克·诺维茨基 蓝色客场 NBA-MN',
          'image':'fuguqiuyi',
          'price': 399,
          'sell':125,
          'count':1,
          'color':'',
          'size':'',
        },

      ]
    },
    {
      'name': '卫衣',
      'image': 'weiyi',
      'data':[
        {
          'name':'M&N 勇士队库里情侣款复古连帽套头衫卫衣MN简约潮流 NBA Mitchellness',
          'image':'NBA Mitchellness',
          'price': 688,
          'sell':645,
          'count':1,
          'color':'',
          'size':'',
        },
        {
          'name':'布鲁克林篮网队情侣款百搭毛绒连帽毛茸茸长袖卫衣 白色 NBA STYLE',
          'image':'NBA STYLE',
          'price': 799,
          'sell':312,
          'count':1,
          'color':'',
          'size':'',
        },
        {
          'name':'【天台守夜人】2021秋季男士新款 印花连帽套头运动卫衣 中国乔丹',
          'image':'yinhualianmaotao',
          'price': 888,
          'sell':341,
          'count':1,
          'color':'',
          'size':'',
        },
        {
          'name':'【天台守夜人】男士2021新款潮流满印 篮球连帽卫衣外套 中国乔丹',
          'image':'lanqiulainmaoweiy',
          'price': 999,
          'sell':765,
          'count':1,
          'color':'',
          'size':'',
        },
        {
          'name':'篮网队 太空棉连帽白色 运动休闲卫衣 NBA',
          'image':'taikongmian',
          'price': 499,
          'sell':326,
          'count':1,
          'color':'',
          'size':'',
        },

        {
          'name':'上海申花经典条纹蓝白开襟运动外套 运动夹克 开襟卫衣',
          'image':'shanghaishenghua',
          'price': 399,
          'sell':132,
          'count':1,
          'color':'',
          'size':'',
        },
        {
          'name':'法国队 FFF法国国家足球队拼色圆领卫衣',
          'image':'faguodui FFF',
          'price': 399,
          'sell':25,
          'count':1,
          'color':'',
          'size':'',
        },
        {
          'name':'阿森纳 串标织带连帽卫衣',
          'image':'chuanbiaozhidai',
          'price': 299,
          'sell':522,
          'count':1,
          'color':'',
          'size':'',
        },
        {
          'name':'情人节【年】在一起|狼队X痛仰联名款卫衣 时尚运动情侣穿搭',
          'image':'qinrenjie-x',
          'price': 499,
          'sell':796,
          'count':1,
          'color':'',
          'size':'',
        },
        {
          'name':'法网潮流印花卫衣 2021新款卫衣男女运动休闲卫衣 罗兰加洛斯法网官方正品',
          'image':'fawanchaoliu',
          'price': 688,
          'sell':151,
          'count':1,
          'color':'',
          'size':'',
        },

      ]
    },
    {
      'name': '球鞋',
      'image': 'qiuxie',
      'data':[
        {
          'name':'破影3巭-回弹科技缓震运动耐磨篮球鞋 乔丹体育',
          'image':'poying',
          'price': 2388,
          'sell':275,
          'count':1,
          'color':'',
          'size':'',
        },
        {
          'name':'2022春季新款潮流减震防滑跑鞋 乔丹体育',
          'image':'chunjixingkuan',
          'price': 2599,
          'sell':203,
          'count':1,
          'color':'',
          'size':'',
        },
        {
          'name':'运动半掌气垫减震男子跑步鞋 乔丹体育',
          'image':'idianjianzheng',
          'price': 1599,
          'sell':123,
          'count':1,
          'color':'',
          'size':'',
        },
        {
          'name':'咻-轻速科技休闲厚底增高篮球运动鞋 乔丹体育',
          'image':'xiu-qinsu',
          'price': 2699,
          'sell':64,
          'count':1,
          'color':'',
          'size':'',
        },
        {
          'name':'2021新款跑鞋全掌气垫耐磨减震轻便跑步鞋 中国乔丹',
          'image':'naimojiangzhneg',
          'price': 1599,
          'sell':515,
          'count':1,
          'color':'',
          'size':'',
        },
      ]
    },
    {
      'name': '装备',
      'image': 'zhuangbei',
      'data':[
        {
          'name':'NBA运动配件礼包',
          'image':'NBA-peijian',
          'price': 488,
          'sell':645,
          'count':1,
          'color':'',
          'size':'',
        },
        {
          'name':'NBA 彩虹运动毛巾 篮球运动健身跑步柔软吸汗毛巾',
          'image':'NBA-caihong',
          'price': 68,
          'sell':323,
          'count':1,
          'color':'',
          'size':'',
        },
        {
          'name':'NBA 男士毛巾底运动袜3双装 舒适耐穿吸汗透气中筒袜子',
          'image':'mba-yundongwa',
          'price': 58,
          'sell':652,
          'count':1,
          'color':'',
          'size':'',
        },
        {
          'name':'必迈 2021跑步紧缩护腿专业运动护具',
          'image':'bimai',
          'price': 78,
          'sell':32,
          'count':1,
          'color':'',
          'size':'',
        },
        {
          'name':'阿森纳 运动套装',
          'image':'jiansheng',
          'price': 399,
          'sell':32,
          'count':1,
          'color':'',
          'size':'',
        },
      ]
    }
  ];

  List discountProduct = [
    {
      'name':'湖人队詹姆斯球衣 SW球迷版 篮球运动比赛球衣篮球服 NBA-Nike',
      'image':'smqiumiban',
      'price': 488,
      'sell':348,
      'count':1,
      'color':'',
      'size':'',
    },
    {
      'name':'金州勇士队 库里 Dri-FIT SW 男子球迷版球衣 NBA-Nike',
      'image':'kuli Dri-FIT SW',
      'price': 599,
      'sell':651,
      'count':1,
      'color':'',
      'size':'',
    },
    {
      'name':'M&N 勇士队库里情侣款复古连帽套头衫卫衣MN简约潮流 NBA Mitchellness',
      'image':'NBA Mitchellness',
      'price': 688,
      'sell':645,
      'count':1,
      'color':'',
      'size':'',
    },
    {
      'name':'布鲁克林篮网队情侣款百搭毛绒连帽毛茸茸长袖卫衣 白色 NBA STYLE',
      'image':'NBA STYLE',
      'price': 799,
      'sell':312,
      'count':1,
      'color':'',
      'size':'',
    },
    {
      'name':'破影3巭-回弹科技缓震运动耐磨篮球鞋 乔丹体育',
      'image':'poying',
      'price': 2388,
      'sell':275,
      'count':1,
      'color':'',
      'size':'',
    },
    {
      'name':'2022春季新款潮流减震防滑跑鞋 乔丹体育',
      'image':'chunjixingkuan',
      'price': 2599,
      'sell':203,
      'count':1,
      'color':'',
      'size':'',
    },
    {
      'name':'NBA运动配件礼包',
      'image':'NBA-peijian',
      'price': 488,
      'sell':645,
      'count':1,
      'color':'',
      'size':'',
    },
    {
      'name':'NBA 彩虹运动毛巾 篮球运动健身跑步柔软吸汗毛巾',
      'image':'NBA-caihong',
      'price': 68,
      'sell':323,
      'count':1,
      'color':'',
      'size':'',
    },
  ];

  List newProduct =[
    {
      'name':'2020赛季湖人队 詹姆斯城市限定 City Edition 球迷款SW男子球衣NBA Nike',
      'image':'City Edition SM',
      'price': 399,
      'sell':321,
      'count':1,
      'color':'',
      'size':'',
    },
    {
      'name':'篮网队杜兰特球衣 SW球迷版 篮球运动比赛球衣篮球服 NBA-Nike',
      'image':'dulante SM',
      'price': 299,
      'sell':654,
      'count':1,
      'color':'',
      'size':'',
    },
    {
      'name':'【天台守夜人】2021秋季男士新款 印花连帽套头运动卫衣 中国乔丹',
      'image':'yinhualianmaotao',
      'price': 888,
      'sell':341,
      'count':1,
      'color':'',
      'size':'',
    },
    {
      'name':'【天台守夜人】男士2021新款潮流满印 篮球连帽卫衣外套 中国乔丹',
      'image':'lanqiulainmaoweiy',
      'price': 999,
      'sell':765,
      'count':1,
      'color':'',
      'size':'',
    },
    {
      'name':'运动半掌气垫减震男子跑步鞋 乔丹体育',
      'image':'idianjianzheng',
      'price': 1599,
      'sell':123,
      'count':1,
      'color':'',
      'size':'',
    },
    {
      'name':'咻-轻速科技休闲厚底增高篮球运动鞋 乔丹体育',
      'image':'xiu-qinsu',
      'price': 2699,
      'sell':64,
      'count':1,
      'color':'',
      'size':'',
    },
    {
      'name':'NBA 男士毛巾底运动袜3双装 舒适耐穿吸汗透气中筒袜子',
      'image':'mba-yundongwa',
      'price': 58,
      'sell':652,
      'count':1,
      'color':'',
      'size':'',
    },
    {
      'name':'必迈 2021跑步紧缩护腿专业运动护具',
      'image':'bimai',
      'price': 78,
      'sell':32,
      'count':1,
      'color':'',
      'size':'',
    },
  ];

  List oddsProduct =[

    {
      'name':'2021新款跑鞋全掌气垫耐磨减震轻便跑步鞋 中国乔丹',
      'image':'naimojiangzhneg',
      'price': 1599,
      'sell':515,
      'count':1,
      'color':'',
      'size':'',
    },
    {
      'name':'2022春季新款潮流减震防滑跑鞋 乔丹体育',
      'image':'chunjixingkuan',
      'price': 2599,
      'sell':203,
      'count':1,
      'color':'',
      'size':'',
    },
    {
      'name':'阿森纳93-94经典复古短袖球衣 阿迪达斯',
      'image':'asen',
      'price': 599,
      'sell':654,
      'count':1,
      'color':'',
      'size':'',
    },
    {
      'name':'阿森纳 运动套装',
      'image':'jiansheng',
      'price': 399,
      'sell':32,
      'count':1,
      'color':'',
      'size':'',
    },
    {
      'name':'2020 赛季波特兰开拓者队 Association Edition Nike NBA Swingman Jersey 男子球衣',
      'image':'Association Edition',
      'price': 299,
      'sell':221,
      'count':1,
      'color':'',
      'size':'',
    },
    {
      'name':'NBA-Nike 金州勇士队 库里 Select Series 男子球衣',
      'image':'kuli Select Series',
      'price': 499,
      'sell':351,
      'count':1,
      'color':'',
      'size':'',
    },
    {
      'name':'复古球衣-SW球迷版-独行侠队 德克·诺维茨基 蓝色客场 NBA-MN',
      'image':'fuguqiuyi',
      'price': 399,
      'sell':125,
      'count':1,
      'color':'',
      'size':'',
    },
  ];

  List NBAProduct =[
    {
      'name':'湖人队詹姆斯球衣 SW球迷版 篮球运动比赛球衣篮球服 NBA-Nike',
      'image':'smqiumiban',
      'price': 488,
      'sell':348,
      'count':1,
      'color':'',
      'size':'',
    },
    {
      'name':'金州勇士队 库里 Dri-FIT SW 男子球迷版球衣 NBA-Nike',
      'image':'kuli Dri-FIT SW',
      'price': 599,
      'sell':651,
      'count':1,
      'color':'',
      'size':'',
    },
    {
      'name':'2020赛季湖人队 詹姆斯城市限定 City Edition 球迷款SW男子球衣NBA Nike',
      'image':'City Edition SM',
      'price': 399,
      'sell':321,
      'count':1,
      'color':'',
      'size':'',
    },
    {
      'name':'篮网队杜兰特球衣 SW球迷版 篮球运动比赛球衣篮球服 NBA-Nike',
      'image':'dulante SM',
      'price': 299,
      'sell':654,
      'count':1,
      'color':'',
      'size':'',
    },
    {
      'name':'篮网队 凯文杜兰特 Dri-FIT SW 男子球迷版球衣 NBA-Nike',
      'image':'kaiwu Dri-FIT SW',
      'price': 499,
      'sell':325,
      'count':1,
      'color':'',
      'size':'',
    },

    {
      'name':'灰熊队莫兰特 Diamond IE Dri-FIT SW 男子球衣 NBA-Nike',
      'image':'Diamond IE Dri-FIT SW',
      'price': 299,
      'sell':535,
      'count':1,
      'color':'',
      'size':'',
    },
    {
      'name':'2020 赛季波特兰开拓者队 Association Edition Nike NBA Swingman Jersey 男子球衣',
      'image':'Association Edition',
      'price': 299,
      'sell':221,
      'count':1,
      'color':'',
      'size':'',
    },
    {
      'name':'NBA-Nike 金州勇士队 库里 Select Series 男子球衣',
      'image':'kuli Select Series',
      'price': 499,
      'sell':351,
      'count':1,
      'color':'',
      'size':'',
    },
    {
      'name':'复古球衣-SW球迷版-独行侠队 德克·诺维茨基 蓝色客场 NBA-MN',
      'image':'fuguqiuyi',
      'price': 399,
      'sell':125,
      'count':1,
      'color':'',
      'size':'',
    },
  ];

  List footBallProduct =[
    {
      'name':'阿森纳93-94经典复古短袖球衣 阿迪达斯',
      'image':'asen',
      'price': 599,
      'sell':654,
      'count':1,
      'color':'',
      'size':'',
    },
    {
      'name':'阿森纳 串标织带连帽卫衣',
      'image':'chuanbiaozhidai',
      'price': 299,
      'sell':522,
      'count':1,
      'color':'',
      'size':'',
    },
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: tabBarList.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      // constraints: BoxConstraints(
      //   maxWidth: 800
      // ),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          brightness: Brightness.light,
          title: Text(
            '常胜商城',
            style: TextStyle(
                fontSize: sp(19),
                color: Color(0xff333333),
                fontWeight: FontWeight.w500),
          ),
          centerTitle: true,
          actions: <Widget>[
            GestureDetector(
              onTap: (){
                if(!csMethodIsLogin(context: context)){
                  return;
                }
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ShopCar()));
              },
              child: Container(
                padding: EdgeInsets.only(right: width(20)),
                child: Image.asset(
                  CSClassImageUtil.csMethodGetShopImagePath('shop_car',),
                  color: Color(0xFF666666),
                  height: width(25),
                  width: width(25),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Color(0xFFF7F7F7),
        body: CSClassNestedScrollViewRefreshBallStyle(
          onRefresh: () async {},
          child: NestedScrollView(
            controller: _scrollController,
            headerSliverBuilder: (context, boxIsScrolled) {
              return [
                SliverToBoxAdapter(child: bannerWidget()),
                SliverToBoxAdapter(child: shopType()),
                SliverToBoxAdapter(child: discount()),
                SliverToBoxAdapter(child: productWidget()),
              ];
            },
            body: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: width(20)),
                    margin: EdgeInsets.only(bottom: width(12)),
                    child: TabBar(
                      indicatorColor: Color(0xFFD93616),
                      labelColor: Color(0xFFD93616),
                      indicatorPadding: EdgeInsets.symmetric(horizontal: width(5)),
                      labelPadding: EdgeInsets.zero,
                      unselectedLabelColor: Color(0xFF333333),
                      unselectedLabelStyle: TextStyle(fontSize: sp(17),),
                      isScrollable: false,
                      indicatorSize: TabBarIndicatorSize.label,
                      labelStyle:TextStyle(fontSize: sp(17),
                        fontWeight: FontWeight.w500,),
                      controller: _controller,
                      tabs: tabBarList.map((e) {
                        return Tab(
                          text: e,
                        );
                      }).toList(),
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _controller,
                      children: <Widget>[
                        shopItem(discountProduct),
                        shopItem(newProduct),
                        shopItem(oddsProduct),
                        shopItem(NBAProduct),
                        shopItem(footBallProduct),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

//  轮播图
  Widget bannerWidget() {
    return Stack(
      children: <Widget>[
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Image.asset(
            CSClassImageUtil.csMethodGetShopImagePath("shop_banner_bg"),
            width: MediaQuery.of(context).size.width,
          ),
        ),
        Container(
          height: width(158),
          margin: EdgeInsets.only(
            left: width(15),
            right: width(15),
            top: width(17),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(width(8)),
          ),
          child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(width(8)),
                child: Image.asset(
                  CSClassImageUtil.csMethodGetShopImagePath("shop_banner"),
                ),
              );
            },
            onTap: (index) {},
            itemCount: 1,
            viewportFraction: 1,
            scale: 1,
            autoplay: false,
          ),
        ),
      ],
    );
  }

//  商品类型
  Widget shopType() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width(23),vertical: width(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: shopTypeList.map((e) {
          return GestureDetector(
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SpecialArea(title: '${e['name']}',data: e['data'],)));
            },
            child: Container(
              child: Column(
                children: <Widget>[
                  Image.asset(
                    CSClassImageUtil.csMethodGetShopImagePath(e['image']),
                    width: width(54),
                  ),
                  Text(
                    e['name'],
                    style: TextStyle(fontSize: sp(15), color: Color(0xFF333333)),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

//  折扣专区
  Widget discount() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
              color: Color(0xFFE6E6E6),
              blurRadius: 6,
              offset:Offset.fromDirection(0,0)
          )
        ]
      ),
      margin: EdgeInsets.symmetric(horizontal: width(15)),
      padding: EdgeInsets.symmetric(horizontal: width(12), vertical: width(15)),
      child: Column(
        children: <Widget>[
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SpecialArea(title: '折扣专区',data: discountProduct,)));
            },
            child: Row(
              children: <Widget>[
                Image.asset(
                  CSClassImageUtil.csMethodGetShopImagePath('zekou'),
                  width: width(100),
                ),
                Expanded(
                  child: SizedBox(),
                ),
                Text(
                  '全部',
                  style: TextStyle(fontSize: sp(13), color: Color(0xFF666666)),
                ),
                Image.asset(
                  CSClassImageUtil.csMethodGetShopImagePath('jiantou_right'),
                  width: width(23),
                ),
              ],
            ),
          ),
          SizedBox(
            height: width(8),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    CSClassNavigatorUtils.csMethodPushRoute(
                        context,
                        ProductDetail(
                          data: discountProduct[0],
                        ));
                  },
                  child: Stack(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0xFFF7F7F7),
                            borderRadius: BorderRadius.circular(width(8))
                        ),
                        padding: EdgeInsets.all(width(15)),
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: width(115),
                              height: width(115),
                              child: Image.asset(
                                CSClassImageUtil.csMethodGetShopImagePath('${discountProduct[0]['image']}-1'),
                                width: width(115),
                              ),
                            ),
                            SizedBox(
                              height: width(8),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                RichText(
                                  text: TextSpan(
                                    text: '￥',
                                    style: TextStyle(
                                        fontSize: sp(12), color: Color(0xFF303133)),
                                    children: [
                                      TextSpan(
                                        text: '${discountProduct[0]['price']}',
                                        style: TextStyle(
                                            fontSize: sp(15), color: Color(0xFF303133),fontWeight: FontWeight.w500),
                                      )
                                    ]
                                  ),
                                ),
                                SizedBox(
                                  width: width(4),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Color(0xFFD93616),
                                      borderRadius: BorderRadius.circular(width(2))),
                                  padding: EdgeInsets.symmetric(horizontal: width(4)),
                                  child: Text(
                                    '七折',
                                    style: TextStyle(
                                        fontSize: sp(12), color: Colors.white),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(51, 169, 255,0.05,),
                              borderRadius: BorderRadius.circular(width(4))
                          ),
                          padding: EdgeInsets.symmetric(horizontal: width(8)),
                          child: Text('${discountProduct[0]['sell']}件已售',style: TextStyle(fontSize: sp(12),color: Color(0xFF33A9FF)),),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: width(12),),
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    CSClassNavigatorUtils.csMethodPushRoute(
                        context,
                        ProductDetail(
                          data: discountProduct[1],
                        ));
                  },
                  child: Stack(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0xFFF7F7F7),
                            borderRadius: BorderRadius.circular(width(8))
                        ),
                        padding: EdgeInsets.all(width(15)),
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: width(115),
                              height: width(115),
                              child: Image.asset(
                                CSClassImageUtil.csMethodGetShopImagePath('${discountProduct[1]['image']}-1'),
                                width: width(115),
                              ),
                            ),
                            SizedBox(
                              height: width(8),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                RichText(
                                  text: TextSpan(
                                      text: '￥',
                                      style: TextStyle(
                                          fontSize: sp(12), color: Color(0xFF303133)),
                                      children: [
                                        TextSpan(
                                          text: '${discountProduct[1]['price']}',
                                          style: TextStyle(
                                              fontSize: sp(15), color: Color(0xFF303133),fontWeight: FontWeight.w500),
                                        )
                                      ]
                                  ),
                                ),
                                SizedBox(
                                  width: width(4),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Color(0xFFD93616),
                                      borderRadius: BorderRadius.circular(width(2))),
                                  padding: EdgeInsets.symmetric(horizontal: width(4)),
                                  child: Text(
                                    '七折',
                                    style: TextStyle(
                                        fontSize: sp(12), color: Colors.white),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(51, 169, 255,0.05,),
                              borderRadius: BorderRadius.circular(width(4))
                          ),
                          padding: EdgeInsets.symmetric(horizontal: width(8)),
                          child: Text('${discountProduct[1]['sell']}件已售',style: TextStyle(fontSize: sp(12),color: Color(0xFF33A9FF)),),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  //新品上架
  Widget productWidget() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width(15),vertical: width(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SpecialArea(title: '新品上架',data: newProduct,)));
              },
              child: Container(
                height: width(172),
                padding: EdgeInsets.only(left:  width(12),right:  width(12),top:  width(10),bottom:  width(8)),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(width(8)),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xFFE6E6E6),
                          blurRadius: 6,
                          offset:Offset.fromDirection(0,0)
                      )
                    ]
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text('新品上架',style: TextStyle(fontSize: sp(17),fontWeight: FontWeight.bold),),
                        Image.asset(
                          CSClassImageUtil.csMethodGetShopImagePath('#'),
                          width: width(19),
                        ),
                      ],
                    ),

                    Text('热门装备  抢先体验',style: TextStyle(color: Color(0xFF666666),fontSize: sp(12)),),
                    SizedBox(height: width(12),),
                    Container(
                      child: Row(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Image.asset(
                                CSClassImageUtil.csMethodGetShopImagePath('${newProduct[0]['image']}-1'),
                                width: width(61),
                              ),
                              RichText(
                                text: TextSpan(
                                    text: '￥',
                                    style: TextStyle(
                                        fontSize: sp(12), color: Color(0xFF303133)
                                    ),
                                    children: [
                                      TextSpan(
                                        text: '${newProduct[0]['price']}',
                                        style: TextStyle(
                                            fontSize: sp(15), color: Color(0xFF303133),
                                          fontWeight: FontWeight.w500,
                                        ),),
                                      TextSpan(
                                        text: '\n   新品',
                                        style: TextStyle(
                                          fontSize: sp(12), color: Color(0xFF999999),
                                        ),)
                                    ]
                                ),
                              )
                            ],
                          ),
                          SizedBox(width: width(12),),
                          Column(
                            children: <Widget>[
                              Image.asset(
                                CSClassImageUtil.csMethodGetShopImagePath('${newProduct[1]['image']}-1'),
                                width: width(61),
                              ),
                              RichText(
                                text: TextSpan(
                                    text: '￥',
                                    style: TextStyle(
                                        fontSize: sp(12), color: Color(0xFF303133)),
                                    children: [
                                      TextSpan(
                                        text: '${newProduct[1]['price']}',
                                        style: TextStyle(
                                          fontSize: sp(15), color: Color(0xFF303133),
                                          fontWeight: FontWeight.w500
                                        ),),
                                      TextSpan(
                                        text: '\n   新品',
                                        style: TextStyle(
                                          fontSize: sp(12), color: Color(0xFF999999),
                                        ),)
                                    ]
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: width(9),
          ),
          Expanded(
            child: GestureDetector(
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SpecialArea(title: '特惠商品',data: oddsProduct,)));
              },
              child:Container(
                height: width(172),
                padding: EdgeInsets.only(left:  width(12),right:  width(12),top:  width(10),bottom:  width(8)),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(width(8)),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xFFE6E6E6),
                          blurRadius: 6,
                          offset:Offset.fromDirection(0,0)
                      )
                    ]
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text('特惠商品',style: TextStyle(fontSize: sp(17),fontWeight: FontWeight.bold),),
                        Image.asset(
                          CSClassImageUtil.csMethodGetShopImagePath('youhui'),
                          width: width(42),
                        ),
                      ],
                    ),
                    Text('特惠专区  火热来袭',style: TextStyle(color: Color(0xFF666666),fontSize: sp(12)),),
                    SizedBox(height: width(12),),
                    Container(
                      child: Row(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Image.asset(
                                CSClassImageUtil.csMethodGetShopImagePath('${oddsProduct[0]['image']}-1'),
                                width: width(61),
                              ),
                              RichText(
                                text: TextSpan(
                                    text: '￥',
                                    style: TextStyle(
                                        fontSize: sp(12), color: Color(0xFF303133)),
                                    children: [
                                      TextSpan(
                                        text: '${oddsProduct[0]['price']}',
                                        style: TextStyle(
                                            fontSize: sp(15), color: Color(0xFF303133),fontWeight: FontWeight.w500),
                                      ),
                                      TextSpan(
                                        text: '\n  ￥',
                                        style: TextStyle(
                                            fontSize: sp(10), color: Color(0xFF999999),decoration: TextDecoration.lineThrough),
                                      ),
                                      TextSpan(
                                        text: '${oddsProduct[0]['price']+100}',
                                        style: TextStyle(
                                            fontSize: sp(12), color: Color(0xFF999999),decoration: TextDecoration.lineThrough),
                                      )
                                    ]
                                ),
                              )
                            ],
                          ),
                          SizedBox(width: width((12)),),
                          Column(
                            children: <Widget>[
                              Image.asset(
                                CSClassImageUtil.csMethodGetShopImagePath('${oddsProduct[1]['image']}-1'),
                                width: width(61),
                              ),
                              RichText(
                                text: TextSpan(
                                    text: '￥',
                                    style: TextStyle(
                                        fontSize: sp(12), color: Color(0xFF303133)),
                                    children: [
                                      TextSpan(
                                        text: '${oddsProduct[1]['price']}',
                                        style: TextStyle(
                                            fontSize: sp(15), color: Color(0xFF303133),fontWeight: FontWeight.w500),
                                      ),
                                      TextSpan(
                                        text: '\n  ￥',
                                        style: TextStyle(
                                            fontSize: sp(10), color: Color(0xFF999999),decoration: TextDecoration.lineThrough),
                                      ),
                                      TextSpan(
                                        text: '${oddsProduct[1]['price']+100}',
                                        style: TextStyle(
                                            fontSize: sp(12), color: Color(0xFF999999),decoration: TextDecoration.lineThrough),
                                      )
                                    ]
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget shopItem(List list) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width(15)),
      child: GridView.builder(
          padding: EdgeInsets.zero,
          itemCount: list.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: width(10),
              childAspectRatio: width(156) / width(240)),
          itemBuilder: (context, index) {
            Map data = list[index];
            return GestureDetector(
              onTap: () {
                CSClassNavigatorUtils.csMethodPushRoute(
                    context,
                    ProductDetail(
                      data: data,
                    ));
              },
              child: Container(
                margin: EdgeInsets.only(bottom: width(8)),
                padding: EdgeInsets.all(width(8)),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(width(8))
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        height: width(156),
                        child: Image.asset(
                          CSClassImageUtil.csMethodGetShopImagePath('${data['image']}-1'),
                        ),
                      ),
                    ),
                    Text(data['name'],style:TextStyle(fontSize: sp(13)),maxLines: 2,overflow: TextOverflow.ellipsis,),
                    Row(
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                              text: '￥',
                              style: TextStyle(
                                  fontSize: sp(12), color: Color(0xFFEB3E1C)),
                              children: [
                                TextSpan(
                                  text: '${data['price']}',
                                  style: TextStyle(
                                      fontSize: sp(15), color: Color(0xFFEB3E1C),fontWeight: FontWeight.w500),
                                )
                              ]
                          ),
                        ),

                        RichText(
                          text: TextSpan(
                              text: '￥',
                              style: TextStyle(
                                  fontSize: sp(10), color: Color(0XFF999999)),
                              children: [
                                TextSpan(
                                  text: '${data['price']+100}',
                                  style: TextStyle(
                                      fontSize: sp(12), color: Color(0XFF999999),decoration: TextDecoration.lineThrough,),
                                )
                              ]
                          ),
                        ),
                        // Expanded(
                        //   child:Text(
                        //     '已售${data['sell']}件',
                        //     style: TextStyle(
                        //       color: Color(0XFF999999),
                        //       fontSize: sp(12),
                        //     ),
                        //     maxLines: 1,
                        //     overflow: TextOverflow.ellipsis,
                        //     textAlign: TextAlign.end,
                        //   ),
                        // ),

                      ],
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}

