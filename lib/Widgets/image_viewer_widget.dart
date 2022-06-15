import 'package:flutter/material.dart';
import 'package:wesafepoliceapp/Widgets/cached_custome_network_image.dart';


class ImageViewerWidget extends StatelessWidget {
  static const routeName = 'wesafepoliceapp/imageviewerwidget';
  const ImageViewerWidget({
    required this.imageUrl,
     Key? key }) : super(key: key);
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height,
      child: CustomCachedNetworkImage(
        url: imageUrl, 
        placeholder: 'assets/images/police_image_on.jpg', 
        width: size.width, 
        boxFit: BoxFit.fill,
        height: size.height,
        ),
      
    );
  }
}