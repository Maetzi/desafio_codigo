import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../models.dart';
import 'photo_item.dart';

class PhotoGrid extends StatelessWidget {
  const PhotoGrid({
    super.key,
    this.canShowTitle = false,
    this.canShowLikeBtn = true,
    required this.pagingController,
  });

  final bool canShowTitle;
  final bool canShowLikeBtn;
  final PagingController<int, Photo> pagingController;

  @override
  Widget build(BuildContext context) {
    return PagedMasonryGridView<int, Photo>(
      crossAxisSpacing: 8.0,
      mainAxisSpacing: 8.0,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      pagingController: pagingController,
      builderDelegate: PagedChildBuilderDelegate<Photo>(
        itemBuilder: (context, item, index) => PhotoItem(
          canShowTitle: canShowTitle,
          canShowLikeBtn: canShowLikeBtn,
          photo: item,
        ),
      ),
      gridDelegateBuilder: (_) {
        return const SliverSimpleGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        );
      },
    );
  }
}
