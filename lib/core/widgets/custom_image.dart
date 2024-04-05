import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../manager/assets_manager.dart';
import '../manager/color_manager.dart';
import '/core/extensions/padding_manager.dart';
import '/core/manager/values_manager.dart';

class CustomImage extends StatelessWidget {
  final Color? loadingColor;
  final String? imageUrl;
  final String? imageAsset;
  final File? imageFile;
  final double? border;
  final BorderRadius? borderRadius;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final String? basePath;
  const CustomImage({
    Key? key,
    this.loadingColor,
    this.imageUrl,
    this.imageAsset,
    this.imageFile,
    this.border,
    this.borderRadius,
    this.width,
    this.height,
    this.fit,
    this.basePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius:
          borderRadius ?? BorderRadius.circular(border ?? BorderValues.b10),
      child: _getImage(),
    );
  }

  Widget _getImage() {
    if (imageFile != null) {
      return Image.file(
        imageFile!,
        height: height,
        width: width,
        fit: fit ?? BoxFit.fill,
        errorBuilder: (BuildContext context, Object object, StackTrace? track) {
          return Image.asset(
            AssetsManager.placeholder,
            height: height,
            width: width,
            fit: fit ?? BoxFit.fill,
          );
        },
      );
    } else if (imageUrl != null) {
      return imageUrl!.contains('svg')
          ? SvgPicture.network(
              imageUrl!,
              height: height,
              width: width,
              fit: fit ?? BoxFit.fill,
            )
          : CachedNetworkImage(
              imageUrl: '${basePath ?? ''}${imageUrl!}',
              height: height,
              width: width,
              fit: fit ?? BoxFit.fill,
              progressIndicatorBuilder: (context, url, progress) {
                return Container(
                  width: width,
                  height: height,
                  alignment: Alignment.center,
                  padding: PaddingValues.p10.pSymmetricH,
                  child: CircularProgressIndicator(
                    value: progress.progress,
                    color: loadingColor ?? ColorsManager.primaryColor,
                  ),
                );
              },
              errorWidget: (context, url, error) {
                return Image.asset(
                  AssetsManager.placeholder,
                  height: height,
                  width: width,
                  fit: fit ?? BoxFit.fill,
                );
              },
            );
    }

    return Image.asset(
      imageAsset!,
      height: height,
      width: width,
      fit: fit ?? BoxFit.fill,
      errorBuilder: (BuildContext context, Object object, StackTrace? track) {
        return Image.asset(
          AssetsManager.placeholder,
          height: height,
          width: width,
          fit: fit ?? BoxFit.fill,
        );
      },
    );
  }
}
