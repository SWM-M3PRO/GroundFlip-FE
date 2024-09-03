import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class GroupImage extends StatelessWidget {
  final String imageUrl;

  const GroupImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double width = constraints.maxWidth *
            0.8; // Image width is 80% of the available width
        double aspectRatio = 350 / 350; // Original aspect ratio
        return AspectRatio(
          aspectRatio: aspectRatio,
          child: Stack(
            children: [
              Image(
                image: CachedNetworkImageProvider(imageUrl),
                width: constraints.maxWidth,
                fit: BoxFit.cover,
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent, // 위쪽은 투명색
                      Colors.black, // 아래쪽은 검은색
                    ],
                    stops: [0.8, 1.0],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
