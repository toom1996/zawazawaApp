import 'package:flutter/material.dart';
import 'package:z/base/zawazawa_base.dart';

class ScrollListAttach extends StatelessWidget with ZawazawaBase {
  final List _url;

  ScrollListAttach(this._url);

  //九宫格图片布局
  Widget _NineGrid(BuildContext context, List picUrlList) {
    print(picUrlList);
    List picList = picUrlList;
    //如果包含九宫格图片
    if (picList != null && picList.length > 0) {
      //一共有几张图片
      num len = picList.length;
      //算出一共有几行
      int rowlength = 0;
      //一共有几列
      int conlength = 0;
      if (len <= 3) {
        conlength = len;
        rowlength = 1;
      } else if (len <= 6) {
        conlength = 3;
        rowlength = 2;
        if (len == 4) {
          conlength = 2;
        }
      } else {
        conlength = 3;
        rowlength = 3;
      }
      //一行的组件
      List<Widget> imgList = [];
      //一行包含三个图片组件
      List<List<Widget>> rows = [];
      //遍历行数和列数,计算出宽高生成每个图片组件,
      for (var row = 0; row < rowlength; row++) {
        List<Widget> rowArr = [];
        for (var col = 0; col < conlength; col++) {
          num index = row * conlength + col;
          num screenWidth = MediaQuery.of(context).size.width;
          double cellWidth = (screenWidth - 40) / 3;
          double itemW = 0;
          double itemH = 0;
          if (len == 1) {
            itemW = cellWidth;
            itemH = cellWidth;
          } else if (len <= 3) {
            itemW = cellWidth;
            itemH = cellWidth;
          } else if (len <= 6) {
            itemW = cellWidth;
            itemH = cellWidth;
            if (len == 4) {
              itemW = cellWidth;
              itemH = cellWidth;
            }
          } else {
            itemW = cellWidth;
            itemH = cellWidth;
          }
          if (len == 1) {
            rowArr.add(Container(
              constraints: BoxConstraints(
                  maxHeight: dp(250), maxWidth: dp(250), minHeight: dp(200), minWidth: dp(200)),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Image.network(
                    picList[index]['host'] + picList[index]['name'],
                    fit: BoxFit.cover),
              ),
            ));
          } else {
            if (index < len) {
              EdgeInsets mMargin;
              if (len == 4) {
                if (index == 0) {
                  mMargin = const EdgeInsets.only(right: 2.5, bottom: 5);
                } else if (index == 1) {
                  mMargin = const EdgeInsets.only(left: 2.5, bottom: 5);
                } else if (index == 2) {
                  mMargin = const EdgeInsets.only(right: 2.5);
                } else if (index == 3) {
                  mMargin = const EdgeInsets.only(left: 2.5);
                }
              } else {
                if (index == 1 || index == 4 || index == 7) {
                  mMargin =
                      const EdgeInsets.only(left: 2.5, right: 2.5, bottom: 5);
                } else if (index == 0 || index == 3 || index == 6) {
                  mMargin = const EdgeInsets.only(right: 2.5, bottom: 5);
                } else if (index == 2 || index == 5 || index == 8) {
                  mMargin = const EdgeInsets.only(left: 2.5, bottom: 5);
                }
              }

              rowArr.add(Container(
                child: Container(
                  margin: mMargin,
                  child: Image.network(
                    picList[index]['host'] + picList[index]['name'],
                    fit: BoxFit.cover,
                    width: itemW,
                    height: itemH,
                  ),
                ),
              ));
            }
          }
        }
        rows.add(rowArr);
      }
      for (var row in rows) {
        imgList.add(Row(
          children: row,
        ));
      }

      return Column(
        children: imgList,
      );
    } else {
      return Container(
        height: 0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return _NineGrid(context, _url);
  }
}
