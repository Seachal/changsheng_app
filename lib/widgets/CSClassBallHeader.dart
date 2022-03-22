import 'package:changshengh5/pages/common/AnimationImagePage.dart';
import 'package:changshengh5/utils/CSClassCommonMethods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

/// 经典Header
class CSClassBallHeader extends Header {
  /// Key
  final Key ?key;

  /// 方位
  final AlignmentGeometry ?alignment;

  /// 提示刷新文字
   String ?csProRefreshText="下拉刷新";

  /// 准备刷新文字
   String ?csProRefreshReadyText="释放刷新";

  /// 正在刷新文字
   String ?csProRefreshingText="刷新中...";

  /// 刷新完成文字
   String ?csProRefreshedText="刷新完成";

  /// 刷新失败文字
   String ?csProRefreshFailedText="刷新失败";

  /// 没有更多文字
   String ?csProNoMoreText="没有更多";

  /// 显示额外信息(默认为时间)
   bool ?csProShowInfo=true;

  /// 更多信息
   String ?csProInfoText="最后更新时间 %T";

  /// 背景颜色
   Color ?csProBgColor=Colors.transparent;

  /// 字体颜色
   Color ?textColor=Colors.black;


  CSClassBallHeader({
    triggerDistance = 70.0,
    float = false,
    completeDuration = const Duration(milliseconds: 500),
    enableInfiniteRefresh = false,
    enableHapticFeedback = true,
    this.key,
    this.alignment,
    this.csProShowInfo,
    this.csProBgColor,
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
      RefreshMode ?csProRefreshState,
      double ?csProPulledExtent,
      double ?csProRefreshTriggerPullDistance,
      double ?csProRefreshIndicatorExtent,
      AxisDirection ?axisDirection,
      bool ?float,
      Duration ?completeDuration,
      bool ?enableInfiniteRefresh,
      bool ?success,
      bool ?noMore) {
    return CSClassBallHeaderWidget(
      key: key,
      csProBallHeader: this,
      csProRefreshState: csProRefreshState,
      csProPulledExtent: csProPulledExtent,
      csProRefreshTriggerPullDistance: csProRefreshTriggerPullDistance,
      csProRefreshIndicatorExtent: csProRefreshIndicatorExtent,
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
class CSClassBallHeaderWidget extends StatefulWidget {
  final CSClassBallHeader ?csProBallHeader;
  final RefreshMode ?csProRefreshState;
  final double ?csProPulledExtent;
  final double ?csProRefreshTriggerPullDistance;
  final double ?csProRefreshIndicatorExtent;
  final AxisDirection ?axisDirection;
  final bool ?float;
  final Duration ?completeDuration;
  final bool ?enableInfiniteRefresh;
  final bool ?success;
  final bool ?noMore;

  CSClassBallHeaderWidget(
      {Key? key,
        this.csProRefreshState,
        this.csProBallHeader,
        this.csProPulledExtent,
        this.csProRefreshTriggerPullDistance,
        this.csProRefreshIndicatorExtent,
        this.axisDirection,
        this.float,
        this.completeDuration,
        this.enableInfiniteRefresh,
        this.success,
        this.noMore})
      : super(key: key);

  @override
  CSClassBallHeaderWidgetState createState() => CSClassBallHeaderWidgetState();
}



class CSClassBallHeaderWidgetState extends State<CSClassBallHeaderWidget>
    with TickerProviderStateMixin<CSClassBallHeaderWidget> {
  // 是否到达触发刷新距离
  bool _overTriggerDistance = false;

  bool get csProOverTriggerDistance => _overTriggerDistance;

  set csProOverTriggerDistance(bool over) {
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
  late AnimationController csProControllerLoading;

  // Icon旋转度
  double _iconRotationValue = 1.0;

  // 浮动时,收起距离
  late double _floatBackDistance =0.0;

  // 显示文字
  String get _showText {
    if (widget.noMore!) return widget.csProBallHeader!.csProNoMoreText!;
    if (widget.enableInfiniteRefresh!) {
      if (widget.csProRefreshState == RefreshMode.refreshed ||
          widget.csProRefreshState == RefreshMode.inactive ||
          widget.csProRefreshState == RefreshMode.drag) {
        return widget.csProBallHeader!.csProRefreshedText!;
      } else {
        return widget.csProBallHeader!.csProRefreshingText!;
      }
    }
    switch (widget.csProRefreshState) {
      case RefreshMode.refresh:
        return widget.csProBallHeader!.csProRefreshingText!;
      case RefreshMode.armed:
        return widget.csProBallHeader!.csProRefreshingText!;
      case RefreshMode.refreshed:
        return _finishedText;
      case RefreshMode.done:
        return _finishedText;
      default:
        if (csProOverTriggerDistance) {
          return widget.csProBallHeader!.csProRefreshReadyText!;
        } else {
          return widget.csProBallHeader!.csProRefreshText!;
        }
    }
  }

  // 刷新结束文字
  String get _finishedText {
    if (!widget.success!) return widget.csProBallHeader!.csProRefreshFailedText!;
    if (widget.noMore!) return widget.csProBallHeader!.csProNoMoreText!;
    return widget.csProBallHeader!.csProRefreshedText!;
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
    if (widget.csProRefreshState == RefreshMode.refreshed) {
      _dateTime = DateTime.now();
    }
    String fillChar = _dateTime.minute < 10 ? "0" : "";
    return widget.csProBallHeader!.csProInfoText
        !.replaceAll("%T", "${_dateTime.hour}:$fillChar${_dateTime.minute}");
  }

  @override
  void initState() {
    super.initState();
    // 初始化时间
    _dateTime = DateTime.now();
    // 准备动画
    csProControllerLoading= AnimationController(duration: const Duration(milliseconds: 400), vsync: this);
    csProControllerLoading.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        //动画从 controller.forward() 正向执行 结束时会回调此方法
        //重置起点
        csProControllerLoading.reset();
        //开启
        await Future.delayed(Duration(milliseconds: 100));
        csProControllerLoading.forward();
      }
    });
    csProControllerLoading.forward();
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
    new Tween(begin: widget.csProRefreshIndicatorExtent, end: 0.0)
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
    csProControllerLoading.dispose();

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
    csProOverTriggerDistance = widget.csProRefreshState != RefreshMode.inactive &&
        widget.csProPulledExtent! >= widget.csProRefreshTriggerPullDistance!;
    if (widget.csProRefreshState == RefreshMode.refreshed) {
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
                : (widget.csProRefreshIndicatorExtent! - _floatBackDistance)
                : null,
            bottom: 0,
            // !isVertical
            //     ? 0.0
            //     : !isReverse
            //     ? _floatBackDistance == null
            //     ? 0.0
            //     : (widget.csProRefreshIndicatorExtent! - _floatBackDistance)
            //     : null,
            left: isVertical
                ? 0.0
                : isReverse
                ? _floatBackDistance == null
                ? 0.0
                : (widget.csProRefreshIndicatorExtent! - _floatBackDistance)
                : null,
            right: isVertical
                ? 0.0
                : !isReverse
                ? _floatBackDistance == null
                ? 0.0
                : (widget.csProRefreshIndicatorExtent! - _floatBackDistance)
                : null,
            child: Container(
              alignment:
              widget.csProBallHeader?.alignment!=null ?widget.csProBallHeader?.alignment:
                  isVertical
                  ? isReverse ? Alignment.topCenter : Alignment.bottomCenter
                  : !isReverse ? Alignment.centerRight : Alignment.centerLeft,
              width: isVertical
                  ? double.infinity
                  : _floatBackDistance == null
                  ? (widget.csProRefreshIndicatorExtent! > widget.csProPulledExtent!
                  ? widget.csProRefreshIndicatorExtent
                  : widget.csProPulledExtent)
                  : widget.csProRefreshIndicatorExtent,
              height: isVertical
                  ? _floatBackDistance == null
                  ? (widget.csProRefreshIndicatorExtent! > widget.csProPulledExtent!
                  ? widget.csProRefreshIndicatorExtent
                  : widget.csProPulledExtent)
                  : widget.csProRefreshIndicatorExtent
                  : double.infinity,
              color: widget.csProBallHeader!.csProBgColor,
              child: SizedBox(
                height:
                isVertical ? widget.csProRefreshIndicatorExtent : double.infinity,
                width:
                !isVertical ? widget.csProRefreshIndicatorExtent : double.infinity,
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
        child:
        (widget.csProRefreshState == RefreshMode.refresh ||
            widget.csProRefreshState == RefreshMode.armed) &&
            !widget.noMore!
            ?
        AnimationImagePage(width: width(50),height: width(50),)
            :
        Image.asset(
          'assets/animationImages/足球动效_00007.png',
          width: width(50),
          height: width(50),
        )
        // RotationTransition(
        //   turns: csProControllerLoading,
        //   alignment: Alignment.center,
        //   child:
        //   Image.asset(
        //     CSClassImageUtil.csMethodGetImagePath('ic_ball_loadding'),
        //     width:  width(20),
        //   ) ,
        // )
        //     :
        // Image.asset(
        //   !widget.success ?CSClassImageUtil.csMethodGetImagePath("ic_ball_loadding_fail"):CSClassImageUtil.csMethodGetImagePath("ic_ball_loadding"),
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
              color: widget.csProBallHeader!.textColor!,
            ),
          ),
        ],
      )
    ];
  }
}

