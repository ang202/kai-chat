import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

class AssetImageView extends StatelessWidget {
  const AssetImageView({
    required this.fileName,
    this.height,
    this.fit,
    this.width,
    this.color,
    this.scale,
    this.alignment,
    Key? key,
  }) : super(key: key);

  final String fileName;
  final double? height;
  final double? scale;
  final double? width;
  final BoxFit? fit;
  final Color? color;
  final AlignmentGeometry? alignment;

  @override
  Widget build(BuildContext context) {
    return _getView();
  }

  Widget _getView() {
    final String mimType = fileName.split('.').last;

    return mimType.isEmpty
        ? Icon(Icons.image_not_supported_outlined, size: width, color: color)
        : _buildImageView(mimType);
  }

  Widget _buildImageView(String mimType) {
    switch (mimType) {
      case 'svg':
        return SvgPicture.asset(
          fileName,
          height: height,
          width: width,
          alignment: alignment ?? Alignment.center,
          fit: fit ?? BoxFit.contain,
          colorFilter:
              color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
        );
      case 'jpg':
      case 'jpeg':
      case 'png':
      case 'gif':
        return Image.asset(
          fileName,
          fit: fit,
          height: height,
          width: width,
          alignment: alignment ?? Alignment.center,
          color: color,
          scale: scale,
        );
      case 'json':
      case 'zip':
        return SizedBox(
          width: width,
          height: height,
          child: Lottie.asset(
            fileName,
            fit: BoxFit.cover,
            repeat: true,
          ),
        );
      default:
        return Icon(
          Icons.image_not_supported_outlined,
          size: width,
          color: color,
        );
    }
  }
}
