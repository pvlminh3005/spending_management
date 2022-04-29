import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'shimmer.dart';

class AvatarCustom extends StatelessWidget {
  const AvatarCustom({
    this.imageUrl,
    Key? key,
    this.radius = 20,
    this.onTap,
  }) : super(key: key);

  final String? imageUrl;
  final double radius;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: CachedNetworkImage(
        imageUrl: imageUrl ?? 'https://i.stack.imgur.com/l60Hf.png',
        placeholder: (context, url) => Shimmer.fromColors(
          highlightColor: Colors.grey[100]!,
          baseColor: Colors.grey[300]!,
          child: CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            radius: radius,
          ),
        ),
        errorWidget: (context, url, error) => SizedBox(
          width: radius * 2,
          height: radius * 2,
          child: const Icon(Icons.error),
        ),
        imageBuilder: (context, image) => CircleAvatar(
          backgroundImage: image,
          radius: radius,
        ),
      ),
    );
  }
}
