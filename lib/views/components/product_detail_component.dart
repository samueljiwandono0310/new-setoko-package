import 'package:flutter/material.dart';
import 'package:setoko_chat_package/core/models/product/product_detail.dart';
import 'package:setoko_chat_package/views/styles/text_styles.dart';
import 'package:setoko_chat_package/views/widgets/cacheable_image_widget.dart';
import 'package:setoko_chat_package/views/widgets/text_widget.dart';
import 'package:setoko_chat_package/core/extensions/extensions.dart';

class ProductDetailComponent extends StatelessWidget {
  final CTProductDetailData? ctProductDetailData;
  const ProductDetailComponent({
    Key? key,
    required this.ctProductDetailData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CacheableImageWidget(
          imageUrl: ctProductDetailData?.medias[0].url,
          imageBuilder: (context, imageProvider) {
            return Image(
              width: 44,
              height: 44,
              fit: BoxFit.contain,
              image: imageProvider,
            );
          },
        ),
        SizedBox(
          width: 209,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CTTextWidget(
                maxLines: 1,
                text: ctProductDetailData?.name ?? 'null',
                textStyle: ChatTextStyles.textStyle13,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CTTextWidget(
                    maxLines: 1,
                    text: ctProductDetailData!.price!.promo!.readablePrice,
                    textStyle: ChatTextStyles.textStyle7.copyWith(decoration: TextDecoration.lineThrough),
                  ),
                  const SizedBox(width: 6),
                  CTTextWidget(
                    maxLines: 1,
                    textStyle: ChatTextStyles.textStyle19,
                    text: ctProductDetailData!.price!.normal!.readablePrice,
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
