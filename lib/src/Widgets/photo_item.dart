import 'package:flutter/material.dart';

import '../models.dart';
import '../screens.dart';

class PhotoItem extends StatelessWidget {
  const PhotoItem({
    super.key,
    this.canShowTitle = false,
    this.canShowLikeBtn = true,
    required this.photo,
  });

  final bool canShowTitle;
  final bool canShowLikeBtn;
  final Photo photo;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ImageDetailScreen(
              canShowLikeBtn: canShowLikeBtn,
              photo: photo,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height:
                  (((width / 2) / (photo.width ?? 1)) * (photo.height ?? 1)) -
                      16,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.white,
                image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: NetworkImage(photo.url),
                ),
              ),
            ),
            if (canShowTitle)
              Text(
                photo.description ?? '',
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }
}
