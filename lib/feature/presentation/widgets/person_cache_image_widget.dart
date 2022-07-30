import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PersonCacheImage extends StatelessWidget {
  final String? imageUrl;
  final double? width, height;
  const PersonCacheImage({Key? key, this.imageUrl, this.width, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: width,
      height: height,
      imageUrl: imageUrl!,
      imageBuilder: (context, imageProvider) {
        return Container(
          decoration:
              BoxDecoration(borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)), image: DecorationImage(image: imageProvider, fit: BoxFit.cover)),
        );
      },
      placeholder: (context, url) {
        return const Center(child: CircularProgressIndicator());
      },
      errorWidget: (context, url, error) {
        return Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
            image: DecorationImage(image: AssetImage('assets/images/noimage.jpg'), fit: BoxFit.cover),
          ),
        );
      },
    );
  }
}
