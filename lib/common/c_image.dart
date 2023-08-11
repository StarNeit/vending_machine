import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CImage extends StatefulWidget {
  final String? assetsPath;
  final String? imageNetworkUrl;
  final double? radius;
  final double? width;
  final double? height;
  final BoxFit? boxFit;
  final Color? color;
  final bool? shouldClearCached;

  const CImage({
    Key? key,
    this.assetsPath,
    this.width,
    this.height,
    this.radius,
    this.shouldClearCached,
    this.boxFit,
    this.color,
    this.imageNetworkUrl,
  }) : super(key: key);
  @override
  _CImageState createState() => _CImageState();
}

class _CImageState extends State<CImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: (() {
        if (widget.assetsPath != null) {
          if (widget.assetsPath!.contains('.png') ||
              widget.assetsPath!.contains('.gif')) {
            return ClipRRect(
                borderRadius: BorderRadius.circular(widget.radius ?? 0),
                child: Image.asset(
                  widget.assetsPath ?? '',
                  height: widget.height,
                  width: widget.width,
                  fit: widget.boxFit ?? BoxFit.cover,
                ));
          } else if (widget.assetsPath!.contains('.svg')) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(widget.radius ?? 0),
              child: SvgPicture.asset(
                widget.assetsPath ?? '',
                width: widget.width,
                height: widget.height,
                fit: widget.boxFit ?? BoxFit.cover,
                color: widget.color,
              ),
            );
          }
        } else if (widget.imageNetworkUrl != null) {
          return FutureBuilder<bool>(
              future: clearCached(),
              builder: (context, snapshot) {
                return FutureBuilder<bool>(
                    future: isImageCached(widget.imageNetworkUrl!),
                    builder: (context, isExsitedSnapshot) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(widget.radius ?? 0),
                        child: CachedNetworkImage(
                          placeholderFadeInDuration: Duration.zero,
                          fadeInDuration: Duration.zero,
                          fadeOutDuration: Duration.zero,
                          useOldImageOnUrlChange: true,
                          progressIndicatorBuilder: (context, url, progress) =>
                              Center(
                            child: CircularProgressIndicator(
                                value: progress.progress,
                                color: Colors.blueAccent),
                          ),
                          imageUrl: widget.imageNetworkUrl!,
                          width: widget.width,
                          height: widget.height,
                          fit: widget.boxFit ?? BoxFit.cover,
                          color: widget.color,
                        ),
                      );
                    });
              });
        }
      }()),
    );
  }

  Future<bool> clearCached() async {
    if (widget.shouldClearCached == true) {
      await CachedNetworkImage.evictFromCache(widget.imageNetworkUrl!);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> isImageCached(String imageUrl) async {
    final DefaultCacheManager cacheManager = DefaultCacheManager();
    final FileInfo? fileInfo = await cacheManager.getFileFromCache(imageUrl);
    return fileInfo != null && fileInfo.file.existsSync();
  }
}
