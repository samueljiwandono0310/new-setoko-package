import 'package:flutter/material.dart';
import 'package:sendbird_sdk/core/channel/group/group_channel.dart';
import 'package:setoko_chat_package/views/widgets/cacheable_image_widget.dart';

class StoreProfileWidget extends StatelessWidget {
  final double width;
  final double height;
  final Function()? onPressed;
  final String? currentUserId;
  final String? imageProfile;
  final GroupChannel? channel;
  const StoreProfileWidget({
    Key? key,
    this.channel,
    this.width = 33,
    this.height = 33,
    this.currentUserId,
    this.imageProfile,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Generate a channel image from avatars of users, excluding current user
    int crossAxisCount = 1;

    var images = <Widget>[];
    if (channel != null) {
      if (channel!.memberCount >= 3) {
        crossAxisCount = 2;
      }

      images = [
        for (final member in channel!.members)
          if (member.userId != currentUserId)
            CacheableImageWidget(
              imageUrl: member.profileUrl,
            ),
      ];
    } else {
      images = [
        CacheableImageWidget(
          imageUrl: imageProfile,
        ),
      ];
    }

    return Container(
      width: width,
      height: height,
      child: RawMaterialButton(
        shape: CircleBorder(),
        clipBehavior: Clip.hardEdge,
        onPressed: onPressed,
        child: GridView.count(
          crossAxisCount: crossAxisCount,
          children: images,
        ),
      ),
    );
  }
}
