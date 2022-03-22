import 'package:changshengh5/utils/colors.dart';
import 'package:changshengh5/widgets/CSClassToolBar.dart';
import 'package:flutter/material.dart';
import 'CSClassMyFollowExpertPage.dart';

class FollowExpertPage extends StatefulWidget {
  const FollowExpertPage({Key? key}) : super(key: key);

  @override
  _FollowExpertPageState createState() => _FollowExpertPageState();
}

class _FollowExpertPageState extends State<FollowExpertPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CSClassToolBar(
        context,
        title:"我的关注",
        csProBgColor: MyColors.main1,
        iconColor: 0xFFFFFFFF,
      ),
      body: CSClassMyFollowExpertPage(),
    );
  }
}
