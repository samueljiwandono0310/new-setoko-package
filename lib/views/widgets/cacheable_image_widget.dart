import 'package:flutter/material.dart';
import 'package:setoko_chat_package/views/styles/colors.dart';
import 'package:setoko_chat_package/core/constants/constan.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CacheableCacheManager {
  static const key = CacheImageManagerKey;
  static CacheManager instance = CacheManager(Config(key, stalePeriod: const Duration(days: 1)));
}

class CacheableImageWidget extends StatelessWidget {
  final String? imageUrl;
  final double? height;
  final double? width;
  final Widget Function(BuildContext context, ImageProvider imageProvider)? imageBuilder;

  const CacheableImageWidget({
    Key? key,
    required this.imageUrl,
    this.imageBuilder,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: BoxFit.cover,
      height: height,
      width: width,
      imageUrl: "$imageUrl",
      imageBuilder: imageBuilder,
      useOldImageOnUrlChange: true,
      filterQuality: FilterQuality.high,
      cacheManager: CacheableCacheManager.instance,
      errorWidget: (context, url, error) {
        return const Center(
          child: Icon(
            Icons.error,
            color: ChatColors.red,
          ),
        );
      },
      progressIndicatorBuilder: (context, url, progress) {
        return Center(
          child: CircularProgressIndicator(
            strokeWidth: 1.0,
            value: progress.progress,
          ),
        );
      },
    );
  }
}
