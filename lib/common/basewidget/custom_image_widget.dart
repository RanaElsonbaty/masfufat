import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';

class CustomImageWidget extends StatefulWidget {
  final String image;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final String? placeholder;
  const CustomImageWidget({super.key, required this.image, this.height, this.width, this.fit = BoxFit.cover, this.placeholder = Images.placeholder});

  @override
  State<CustomImageWidget> createState() => _CustomImageWidgetState();
}

class _CustomImageWidgetState extends State<CustomImageWidget> {

  Future<void> loadImage() async {
    // print('custom image precache image start');
    try {
      await precacheImage(NetworkImage(widget.image), Get.context!);
    } catch (e) {
      print('custom image precache image error $e');
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    loadImage();

  }
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(

      placeholder: (context, url) => Image.asset(widget.placeholder?? Images.placeholder, height: widget.height, width: widget.width, fit: BoxFit.cover),
      imageUrl: widget.image, fit: widget.fit?? BoxFit.cover,
      height: widget.height,width: widget.width,
      errorWidget: (c, o, s) => Image.asset(widget.placeholder?? Images.placeholder, height: widget.height, width: widget.width, fit: BoxFit.cover),

    );
  }
}
