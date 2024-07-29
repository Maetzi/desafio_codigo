import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc.dart';
import '../../../models.dart';
import '../../../widgets.dart';
import 'image_detail_body.dart';

class ImageDetailScaffold extends StatelessWidget {
  const ImageDetailScaffold({
    super.key,
    this.canShowLikeBtn = true,
    required this.photo,
  });

  final bool canShowLikeBtn;
  final Photo photo;

  @override
  Widget build(BuildContext context) {
    return BlocListener<PhotoDetailBloc, PhotoDetailState>(
      listener: (context, state) async {
        if (state is DownloadingPhoto) {
          String snackBarText = '';

          try {
            Directory? directory = Directory('/storage/emulated/0/Download');
            File file = File(
                '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.png');
            await file.writeAsBytes(state.photoBytes);
            snackBarText = 'Photo saved';
          } catch (e) {
            snackBarText = e.toString();
          }

          ScaffoldMessenger.of(context)
              .showSnackBar(customSnackBar(snackBarText));
        } else if (state is PhotoLiked) {
          ScaffoldMessenger.of(context)
              .showSnackBar(customSnackBar('Photo liked'));
        } else if (state is PhotoDetailError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(customSnackBar(state.error));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: ImageDetailBody(
          canShowLikeBtn: canShowLikeBtn,
          photo: photo,
        ),
      ),
    );
  }
}
