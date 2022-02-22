import 'package:changshengh5/pages/common/AnimationImagePage.dart';
import 'package:changshengh5/untils/SPClassCommonMethods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

/// 经典Header
class SPClassBallHeader extends Header {
  /// Key
  final Key ?key;

  /// 方位
  final AlignmentGeometry ?alignment;

  /// 提示刷新文字
   String ?spProRefreshText="下拉刷新";

  /// 准备刷新文字
   String ?spProRefreshReadyText="释放刷新";

  /// 正在刷新文字
   String ?spProRefreshingText="刷新中...";

  /// 刷新完成文字
   String ?spProRefreshedText="刷新完成";

  /// 刷新失败文字
   String ?spProRefreshFailedText="刷新失败";

  /// 没有更多文字
   String ?spProNoMoreText="没有更多";

  /// 显示额外信息(默认为时间)
   bool ?spProShowInfo=true;

  /// 更多信息
   String ?spProInfoText="最后更新时间 %T";

  /// 背景颜色
   Color ?spProBgColor=Colors.transparent;

  /// 字体颜色
   Color ?textColor=Colors.black;


  SPClassBallHeader({
    triggerDistance = 70.0,
    float = false,
    completeDuration = const Duration(milliseconds: 500),
    enableInfiniteRefresh = false,
    enableHapticFeedback = true,
    this.key,
    this.alignment,
    this.spProShowInfo,
    this.spProBgColor,
    this.textColor
  }) : super(
    extent: width(50),
    triggerDistance: triggerDistance,
    float: float,
    completeDuration: float
        ? completeDuration == null
        ? Duration(
      milliseconds: 400,
    )
        : completeDuration +
        Duration(
          milliseconds: 400,
        )
        : completeDuration,
    enableInfiniteRefresh: enableInfiniteRefresh,
    enableHapticFeedback: enableHapticFeedback,
  );

  @override
  Widget contentBuilder(
      BuildContext ?context,
      RefreshMode ?spProRefreshState,
      double ?spProPulledExtent,
      double ?spProRefreshTriggerPullDistance,
      double ?spProRefreshIndicatorExtent,
      AxisDirection ?axisDirection,
      bool ?float,
      Duration ?completeDuration,
      bool ?enableInfiniteRefresh,
      bool ?success,
      bool ?noMore) {
    return SPClassBallHeaderWidget(
      key: key,
      spProBallHeader: this,
      spProRefreshState: spProRefreshState,
      spProPulledExtent: spProPulledExtent,
      spProRefreshTriggerPullDistance: spProRefreshTriggerPullDistance,
      spProRefreshIndicatorExtent: spProRefreshIndicatorExtent,
      axisDirection: axisDirection,
      float: float,
      completeDuration: completeDuration,
      enableInfiniteRefresh: enableInfiniteRefresh,
      success: success,
      noMore: noMore,
    );
  }
}

/// 经典Header组件
class SPClassBallHeaderWidget extends StatefulWidget {
  final SPClassBallHeader ?spProBallHeader;
  final RefreshMode ?spProRefreshState;
  final double ?spProPulledExtent;
  final double ?spProRefreshTriggerPullDistance;
  final double ?spProRefreshIndicatorExtent;
  final AxisDirection ?axisDirection;
  final bool ?float;
  final Duration ?completeDuration;
  final bool ?enableInfiniteRefresh;
  final bool ?success;
  final bool ?noMore;

  SPClassBallHeaderWidget(
      {Key? key,
        this.spProRefreshState,
        this.spProBallHeader,
        this.spProPulledExtent,
        this.spProRefreshTriggerPullDistance,
        this.spProRefreshIndicatorExtent,
        this.axisDirection,
        this.float,
        this.completeDuration,
        this.enableInfiniteRefresh,
        this.success,
        this.noMore})
      : super(key: key);

  @override
  SPClassBallHeaderWidgetState createState() => SPClassBallHeaderWidgetState();
}



class SPClassBallHeaderWidgetState extends State<SPClassBallHeaderWidget>
    with TickerProviderStateMixin<SPClassBallHeaderWidget> {
  // 是否到达触发刷新距离
  bool _overTriggerDistance = false;

  bool get spProOverTriggerDistance => _overTriggerDistance;

  set spProOverTriggerDistance(bool over) {
    if (_overTriggerDistance != over) {
      _overTriggerDistance
          ? _readyController.forward()
          : _restoreController.forward();
      _overTriggerDistance = over;
    }
  }

  // 是否刷新完成
  bool _refreshFinish = false;

  set refreshFinish(bool finish) {
    if (_refreshFinish != finish) {
      if (finish && widget.float!) {
        Future.delayed(widget.completeDuration! - Duration(milliseconds: 200),
                () {
              if (mounted) {
                _floatBackController.forward();
              }
            });
        Future.delayed(widget.completeDuration!, () {
          _floatBackDistance = 0.0;
          _refreshFinish = false;
        });
      }
      _refreshFinish = finish;
    }
  }

  // 动画
  late AnimationController _readyController;
  late Animation<double> _readyAnimation;
  late AnimationController _restoreController;
  late Animation<double> _restoreAnimation;
  late AnimationController _floatBackController;
  late Animation<double> _floatBackAnimation;
  late AnimationController spProControllerLoading;

  // Icon旋转度
  double _iconRotationValue = 1.0;

  // 浮动时,收起距离
  late double _floatBackDistance =0.0;

  // 显示文字
  String get _showText {
    if (widget.noMore!) return widget.spProBallHeader!.spProNoMoreText!;
    if (widget.enableInfiniteRefresh!) {
      if (widget.spProRefreshState == RefreshMode.refreshed ||
          widget.spProRefreshState == RefreshMode.inactive ||
          widget.spProRefreshState == RefreshMode.drag) {
        return widget.spProBallHeader!.spProRefreshedText!;
      } else {
        return widget.spProBallHeader!.spProRefreshingText!;
      }
    }
    switch (widget.spProRefreshState) {
      case RefreshMode.refresh:
        return widget.spProBallHeader!.spProRefreshingText!;
      case RefreshMode.armed:
        return widget.spProBallHeader!.spProRefreshingText!;
      case RefreshMode.refreshed:
        return _finishedText;
      case RefreshMode.done:
        return _finishedText;
      default:
        if (spProOverTriggerDistance) {
          return widget.spProBallHeader!.spProRefreshReadyText!;
        } else {
          return widget.spProBallHeader!.spProRefreshText!;
        }
    }
  }

  // 刷新结束文字
  String get _finishedText {
    if (!widget.success!) return widget.spProBallHeader!.spProRefreshFailedText!;
    if (widget.noMore!) return widget.spProBallHeader!.spProNoMoreText!;
    return widget.spProBallHeader!.spProRefreshedText!;
  }

  // 刷新结束图标
  IconData get _finishedIcon {
    if (!widget.success!) return Icons.error_outline;
    if (widget.noMore!) return Icons.hourglass_empty;
    return Icons.done;
  }

  // 更新时间
  late DateTime _dateTime;

  // 获取更多信息
  String get _infoText {
    if (widget.spProRefreshState == RefreshMode.refreshed) {
      _dateTime = DateTime.now();
    }
    String fillChar = _dateTime.minute < 10 ? "0" : "";
    return widget.spProBallHeader!.spProInfoText
        !.replaceAll("%T", "${_dateTime.hour}:$fillChar${_dateTime.minute}");
  }

  @override
  void initState() {
    super.initState();
    // 初始化时间
    _dateTime = DateTime.now();
    // 准备动画
    spProControllerLoading= AnimationController(duration: const Duration(milliseconds: 400), vsync: this);
    spProControllerLoading.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        //动画从 controller.forward() 正向执行 结束时会回调此方法
        //重置起点
        spProControllerLoading.reset();
        //开启
        await Future.delayed(Duration(milliseconds: 100));
        spProControllerLoading.forward();
      }
    });
    spProControllerLoading.forward();
    _readyController = new AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    _readyAnimation = new Tween(begin: 0.5, end: 1.0).animate(_readyController)
      ..addListener(() {
        setState(() {
          if (_readyAnimation.status != AnimationStatus.dismissed) {
            _iconRotationValue = _readyAnimation.value;
          }
        });
      });
    _readyAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _readyController.reset();
      }
    });
    // 恢复动画
    _restoreController = new AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    _restoreAnimation =
    new Tween(begin: 1.0, end: 0.5).animate(_restoreController)
      ..addListener(() {
        setState(() {
          if (_restoreAnimation.status != AnimationStatus.dismissed) {
            _iconRotationValue = _restoreAnimation.value;
          }
        });
      });
    _restoreAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _restoreController.reset();
      }
    });
    // float收起动画
    _floatBackController = new AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    _floatBackAnimation =
    new Tween(begin: widget.spProRefreshIndicatorExtent, end: 0.0)
        .animate(_floatBackController)
      ..addListener(() {
        setState(() {
          if (_floatBackAnimation.status != AnimationStatus.dismissed) {
            _floatBackDistance = _floatBackAnimation.value;
          }
        });
      });
    _floatBackAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _floatBackController.reset();
      }
    });
  }

  @override
  void dispose() {
    _readyController.dispose();
    _restoreController.dispose();
    _floatBackController.dispose();
    spProControllerLoading.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 是否为垂直方向
    bool isVertical = widget.axisDirection == AxisDirection.down ||
        widget.axisDirection == AxisDirection.up;
    // 是否反向
    bool isReverse = widget.axisDirection == AxisDirection.up ||
        widget.axisDirection == AxisDirection.left;
    // 是否到达触发刷新距离
    spProOverTriggerDistance = widget.spProRefreshState != RefreshMode.inactive &&
        widget.spProPulledExtent! >= widget.spProRefreshTriggerPullDistance!;
    if (widget.spProRefreshState == RefreshMode.refreshed) {
      refreshFinish = true;
    }
    return Container(
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: !isVertical
                ? 0.0
                : isReverse
                ? _floatBackDistance == null
                ? 0.0
                : (widget.spProRefreshIndicatorExtent! - _floatBackDistance)
                : null,
            bottom: !isVertical
                ? 0.0
                : !isReverse
                ? _floatBackDistance == null
                ? 0.0
                : (widget.spProRefreshIndicatorExtent! - _floatBackDistance)
                : null,
            left: isVertical
                ? 0.0
                : isReverse
                ? _floatBackDistance == null
                ? 0.0
                : (widget.spProRefreshIndicatorExtent! - _floatBackDistance)
                : null,
            right: isVertical
                ? 0.0
                : !isReverse
                ? _floatBackDistance == null
                ? 0.0
                : (widget.spProRefreshIndicatorExtent! - _floatBackDistance)
                : null,
            child: Container(
              alignment:
              // widget.spProBallHeader.alignment ?? 标记

                  isVertical
                  ? isReverse ? Alignment.topCenter : Alignment.bottomCenter
                  : !isReverse ? Alignment.centerRight : Alignment.centerLeft,
              width: isVertical
                  ? double.infinity
                  : _floatBackDistance == null
                  ? (widget.spProRefreshIndicatorExtent! > widget.spProPulledExtent!
                  ? widget.spProRefreshIndicatorExtent
                  : widget.spProPulledExtent)
                  : widget.spProRefreshIndicatorExtent,
              height: isVertical
                  ? _floatBackDistance == null
                  ? (widget.spProRefreshIndicatorExtent! > widget.spProPulledExtent!
                  ? widget.spProRefreshIndicatorExtent
                  : widget.spProPulledExtent)
                  : widget.spProRefreshIndicatorExtent
                  : double.infinity,
              color: widget.spProBallHeader!.spProBgColor,
              child: SizedBox(
                height:
                isVertical ? widget.spProRefreshIndicatorExtent : double.infinity,
                width:
                !isVertical ? widget.spProRefreshIndicatorExtent : double.infinity,
                child: isVertical
                    ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildContent(isVertical, isReverse),
                )
                    : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildContent(isVertical, isReverse),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 构建显示内容
  List<Widget> _buildContent(bool isVertical, bool isReverse) {
    return <Widget>[
      Container(
        alignment: Alignment.centerRight,
        // padding: EdgeInsets.only(
        //   right: 10.0,
        // ),
        child: (widget.spProRefreshState == RefreshMode.refresh ||
            widget.spProRefreshState == RefreshMode.armed) &&
            !widget.noMore!
            ?
        AnimationImagePage(width: width(50),height: width(50),)
            :Image.asset(
          'assets/animationImages/足球动效_00007.png',
          width: width(50),
          height: width(50),
        )
        // RotationTransition(
        //   turns: spProControllerLoading,
        //   alignment: Alignment.center,
        //   child:
        //   Image.asset(
        //     SPClassImageUtil.spFunGetImagePath('ic_ball_loadding'),
        //     width:  width(20),
        //   ) ,
        // )
        //     :
        // Image.asset(
        //   !widget.success ?SPClassImageUtil.spFunGetImagePath("ic_ball_loadding_fail"):SPClassImageUtil.spFunGetImagePath("ic_ball_loadding"),
        //   width: width(20),
        // ),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            _showText,
            style: TextStyle(
              fontSize: sp(10),
              color: widget.spProBallHeader!.textColor!,
            ),
          ),
        ],
      )
    ];
  }
}

