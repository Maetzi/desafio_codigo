import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc.dart';
import '../../../models.dart';
import 'actions_bottom.dart';

class ImageDetailBody extends StatelessWidget {
  const ImageDetailBody({
    super.key,
    this.canShowLikeBtn = true,
    required this.photo,
  });

  final bool canShowLikeBtn;
  final Photo photo;

  @override
  Widget build(BuildContext context) {
    final photoDetailBloc = context.read<PhotoDetailBloc>();
    final width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Spacer(),
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage(photo.url)),
            ),
            width: width,
            height: (width / (photo.width ?? 1)) * (photo.height ?? 1) - 16,
          ),
          const Spacer(),
          ActionsBottom(
            canShowLikeBtn: canShowLikeBtn,
            download: () {
              final downloadLink = photo.downloadLink;

              if (downloadLink != null) {
                photoDetailBloc.add(DownloadPhoto(url: downloadLink));
              }
            },
            likePhoto: () {
              photoDetailBloc.add(LikePhoto(id: photo.id));
            },
          ),
          const SizedBox(height: 24.0),
        ],
      ),
    );
  }
}
