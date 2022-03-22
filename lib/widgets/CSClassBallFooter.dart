import 'dart:math';
import 'package:changshengh5/pages/common/AnimationImagePage.dart';
import 'package:changshengh5/utils/CSClassCommonMethods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';





/// 经典Footer
class CSClassBallFooter extends Footer {
  /// Key
  final Key? key;

  /// 方位
  final AlignmentGeometry ?alignment;

  /// 提示加载文字
  final String ?csProLoadText;

  /// 准备加载文字
  final String ?csProLoadReadyText;

  /// 正在加载文字
  final String ?csProLoadingText;

  /// 加载完成文字
  final String ?csProLoadedText;

  /// 加载失败文字
  final String ?csProLoadFailedText;

  /// 没有更多文字
  final String ?csProNoMoreText;

  /// 显示额外信息(默认为时间)
  final bool ?csProShowInfo;

  /// 更多信息
  final String ?csProInfoText;

  /// 背景颜色
  final Color ?csProBgColor;

  /// 字体颜色
  final Color ?textColor;

  /// 更多信息文字颜色
  final Color ?csProInfoColor;

  CSClassBallFooter({
    double extent = 60.0,
    double triggerDistance = 70.0,
    bool float = false,
    Duration completeDuration = const Duration(seconds: 1),
    bool enableInfiniteLoad = true,
    bool enableHapticFeedback = true,
    this.key,
    this.alignment,
    this.csProLoadText,
    this.csProLoadReadyText,
    this.csProLoadingText,
    this.csProLoadedText,
    this.csProLoadFailedText,
    this.csProNoMoreText,
    this.csProShowInfo: true,
    this.csProInfoText,
    this.csProBgColor: Colors.transparent,
    this.textColor: Colors.black,
    this.csProInfoColor: Colors.teal,
  }) : super(
    extent: extent,
    triggerDistance: triggerDistance,
    float: float,
    completeDuration: completeDuration,
    enableInfiniteLoad: enableInfiniteLoad,
    enableHapticFeedback: enableHapticFeedback,
  );

  @override
  Widget contentBuilder(
      BuildContext ?context,
      LoadMode ?csProLoadState,
      double ?csProPulledExtent,
      double ?csProLoadTriggerPullDistance,
      double ?csProLoadIndicatorExtent,
      AxisDirection ?axisDirection,
      bool ?float,
      Duration ?completeDuration,
      bool ?enableInfiniteLoad,
      bool ?success,
      bool ?noMore) {
    return CSClassBallFooterWidget(
      key: key,
      csProBallFooter: this,
      csProLoadState: csProLoadState,
      csProPulledExtent: csProPulledExtent,
      csProLoadTriggerPullDistance: csProLoadTriggerPullDistance,
      csProLoadIndicatorExtent: csProLoadIndicatorExtent,
      axisDirection: axisDirection,
      float: float,
      completeDuration: completeDuration,
      enableInfiniteLoad: enableInfiniteLoad,
      success: success,
      noMore: noMore,
    );
  }
}

/// 经典Footer组件
class CSClassBallFooterWidget extends StatefulWidget {
  final CSClassBallFooter ?csProBallFooter;
  final LoadMode ?csProLoadState;
  final double ?csProPulledExtent;
  final double ?csProLoadTriggerPullDistance;
  final double ?csProLoadIndicatorExtent;
  final AxisDirection ?axisDirection;
  final bool ?float;
  final Duration ?completeDuration;
  final bool ?enableInfiniteLoad;
  final bool ?success;
  final bool ?noMore;

  CSClassBallFooterWidget(
      {Key ?key,
        this.csProLoadState,
        this.csProBallFooter,
        this.csProPulledExtent,
        this.csProLoadTriggerPullDistance,
        this.csProLoadIndicatorExtent,
        this.axisDirection,
        this.float,
        this.completeDuration,
        this.enableInfiniteLoad,
        this.success,
        this.noMore})
      : super(key: key);

  @override
  CSClassBallFooterWidgetState createState() => CSClassBallFooterWidgetState();
}

class CSClassBallFooterWidgetState extends State<CSClassBallFooterWidget>
    with TickerProviderStateMixin<CSClassBallFooterWidget> {
  // 是否到达触发加载距离
  bool _overTriggerDistance = false;
  bool get csProOverTriggerDistance => _overTriggerDistance;
  set csProOverTriggerDistance(bool over) {
    if (_overTriggerDistance != over) {
      _overTriggerDistance
          ? _readyController.forward()
          : _restoreController.forward();
    }
    _overTriggerDistance = over;
  }



  /// 文本
  String get _loadText {
    return widget.csProBallFooter!.csProLoadText ??"";
  }

  String get _loadReadyText {
    return "释放加载";
  }

  String get _loadingText {
    return "加载中...";
  }

  String get _loadedText {
    return "加载完成";
  }

  String get _loadFailedText {
    return "加载失败";
  }

  /// 没有更多文字
  String get _noMoreText {
    return "没有更多数据";
  }

  String get _infoText {
    return "更新于 %T";
  }

  // 动画
  late AnimationController _readyController;
  late Animation<double> _readyAnimation;
  late AnimationController _restoreController;
  late Animation<double> _restoreAnimation;
  late AnimationController csProControllerLoading;

  // Icon旋转度
  double _iconRotationValue = 1.0;

  // 显示文字
  String get _showText {
    if (widget.noMore!) return _noMoreText;
    if (widget.enableInfiniteLoad!) {
      if (widget.csProLoadState == LoadMode.loaded ||
          widget.csProLoadState == LoadMode.inactive ||
          widget.csProLoadState == LoadMode.drag) {
        return _finishedText;
      } else {
        return _loadingText;
      }
    }
    switch (widget.csProLoadState) {
      case LoadMode.load:
        return _loadingText;
      case LoadMode.armed:
        return _loadingText;
      case LoadMode.loaded:
        return _finishedText;
      case LoadMode.done:
        return _finishedText;
      default:
        if (csProOverTriggerDistance) {
          return _loadReadyText;
        } else {
          return _loadText;
        }
    }
  }

  // 加载结束文字
  String get _finishedText {
    if (!widget.success!) return _loadFailedText;
    if (widget.noMore!) return _noMoreText;
    return _loadedText;
  }

  // 加载结束图标
  IconData get _finishedIcon {
    if (!widget.success!) return Icons.error_outline;
    if (widget.noMore!) return Icons.hourglass_empty;
    return Icons.done;
  }

  // 更新时间
  late DateTime _dateTime;
  // 获取更多信息
  String get _infoTextStr {
    if (widget.csProLoadState == LoadMode.loaded) {
      _dateTime = DateTime.now();
    }
    String fillChar = _dateTime.minute < 10 ? "0" : "";
    return _infoText.replaceAll(
        "%T", "${_dateTime.hour}:$fillChar${_dateTime.minute}");
  }

  @override
  void initState() {
    super.initState();
    // 初始化时间
    _dateTime = DateTime.now();

    csProControllerLoading= AnimationController(duration: const Duration(milliseconds: 1500), vsync: this);
    csProControllerLoading.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        //动画从 controller.forward() 正向执行 结束时会回调此方法
        //重置起点
        csProControllerLoading.reset();
        //开启
        csProControllerLoading.forward();
      }
    });
    csProControllerLoading.forward();
    // 初始化动画
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
  }

  @override
  void dispose() {
    _readyController.dispose();
    _restoreController.dispose();
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
    // 是否到达触发加载距离
    csProOverTriggerDistance = widget.csProLoadState != LoadMode.inactive &&
        widget.csProPulledExtent! >= widget.csProLoadTriggerPullDistance!;
    return Stack(
      children: <Widget>[
        Positioned(
          top: !isVertical ? 0.0 : !isReverse ? 0.0 : null,
          bottom: !isVertical ? 0.0 : isReverse ? 0.0 : null,
          left: isVertical ? 0.0 : !isReverse ? 0.0 : null,
          right: isVertical ? 0.0 : isReverse ? 0.0 : null,
          child: Container(
            alignment:
             widget.csProBallFooter?.alignment!=null?
             widget.csProBallFooter?.alignment:
                isVertical
                ? !isReverse ? Alignment.topCenter : Alignment.bottomCenter
                : isReverse ? Alignment.centerRight : Alignment.centerLeft,
            width: !isVertical
                ? widget.csProLoadIndicatorExtent! > widget.csProPulledExtent!
                ? widget.csProLoadIndicatorExtent
                : widget.csProPulledExtent
                : double.infinity,
            height: isVertical
                ? widget.csProLoadIndicatorExtent! > widget.csProPulledExtent!
                ? widget.csProLoadIndicatorExtent
                : widget.csProPulledExtent
                : double.infinity,
            color: widget.csProBallFooter!.csProBgColor!,
            child: SizedBox(
              height: isVertical ? widget.csProLoadIndicatorExtent : double.infinity,
              width: !isVertical ? widget.csProLoadIndicatorExtent : double.infinity,
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
    );
  }

  // 构建显示内容
  List<Widget> _buildContent(bool isVertical, bool isReverse) {
    return isVertical
        ? <Widget>[
      Container(
        alignment: Alignment.centerRight,
        // padding: EdgeInsets.only(
        //   right: 10.0,
        // ),
        child: (widget.csProLoadState == LoadMode.load ||
            widget.csProLoadState == LoadMode.armed) &&
            !widget.noMore!
            ?
        AnimationImagePage(width: width(50),height: width(50),)
            :Image.asset(
          'assets/animationImages/足球动效_00007.png',
          width: width(50),
          height: width(50),
        )
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            _showText,
            style: TextStyle(
              fontSize: sp(10),
              color: widget.csProBallFooter!.textColor!,
            ),
          ),
          widget.csProBallFooter!.csProShowInfo!
              ? Container(
            margin: EdgeInsets.only(
              top: 2.0,
            ),
            child: Text(
              _infoTextStr,
              style: TextStyle(
                fontSize: sp(10),
                color: widget.csProBallFooter!.textColor!,
              ),
            ),
          )
              : Container(),
        ],
      )
    ]
        : <Widget>[
      Container(
        child: widget.csProLoadState == LoadMode.load ||
            widget.csProLoadState == LoadMode.armed
            ? Container(
          width: 20.0,
          height: 20.0,
          child: CircularProgressIndicator(
            strokeWidth: 2.0,
            valueColor: AlwaysStoppedAnimation(
              widget.csProBallFooter!.textColor!,
            ),
          ),
        )
            : widget.csProLoadState == LoadMode.loaded ||
            widget.csProLoadState == LoadMode.done ||
            (widget.enableInfiniteLoad! &&
                widget.csProLoadState != LoadMode.loaded) ||
            widget.noMore!
            ? Icon(
          _finishedIcon,
          color: widget.csProBallFooter!.textColor!,
        )
            : Transform.rotate(
          child: Icon(
            !isReverse ? Icons.arrow_back : Icons.arrow_forward,
            color: widget.csProBallFooter!.textColor!,
          ),
          angle: 2 * pi * _iconRotationValue,
        ),
      ),
    ];
  }
}
