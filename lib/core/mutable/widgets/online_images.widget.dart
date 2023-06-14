import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../remote/urls.wings.dart';
import '../themes/theme.wings.dart';

class OnlineImages extends StatelessWidget {
  final String imageUrl;
  final bool circularImage;
  final bool externalLink;
  final bool hasShadow;

  const OnlineImages({
    super.key,
    required this.imageUrl,
    this.externalLink = false,
    this.circularImage = false,
    this.hasShadow = false,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: (externalLink ? '' : WingsURL.baseImageURL) + imageUrl,
      placeholder: (context, value) {
        return SpinKitPulse(
          color: WingsTheme.primaryColor,
        );
      },
      imageBuilder: (context, imageProvider) {
        var image = DecorationImage(
          image: imageProvider,
          fit: BoxFit.cover,
        );

        return Container(
          decoration: circularImage
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(200),
                  image: image,
                  boxShadow: hasShadow ? WingsTheme.defaultShadow : [],
                )
              : BoxDecoration(
                  image: image,
                  boxShadow: hasShadow ? WingsTheme.defaultShadow : [],
                ),
        );
      },
      errorWidget: (context, url, error) =>
          const Center(child: Icon(Icons.error)),
    );
  }
}
