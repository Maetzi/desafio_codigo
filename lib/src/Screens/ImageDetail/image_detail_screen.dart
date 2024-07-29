import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc.dart';
import '../../models.dart';
import '../../services.dart';
import 'widgets/image_detail_scaffold.dart';

class ImageDetailScreen extends StatelessWidget {
  const ImageDetailScreen({
    super.key,
    this.canShowLikeBtn = true,
    required this.photo,
  });

  final bool canShowLikeBtn;
  final Photo photo;

  @override
  Widget build(BuildContext context) {
    final unsplashService = UnsplashService();

    return BlocProvider(
      create: (_) => PhotoDetailBloc(unsplashService),
      child: ImageDetailScaffold(canShowLikeBtn: canShowLikeBtn, photo: photo),
    );
  }
}
