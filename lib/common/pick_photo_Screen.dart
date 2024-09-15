import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_app_bar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/controllers/auth_controller.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';

import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';

class GridGallery extends StatefulWidget {
  final ScrollController? scrollCtr;
final int index;
final Function onTap;
final bool video;
  const GridGallery({
    super.key,
    this.scrollCtr, required this.index, required this.onTap, required this.video,
  });

  @override
  _GridGalleryState createState() => _GridGalleryState();
}

class _GridGalleryState extends State<GridGallery> {
  final List<Widget> _mediaList = [];
  int currentPage = 0;
  int? lastPage;

  @override
  void initState() {
    super.initState();
    _fetchNewMedia();
  }

  _handleScrollEvent(ScrollNotification scroll) {
    if (scroll.metrics.pixels / scroll.metrics.maxScrollExtent > 0.33) {
      if (currentPage != lastPage) {
        _fetchNewMedia();
      }
    }
  }

  _fetchNewMedia() async {
    lastPage = currentPage;
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    if (ps.isAuth) {

      List<AssetPathEntity> albums =
      await PhotoManager.getAssetPathList(
          onlyAll: true);
      print(albums);
      List<AssetEntity> media =
      await albums[0].getAssetListPaged(size: 60, page: currentPage); //preloading files
      print(media);
      List<Widget> temp = [];
      for (var asset in media) {
        // asset.originFileWithSubtype.then((value) {
        //   print('asdasasdasdasdsaasdasd------> ${value!.path.split('.image').last}');
        //
        // });
        // if(widget.video==true&&asset.type!=AssetType.video){
        temp.add(
          FutureBuilder(
            future: asset.thumbnailDataWithSize(const ThumbnailSize(200, 200)), //resolution of thumbnail
            builder:
                (BuildContext context, AsyncSnapshot<Uint8List?> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Consumer<AuthController>(
                  builder:(context, auth, child) =>  InkWell(
                    onTap: (){
                      if(widget.video==true&&asset.type == AssetType.video){
                        asset.originFileWithSubtype.then((value) {
                          widget.onTap(value!);
                          Navigator.pop(context);

                        });
                      }else{
                        if(asset.type != AssetType.video) {
                          asset.originFileWithSubtype.then((value) {
                            widget.onTap(value!);
                            Navigator.pop(context);

                          });

                        }
                      }

                      // print('object');


                    },
                    child: Stack(
                      children: <Widget>[

                        if(snapshot.error==null&&snapshot.hasData&&snapshot.data!=null&&snapshot.data!.isNotEmpty)
                        Consumer<AuthController>(
                          builder:(context, auth, child) {
                            return Positioned.fill(
                              child: Image.memory(
                                snapshot.data!,
                                fit: BoxFit.cover,
                              )
                            );
                          },
                        ),

                        if (asset.type == AssetType.video)
                          const Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: EdgeInsets.only(right: 5, bottom: 5),
                              child: Icon(
                                Icons.videocam,
                                color: Colors.white,
                              ),
                            ),
                          ),

                      ],
                    ),
                  ),
                );
              }
              return Container();
            },
          ),
        );
      }
      // }
      setState(() {
        _mediaList.addAll(temp);
        currentPage++;
      });
    } else {
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: getTranslated('Choose_picture', context)),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scroll) {
          _handleScrollEvent(scroll);
          return false;
        },
        child: GridView.builder(
            controller: widget.scrollCtr,
            itemCount: _mediaList.length,
            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemBuilder: (BuildContext context, int index) {
              return _mediaList[index];
            }),
      ),
    );
  }
}