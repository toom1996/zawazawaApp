import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view_gallery.dart';

//图片预览组件
class ScrollListAttachImageView extends StatefulWidget {
  final List _imageList;
  ScrollListAttachImageView(this._imageList);
  @override
  _ScrollListAttachImageViewState createState() => _ScrollListAttachImageViewState();
}

class _ScrollListAttachImageViewState extends State<ScrollListAttachImageView> {
//  Image image = Image.network("https://profile.csdnimg.cn/1/C/1/3_sinat_17775997");

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  }

  @override
  void dispose(){
    super.dispose();
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom, SystemUiOverlay.top]);
  }

  @override
  Widget build(BuildContext context) {
  print(widget._imageList);
    return Scaffold(
//      appBar: AppBar(
//        title: Text('flutter 标题'),
//        backgroundColor: Color.fromRGBO(36, 36, 36, 1.0),
//      ),
      body: PhotoViewGallery.builder(
        scrollPhysics: const BouncingScrollPhysics(),
        builder: (BuildContext context, int index) {
          return PhotoViewGalleryPageOptions.customChild(
            child: Container(
              alignment: Alignment.center,
              child: Scrollbar(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Container(
                      alignment: Alignment.center,
                      child: Image(
                        image: NetworkImage(widget._imageList[index]['host'] + widget._imageList[index]['name']),
                        fit: BoxFit.fitWidth,
                        alignment: Alignment.center,
                      ),
                    ),
                  )),
            ),
            minScale: PhotoViewComputedScale.contained * 1,
            maxScale: PhotoViewComputedScale.covered * 2,
          );
        },
        itemCount: widget._imageList.length,
        loadingBuilder: (context, event) => Center(
          child: Container(
            width: 20.0,
            height: 20.0,
            child: CircularProgressIndicator(
              value: event == null
                  ? 0
                  : event.cumulativeBytesLoaded /
                  event.expectedTotalBytes,
            ),
          ),
        ),
      ),
//      Container(
//          child: PhotoView(
//            imageProvider: NetworkImage(widget._url),
//            backgroundDecoration: BoxDecoration(color: Colors.black),
//            gaplessPlayback: false,
//            heroAttributes: PhotoViewHeroAttributes(
//              tag:"ddd",
//              transitionOnUserGestures: true,
//            ),
//            minScale: PhotoViewComputedScale.contained,
//            maxScale: PhotoViewComputedScale.covered * 1.8,
//            initialScale: PhotoViewComputedScale.contained,
//            basePosition: Alignment.center,
//          )
//      ),
    );
  }
}
