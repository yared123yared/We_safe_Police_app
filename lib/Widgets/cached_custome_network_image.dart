import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  const CustomCachedNetworkImage({
    Key? key,
    required this.url,
    required this.placeholder,
    required this.width,
    required this.boxFit,
    this.height,
    this.borderRadius,
  }) : super(key: key);
  final String url;
  final String placeholder;
  final double width;
  final BoxFit boxFit;
  final double? height;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (context, imageProvider) => Container(
        width: width,
        height: height ?? width,
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.zero,
          image: DecorationImage(
            image: imageProvider,
            fit: boxFit,
          ),
        ),
      ),
      placeholder: (context, url) => Container(
        decoration: BoxDecoration(
            borderRadius: borderRadius ?? BorderRadius.zero,
            image:
                DecorationImage(image: AssetImage(placeholder), fit: boxFit)),
      ),
      errorWidget: (context, url, err) => Container(
        decoration: BoxDecoration(
            borderRadius: borderRadius ?? BorderRadius.zero,
            image:
                DecorationImage(image: AssetImage(placeholder), fit: boxFit)),
      ),
    );
  }
}
