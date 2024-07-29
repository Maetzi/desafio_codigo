import 'package:flutter/material.dart';

class ActionsBottom extends StatelessWidget {
  const ActionsBottom({
    super.key,
    this.canShowLikeBtn = true,
    this.download,
    this.setWallpaper,
    this.likePhoto,
  });

  final bool canShowLikeBtn;
  final VoidCallback? download;
  final VoidCallback? setWallpaper;
  final VoidCallback? likePhoto;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: SizedBox(
        width: width * 0.45,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              onPressed: download,
              icon: const Icon(Icons.download),
            ),
            IconButton(
              onPressed: setWallpaper,
              icon: const Icon(Icons.wallpaper),
            ),
            if (canShowLikeBtn)
              IconButton(
                onPressed: likePhoto,
                icon: const Icon(Icons.favorite_border),
              ),
          ],
        ),
      ),
    );
  }
}
