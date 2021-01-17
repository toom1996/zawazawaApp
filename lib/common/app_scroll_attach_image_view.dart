import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view_gallery.dart';

//图片预览组件
// ignore: must_be_immutable
class ScrollListAttachImageView extends StatefulWidget {
  final List imageList;
  int index = 0;
  PageController controller;

  ScrollListAttachImageView(this.imageList, this.index);

  @override
  _ScrollListAttachImageViewState createState() =>
      _ScrollListAttachImageViewState();

//  ScrollListAttachImageView(this._imageList, this._index);

//  @override
//  _ScrollListAttachImageViewState createState() =>
//      _ScrollListAttachImageViewState();
}

class _ScrollListAttachImageViewState extends State<ScrollListAttachImageView> {
//  Image image = Image.network("https://profile.csdnimg.cn/1/C/1/3_sinat_17775997");

  int currentIndex = 0;
  int initialIndex; //初始index
  int length;
  int title;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    currentIndex = widget.index;
    initialIndex = widget.index;
    length = widget.imageList.length;
    title = initialIndex + 1;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${currentIndex + 1}/${widget.imageList.length}'),
        centerTitle: true,
      ),
      body: Container(
        child: PhotoViewGallery.builder(
          builder: (BuildContext context, int index) {
            return PhotoViewGalleryPageOptions.customChild(
                maxScale: PhotoViewComputedScale.contained * 1,
                minScale: PhotoViewComputedScale.contained * 1,
                child: Container(
                  alignment: Alignment.center,
                  child: Scrollbar(
                      child: SingleChildScrollView(
//              scrollDirection: Axis.vertical,
                        child: Container(
                          alignment: Alignment.center,
                          child:
                          ExtendedImage.network(
                            widget.imageList[index]['host'] +
                                widget.imageList[index]['name'],
                            handleLoadingProgress: true,
                            cache: false,
                            enableSlideOutPage: true,
                            //cancelToken: cancellationToken,
                          ),
//                          Image(
//                            image: NetworkImage(widget.imageList[index]['host'] +
//                                widget.imageList[index]['name']),
//                            fit: BoxFit.fill,
//                            alignment: Alignment.center,
//                          ),
                        ),
                      )),
                ));
//              return PhotoViewGalleryPageOptions(
//                imageProvider: NetworkImage(widget.imageList[index]['host'] + widget.imageList[index]['name']),
//                initialScale: PhotoViewComputedScale.contained * 1,
//
//              );
          },
          itemCount: widget.imageList.length,
          // loadingChild: widget.loadingChild,
          backgroundDecoration: BoxDecoration(
            color: Colors.black,
          ),
          pageController: PageController(initialPage: initialIndex),
          //点进去哪页默认就显示哪一页
          onPageChanged: (index) {
            setState(() {
              currentIndex = index;
              title = index + 1;
            });
          },
        ),

      ),
    );
  }
}
