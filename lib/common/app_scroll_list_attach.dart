import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:z/base/zawazawa_base.dart';
import 'package:z/common/app_scroll_attach_image_view.dart';

class ScrollListAttach extends StatelessWidget with ZawazawaBase {
  final List _url;
  int _currentImageWidth;
  int _currentImageHeight;

  ScrollListAttach(this._url);

  //九宫格图片布局
  Widget _nineGrid(BuildContext context, List picUrlList) {
//    print(picUrlList);
    List picList = picUrlList;
    //如果包含九宫格图片
    if (picList != null && picList.length > 0) {
      //一共有几张图片
      num len = picList.length;
      //算出一共有几行
      int rowLength = 0;
      //一共有几列
      int conLength = 0;
      if (len <= 3) {
        conLength = len;
        rowLength = 1;
      } else if (len <= 6) {
        conLength = 3;
        rowLength = 2;
        if (len == 4) {
          conLength = 2;
        }
      } else {
        conLength = 3;
        rowLength = 3;
      }
      //一行的组件
      List<Widget> imgList = [];
      //一行包含三个图片组件
      List<List<Widget>> rows = [];
      //遍历行数和列数,计算出宽高生成每个图片组件,
      for (var row = 0; row < rowLength; row++) {
        List<Widget> rowArr = [];
        for (var col = 0; col < conLength; col++) {
          num index = row * conLength + col;
          num screenWidth = MediaQuery.of(context).size.width;
          double cellWidth = (screenWidth - dp(48)) / 3;
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

          Image image =
              Image.network(picList[col]['host'] + picList[col]['name']);
//          image.image
//              .resolve(ImageConfiguration())
//              .addListener(ImageStreamListener((ImageInfo info, bool _) {
//                _currentImageWidth = info.image.width;
//                _currentImageHeight = info.image.height;
//            print('model.width======$info');
//          }));



          if (len == 1) {
            rowArr.add(Container(
              constraints: BoxConstraints(
                  maxHeight: dp(250),
                  maxWidth: dp(250),
                  minHeight: dp(200),
                  minWidth: dp(200)),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: GestureDetector(
                  child: Stack(
                 fit: StackFit.expand,
                    children: [
                      Container(
                        child: ExtendedImage.network(
                          picList[col]['host'] + picList[col]['name'],
                          handleLoadingProgress: true,
                          fit: BoxFit.cover,
                          cache: false,
                          enableSlideOutPage: true,
                          //cancelToken: cancellationToken,
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          picList[col]['ext'],
                          style: TextStyle(color: Colors.white,backgroundColor: Colors.black.withOpacity(0.5)),
                        ),
                      ),
                      Container(
//                        alignment: Alignment.bottomRight,
                        child: Text(
                          picList[col]['size'].toString(),
                          style: TextStyle(color: Colors.white,backgroundColor: Colors.black.withOpacity(0.5)),
                        ),
                      )
                    ],
                  ),
                  onTap: () {
                    print(_url);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return ScrollListAttachImageView(
                            _url,index );
                      }),
                    );
                  },
                ),
              ),
            ));
          } else {
            if (index < len) {
              EdgeInsets mMargin;
              if (len == 4) {
                if (index == 0) {
                  mMargin = EdgeInsets.only(right: dp(2), bottom: 5);
                } else if (index == 1) {
                  mMargin = EdgeInsets.only(left: dp(2), bottom: 5);
                } else if (index == 2) {
                  mMargin = EdgeInsets.only(right: dp(2));
                } else if (index == 3) {
                  mMargin = EdgeInsets.only(left: dp(2));
                }
              } else {
                if (index == 1 || index == 4 || index == 7) {
                  mMargin =
                      EdgeInsets.only(left: dp(2), right: dp(2), bottom: 5);
                } else if (index == 0 || index == 3 || index == 6) {
                  mMargin = EdgeInsets.only(right: dp(2), bottom: 5);
                } else if (index == 2 || index == 5 || index == 8) {
                  mMargin = EdgeInsets.only(left: dp(2), bottom: 5);
                }
              }

              rowArr.add(
                GestureDetector(
                  child: Container(
                    margin: mMargin,
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        ExtendedImage.network(
                          picList[index]['host'] + picList[index]['name'],
                          handleLoadingProgress: true,
                          width: itemW,
                          height: itemH,
                          fit: BoxFit.cover,
                          cache: false,
                          enableSlideOutPage: true,
                          //cancelToken: cancellationToken,
                        ),
                        Container(
                          child: Text(
                            picList[col]['ext'],
                            style: TextStyle(color: Colors.black,backgroundColor: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return ScrollListAttachImageView(
                            _url,index );
                      }),
                    );
                  },
                ),
              );
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
    return _nineGrid(context, _url);
  }
}
