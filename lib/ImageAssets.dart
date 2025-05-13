
import 'package:flutter/material.dart';

class ImageAssets extends StatelessWidget {
  final String image;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Color? color;
  final double? scale;
  final bool? switchToNetwork;
  const ImageAssets(
      {super.key,
        required this.image,
        this.width,
        this.height,
        this.fit,
        this.color,
        this.switchToNetwork = false,
        this.scale});

  @override
  Widget build(BuildContext context) {
    return switchToNetwork == false
        ? Image.asset(image,
        scale: scale, width: width, height: height, fit: fit, color: color)
        : Image.network(
      image.toString(),
      fit: fit,
      width: width,
      height: height,
      errorBuilder: (BuildContext context, Object exception,
          StackTrace? stackTrace) {
        return Image.asset("assets/empty_image.png");
      },
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
    );
  }
}
