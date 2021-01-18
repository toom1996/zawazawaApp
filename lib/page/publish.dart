//import 'package:cookiej/cookiej/model/local/edit_special_text.dart';

import 'package:z/widget/customer_button.dart';

//import 'package:cookiej/cookiej/page/widget/emotion_panel.dart';
//import 'package:cookiej/cookiej/provider/emotion_provider.dart';
import 'package:extended_text_field/extended_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

//import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class Publish extends StatefulWidget {
  @override
  _PublishState createState() => _PublishState();
}

class _PublishState extends State<Publish> {

  final FocusNode _textFieldNode = FocusNode();
  double keyboardHeight = 0;
  double emotionPanelHeight = 0;
  bool isEmotionPanelShow = false;
  bool isKeyboardShow = true;

  List<Widget> imageGridList = List();
  TextEditingController _controller = TextEditingController();

  ///用于准备向发送接口输入的文本
  String rawText = '';
  List<Asset> assetList;

  @override
  void initState() {
    super.initState();
//    ///重新读取用于Send的Access
//    API.httpClientSend.interceptors.removeWhere((interceptor)=>interceptor is AccessInterceptor);
//    AccessProvider.getAccessStateLocal().then((result){
//      if(result.success){
//        //result.data.loginAccesses.forEach((access)=>api)
//        API.httpClientSend.interceptors.add(AccessInterceptor(result.data.currentAccess));
//      }
//    }).catchError((e)=>print(e));
//    KeyboardVisibility.onChange.listen(
//          (bool visible) {
//        setState(() {
//          // isKeyboardShow=visible??isKeyboardShow;
//          if(visible!=null&&isKeyboardShow!=visible){
//            isKeyboardShow=visible;
//          }
//        });
//      },
//    );
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    keyboardHeight = MediaQuery
        .of(context)
        .viewInsets
        .bottom;
    if (keyboardHeight > 0) {
      emotionPanelHeight = keyboardHeight;
    }
    return Scaffold(
        appBar: AppBar(
            title: Text('发微博')
        ),
        body: ExtendedTextField(),
        //底部工具栏
    // resizeToAvoidBottomInset: true,
    );
  }

  // void changeKeyboardState(){
  //   //isResizeToAvoidBottomInset=!isResizeToAvoidBottomInset;
  //   isKeyboardShow?SystemChannels.textInput.invokeMethod('TextInput.hide'):_textFieldNode.requestFocus();
  // }
  Future<void> openPhotoGallery() async {
    //在安卓10上打不开系统相机，待解决
    var _theme = Theme.of(context);
    if (imageGridList.length >= 9) return;
    try {
      assetList = await MultiImagePicker.pickImages(
          maxImages: 9 - imageGridList.length,
          enableCamera: true,
          materialOptions: MaterialOptions(
              allViewTitle: '全部图片',
              lightStatusBar: _theme.brightness == Brightness.dark,
              actionBarTitle: '已选择',
              selectionLimitReachedText: '已达上限',
              textOnNothingSelected: '没有选择图片',
              statusBarColor: '#' + _theme.primaryColor.value.toRadixString(16),
              actionBarColor: '#' + _theme.primaryColor.value.toRadixString(16),
              actionBarTitleColor: '#' +
                  _theme.primaryTextTheme.bodyText1.color.value.toRadixString(
                      16)
          )
      );
      var data = await assetList[0].getByteData();
      print(data.lengthInBytes * data.elementSizeInBytes);
      var tumbList = assetList.map((asset) {
        var tumb = AssetThumb(asset: asset, width: 100, height: 100);
        var _key = GlobalKey();
        return Stack(
            key: _key,
            fit: StackFit.expand,
            children: <Widget>[
              tumb,
              Stack(
                  alignment: Alignment.topRight,
                  children: <Widget>[
                    Material(
                        color: Colors.white38,
                        child: InkWell(
                            child: Icon(Icons.close, color: Colors.white),
                            //删除已经选择的图片
                            onTap: () {
                              setState(() {
                                imageGridList.remove(_key.currentWidget);
                                assetList.remove(asset);
                              });
                            }
                        )
                    )
                  ]
              )
            ]
        );
      });
      setState(() {
        imageGridList.addAll(tumbList);
      });
    }
    catch (e) {
      if (e is NoImagesSelectedException) return;
      print('打开相册发生错误${e.toString()}');
    } finally {
      // _textFieldNode.requestFocus();
      // SystemChannels.textInput.invokeMethod('TextInput.show');
    }
  }

  List<Widget> autoAddButtonToGrid(List<Widget> sourceList) {
    if (sourceList.length == 0) return <Widget>[];
    var returnList = sourceList.toList();
    if (returnList.length < 9) {
      returnList.add(
          Material(
            child: InkWell(
              child: Icon(Icons.add, color: Colors.grey[400],),
              onTap: openPhotoGallery,
            ),
            color: Colors.grey[300],
          )
      );
    }
    return returnList;
  }

  void toast(String str) {
//    Fluttertoast.showToast(
//      msg: str,
//      gravity: ToastGravity.BOTTOM,
//      backgroundColor: Colors.black87,
//      textColor: Colors.white,
//    );
  }
}