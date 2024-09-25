import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommunityImage extends StatelessWidget {
  final String imageUrl;

  const CommunityImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Stack(
          children: [
            Positioned.fill(
              child: checkFileExtension(imageUrl) == 'svg'
                  ? SvgPicture.network(
                      imageUrl,
                      fit: BoxFit.fitWidth,
                    )
                  : Image(
                      image: CachedNetworkImageProvider(imageUrl),
                      fit: BoxFit.fitWidth,
                    ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0x1A000000),
                    Colors.black,
                  ],
                  stops: [0.8, 1.0],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  String checkFileExtension(String url) {
    Uri uri = Uri.parse(url);
    String path = uri.path;

    if (path.contains('.')) {
      return path.split('.').last;
    } else {
      return '';
    }
  }
}
