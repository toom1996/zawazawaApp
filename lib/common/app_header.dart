import 'dart:ui';
import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:barcode_scan/barcode_scan.dart';
// import 'package:flutter/services.dart';

import 'package:z/base/zawazawa_base.dart';

class ZawazawaHeader extends StatefulWidget {
  //高度
  num height;

  //透明度
  num opacity;

  //BoxDecoration通常用于给Widget组件设置边框效果、阴影效果、渐变色等效果；先来看下关
  BoxDecoration decoration;
  ZawazawaHeader({ this.height, this.opacity = 1.0, this.decoration });

  @override
  _ZawazawaHeaderState createState() => _ZawazawaHeaderState();
}

class _ZawazawaHeaderState extends State<ZawazawaHeader> with ZawazawaBase {
  TextEditingController _search = TextEditingController();
  // ScanResult _scanResult;

  Future _scan() async {
    // try {
    //   _scanResult = await BarcodeScanner.scan();
    //   if (_scanResult.rawContent != '') {
    //     _search.text = _scanResult.rawContent;
    //   }
    // } on PlatformException catch (e) {
    //   if (e.code == BarcodeScanner.cameraAccessDenied) {
    //     DYdialog.alert(context, text: '设备未获得权限');
    //   } else {
    //     DYdialog.alert(context, text: '未捕获的错误: $e');
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: widget.height != null ? widget.height : ZawazawaBase.statusBarHeight + dp(55),
      width: screenWidth,
      decoration: widget.decoration != null ? widget.decoration : BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Color(0xffff8633),
            Color(0xffff6634),
          ],
        ),
      ),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          Positioned(
            bottom: dp(10),
            child: Opacity(
              opacity: widget.opacity,
              child: SizedBox(
                width: screenWidth - dp(30),
                height: dp(40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(dp(20)),
                      ),
                      child: GestureDetector(
                        onTap: () => {
                          Scaffold.of(context).openDrawer()
                        },
                        child: Image.network(
                          'https://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLwQss0dlpIGgHUe0hjdkL8lMAz0wAa9QnyAukWEDnm5jS2ga0GZTwb33hcHN34YkZrdaM8qtAP6A/132',
                          width: dp(40),
                          height: dp(40),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
//                    Padding(
//                      padding: EdgeInsets.only(left: dp(10)),
//                      child: Image.network(
//                        'http://toomhub.image.23cm.cn/14993df391fc3c455040e5978e8f85b8.jpg',
//                        width: dp(25),
//                      ),
//                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}