/*
 * @discripe: app通用头部组件
 */
import 'dart:ui';
import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:barcode_scan/barcode_scan.dart';
// import 'package:flutter/services.dart';

import 'package:z/base/ZawazawaBase.dart';

class IndexHeader extends StatefulWidget {
  final num height;
  final num opacity;
  final BoxDecoration decoration;
  IndexHeader({ this.height, this.opacity = 1.0, this.decoration });

  @override
  _IndexHeaderState createState() => _IndexHeaderState();
}

class _IndexHeaderState extends State<IndexHeader> {
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


    return Container(

    );
  }
}