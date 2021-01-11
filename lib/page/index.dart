/*
 * @discripe: 关注
 */
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:z/base/zawazawa_base.dart';
import 'package:z/common/app_header.dart';
import 'package:z/common/app_index_header.dart';
import 'package:z/common/app_scroll_list.dart';

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

// 首页总结构
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
  List indexData;
  //头部导航栏高度
  double _headerHeight;
  double _headerOpacity = 1.0;
  Tween<double> _opacityTween, _heightTween;
  bool _isAnimating = false;
  PointerDownEvent _pointDownEvent;

  _IndexPageState(this._headerHeight);

  @override
  void initState() {
    super.initState();
    indexData = [
      {
        "created_at": "@toom·1天前",
        "image": [
          "http://toomhub.image.23cm.cn/14993df391fc3c455040e5978e8f85b8.jpg",
          "http://toomhub.image.23cm.cn/QQ%E5%9B%BE%E7%89%8720201231134635.jpg",
          "http://toomhub.image.23cm.cn/03e1c4ff3c094fcd7633e7c8ab620777.jpg",
        ],
        "text": "aaaaaa🐂🐎",
        "avatar":
        "https://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLwQss0dlpIGgHUe0hjdkL8lMAz0wAa9QnyAukWEDnm5jS2ga0GZTwb33hcHN34YkZrdaM8qtAP6A/132",
        "nickname": "TOOM"
      },
      {
        "created_at": "2天前",
        "image": [
          "http://qloen87f5.hn-bkt.clouddn.com/FgU8t1AdVmoqvtgHQ4meCneRMe0T",
        ],
        "text": "bbbbbb🐂🐎",
        "avatar":
        "https://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLwQss0dlpIGgHUe0hjdkL8lMAz0wAa9QnyAukWEDnm5jS2ga0GZTwb33hcHN34YkZrdaM8qtAP6A/132",
        "nickname": "TOOM🐸"
      },
      {
        "created_at": "1小时前",
        "image": [
          "http://toomhub.image.23cm.cn/03e1c4ff3c094fcd7633e7c8ab620777.jpg",
          "http://toomhub.image.23cm.cn/03e1c4ff3c094fcd7633e7c8ab620777.jpg",
        ],
        "text": "cccccc🐂🐎",
        "avatar":
        "https://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLwQss0dlpIGgHUe0hjdkL8lMAz0wAa9QnyAukWEDnm5jS2ga0GZTwb33hcHN34YkZrdaM8qtAP6A/132",
        "nickname": "TOOM🐅"
      },
    ];
  }

  List<Widget> _colorBlock() {
    var res = <Widget>[];
    for (var i = 0; i < 8; i++) {
      res.add(Container(
        margin: EdgeInsets.only(top: dp(20), left: dp(20), right: dp(20)),
        height: dp(120),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          border: Border.all(width: dp(2), color: ZawazawaBase.defaultColor),
        ),
        child: Center(
          child: Text(
            (i + 1).toString(),
            style: TextStyle(
              color: ZawazawaBase.defaultColor,
              fontSize: dp(38),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ));
    }

    return res;
  }

  //滑动事件
  void _onPointerMove(PointerMoveEvent e) {
    var nextHeight = _headerHeight + e.delta.dy;

    print("nextHeight -> $nextHeight");
    //如果头部导航栏高度小于状态栏 || 头部导航栏大于规定的最大高度
    if (nextHeight <= ZawazawaBase.statusBarHeight ||
        nextHeight >= widget.headerHeightMax) {
      return;
    }

    setState(() {
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
    double headerHeightNow = _headerHeight,
        headerOpacityNow = _headerOpacity,
        direction; // header动画方向，1-展开；0-收起

    // 快速滚动捕获，触摸松开间隔小于300ms直接根据滚动方向伸缩header
    if ((_pointDownEvent != null) &&
        (e.timeStamp.inMilliseconds - _pointDownEvent.timeStamp.inMilliseconds <
            300)) {
      if (e.position.dy > _pointDownEvent.position.dy) {
        direction = 1;
      } else {
        direction = 0;
      }
    }
    // 滚动松开时header高度一半以下收起
    else if (_headerHeight < (widget.headerHeightMax / 2 + dp(15))) {
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
      } else {
        _headerHeight = widget.headerHeightMax;
        _headerOpacity = 1;
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
      drawer: Drawer(),
      body: Listener(
        onPointerDown: _onPointerDown,
        onPointerUp: _onPointerUp,
        onPointerMove: _onPointerMove,
        child: Column(
          children: <Widget>[
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
              flex: 1,
              child: ScrollConfiguration(
                behavior: DyBehaviorNull(),
                child: ScrollList(indexData),
              ),
            ),
          ],
        ),
      ),
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
