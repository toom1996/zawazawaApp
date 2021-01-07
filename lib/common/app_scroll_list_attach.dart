import 'package:flutter/material.dart';

class ScrollListAttach extends StatelessWidget {
  final List _url;
  bool isSingle = false;

  ScrollListAttach(this._url);

  initState() {
//    super.initState();
    print("init");
  }

  Widget buildItem() {
    List<Widget> tiles = []; //先建一个数组用于存放循环生成的widget
    Widget content; //单独一个widget组件，用于返回需要生成的内容widget
    for (var item in _url) {
      tiles.add(Expanded(
        child: Container(
          alignment: Alignment.centerLeft,
          constraints: !isSingle
              ? null
              : BoxConstraints(
//                  maxHeight: 100,
                  minWidth: 300,
//                  maxHeight: 300
                ),
          margin: EdgeInsets.all(1.0),
          child: isSingle
              ? Image.network(
                  item,
                  fit: BoxFit.cover,
                )
              : AspectRatio(
                  aspectRatio: 1 / 1,
                  child: Image.network(
                    item,
                    fit: BoxFit.cover,
                  ),
                ),
        ),
      ));
    }
    content = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: tiles,
    );
//    content = new Column(
//        children: tiles //重点在这里，因为用编辑器写Column生成的children后面会跟一个<Widget>[]，
//      //此时如果我们直接把生成的tiles放在<Widget>[]中是会报一个类型不匹配的错误，把<Widget>[]删了就可以了
//    );
    return content;
  }

  @override
  Widget build(BuildContext context) {
    if (this._url.length == 1) {
      this.isSingle = true;
    } else {
      this.isSingle = false;
    }
    print(this._url);
    return buildItem();
  }
}
