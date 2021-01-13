/*
 * @discripe: 关注
 */
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:z/base/zawazawa_base.dart';
import 'package:z/common/app_header.dart';
import 'package:z/common/app_index_header.dart';
import 'package:z/common/app_left_drawer.dart';
import 'package:z/common/app_scroll_list.dart';

// 首页总结构
/// 该页头部为自定义手势实现的与斗鱼安卓APP相同效果，而不是像首页那样直接调用Flutter封装好的[AppBar]的交互。
/// 头部[AnimatedBuilder]动画封装
class AnimatedHeader extends StatefulWidget {
  final Key key;
  final Tween<double> opacityTween, heightTween;
  final Function cb;

  AnimatedHeader({
    this.key,
    this.opacityTween,
    this.heightTween,
    this.cb,
  });

  @override
  _AnimatedHeader createState() => _AnimatedHeader();
}

class _AnimatedHeader extends State<AnimatedHeader>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(milliseconds: 250), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeOut);
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.cb();
      }
    });
    controller.forward();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext ctx, Widget child) {
        return ZawazawaHeader(
          height: widget.heightTween.evaluate(animation),
          opacity: widget.opacityTween.evaluate(animation),
        );
      },
    );
  }
}

// ignore: must_be_immutable
class IndexPage extends StatefulWidget with ZawazawaBase {
  double headerHeightMax;

  //设置头部导航栏高度
  IndexPage() {
    //状态栏加55
    headerHeightMax =
        ZawazawaBase.statusBarHeight + dp(ZawazawaBase.headerHeightMax);
  }

  @override
  _IndexPageState createState() => _IndexPageState(headerHeightMax);
}

class _IndexPageState extends State<IndexPage>
    with ZawazawaBase, TickerProviderStateMixin {
  //页面数据
  List indexData;

  //头部导航栏高度
  double _headerHeight;

  //头部导航栏透明度
  double _headerOpacity = 1.0;

  //透明度 高度
  Tween<double> _opacityTween, _heightTween;

  //是否正处于动画状态
  bool _isAnimating = false;

  bool _isShowPublishButton = false;

  PointerDownEvent _pointDownEvent;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  _IndexPageState(this._headerHeight);

  @override
  void initState() {
    super.initState();
  }

  //滑动事件
  void _onPointerMove(PointerMoveEvent e) {
    //e.delate.dy distance Y Y轴滑动距离
    var nextHeight = _headerHeight + e.delta.dy;

    //如果头部导航栏高度小于状态栏 || 头部导航栏大于规定的最大高度
    if (nextHeight >= widget.headerHeightMax) {
      //弹出发布按钮
      return;
    }

    if (nextHeight <= ZawazawaBase.statusBarHeight) {
      return;
    }

    setState(() {
      //TODO 隐藏float按钮
      //设置头部导航栏高度
      _headerHeight = nextHeight;

      //设置头部导航栏透明度
      _headerOpacity = (nextHeight - ZawazawaBase.statusBarHeight) / dp(55);
    });
  }

  //点击事件
  void _onPointerDown(PointerDownEvent e) {
    _pointDownEvent = e;
  }

  //抬起事件
  void _onPointerUp(PointerUpEvent e) {
    double headerHeightNow = _headerHeight, //头部导航栏高度
        headerOpacityNow = _headerOpacity, //头部导航栏透明度
        direction; // header动画方向，1-展开；0-收起

    // 快速滚动捕获，触摸松开间隔小于300ms直接根据滚动方向伸缩header
    if ((_pointDownEvent != null) &&
        (e.timeStamp.inMilliseconds - _pointDownEvent.timeStamp.inMilliseconds <
            300)) {
      //向下
      if (e.position.dy > _pointDownEvent.position.dy) {
        print("向下滑动");
        direction = 1;
      } else {
        //向上
        print("向shang滑动");
        direction = 0;
      }
    }
    // 滚动松开时header高度一半以下收起
    else if (_headerHeight <
        (widget.headerHeightMax / 2 + dp(ZawazawaBase.statusBarHeight))) {
      direction = 0;
    }
    // 超过一半就完展开
    else {
      direction = 1;
    }

    setState(() {
      if (direction == 0) {
        _headerHeight = ZawazawaBase.statusBarHeight;
        _headerOpacity = 0;
        _isShowPublishButton = false;
      } else {
        _headerHeight = widget.headerHeightMax;
        _headerOpacity = 1;
        _isShowPublishButton = true;
      }
      _heightTween = Tween(
        begin: headerHeightNow,
        end: _headerHeight,
      );
      _opacityTween = Tween(
        begin: headerOpacityNow,
        end: _headerOpacity,
      );
      _isAnimating = true;
    });
  }

  void _animateEndCallBack() {
    setState(() {
      _isAnimating = false;
    });
  }

  /// 在[ListView]之上无法通过[GestureDetector]进行手势捕获，因为部分手势（如上下滑）会提前被[ListView]所命中。
  /// 所以在整个页面的最外层使用底层[Listener]监听原始触摸事件，判断手势需要自己取坐标计算。
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(238, 238, 238, 1),
      drawer: Container(
        width: MediaQuery.of(context).size.width * 0.75,
        child: LeftDrawer(),
      ),
      body: Column(
        children: [
          _isAnimating
              ? AnimatedHeader(
                  key: ObjectKey(_isAnimating),
                  opacityTween: _opacityTween,
                  heightTween: _heightTween,
                  cb: _animateEndCallBack,
                )
              : ZawazawaHeader(
                  height: _headerHeight,
                  opacity: _headerOpacity,
                ),
          Expanded(
              child: Listener(
            onPointerUp: _onPointerUp,
            onPointerMove: _onPointerMove,
            onPointerDown: _onPointerDown,
            child: ScrollList(),
          )),
        ],
      ),
      floatingActionButton: _isShowPublishButton
          ? FloatingActionButton(
              onPressed: () => print("FloatingActionButton"),
              child: IconButton(icon: Icon(Icons.add), onPressed: () {}),
              tooltip: "按这么长时间干嘛",
              foregroundColor: Colors.white,
              backgroundColor: Colors.blue,
              elevation: 6.0,
              highlightElevation: 12.0,
              shape: CircleBorder())
          : null,
    );
  }
}

// 去除安卓滚动视图水波纹
class DyBehaviorNull extends ScrollBehavior {
//  @override
//  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
//    if (Platform.isAndroid || Platform.isFuchsia) {
//      return child;
//    } else {
//      return super.buildViewportChrome(context,child,axisDirection);
//    }
//  }
}
