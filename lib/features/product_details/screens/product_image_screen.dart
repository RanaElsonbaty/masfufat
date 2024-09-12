import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/product_details/controllers/product_details_controller.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_app_bar_widget.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';

class ProductImageScreen extends StatefulWidget {
  final String? title;
  final List<String>? imageList;
  const ProductImageScreen({super.key, required this.title, required this.imageList});

  @override
  ProductImageScreenState createState() => ProductImageScreenState();
}

class ProductImageScreenState extends State<ProductImageScreen> {
  int? pageIndex;
  PageController? _pageController;

  @override
  void initState() {
    super.initState();
    pageIndex = Provider.of<ProductDetailsController>(context, listen: false).imageSliderIndex;
    _pageController = PageController(initialPage: pageIndex??0);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [

        CustomAppBar(title: widget.title),

        Expanded(
          child: Stack(children: [
              PhotoViewGallery.builder(
                scrollPhysics: const BouncingScrollPhysics(),
                builder: (BuildContext context, int index) {
                  return PhotoViewGalleryPageOptions(
                    imageProvider: NetworkImage(widget.imageList![index]),
                    initialScale: PhotoViewComputedScale.contained,
                    heroAttributes: PhotoViewHeroAttributes(tag: index.toString()),
                  );
                },
                backgroundDecoration: BoxDecoration(color: Theme.of(context).highlightColor),
                itemCount: widget.imageList!.length,
                loadingBuilder: (context, event) => Center(
                  child: SizedBox(width: 20.0, height: 20.0,
                    child: CircularProgressIndicator(
                      value: event == null ? 0 : event.cumulativeBytesLoaded / event.expectedTotalBytes!,
                        valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                    ))),
                pageController: _pageController,
                onPageChanged: (int index) {
                  setState(() {
                    pageIndex = index;
                  });
                },
              ),

            pageIndex != widget.imageList!.length-1 ? Positioned(left: 5, top: 0, bottom: 0,
                child: Container(alignment: Alignment.center,
                  height: 40,
                  width: 40,
                  decoration:  BoxDecoration(color:  Colors.black.withOpacity(0.40), shape: BoxShape.circle),
                  child: InkWell(
                    onTap: () {
    if(pageIndex! < widget.imageList!.length) {

                        _pageController!.animateToPage(pageIndex!+1, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
                      }
                    },
                    child: const Icon(Icons.arrow_forward_ios,color: Colors.white, size: 25),
                  ),
                ),
              ) : const SizedBox.shrink(),

            pageIndex != 0 ?   Positioned(
                right: 5, top: 0, bottom: 0,
                child: Container(alignment: Alignment.center,
                    height: 40,
                    width: 40,
                  decoration:  BoxDecoration(color:  Colors.black.withOpacity(0.40), shape: BoxShape.circle),
                  child: InkWell(
                    onTap: () {
                      if(pageIndex! > 0) {
                        _pageController!.animateToPage(pageIndex!-1, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Icon(Icons.arrow_back_ios,color: Colors.white, size: 25),
                    ))),
              ) : const SizedBox.shrink(),
            ],
          ),
        ),

      ]),
    );
  }
}

