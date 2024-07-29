import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../bloc.dart';
import '../../../../models.dart';
import '../../../../widgets.dart';

class FavTab extends StatefulWidget {
  const FavTab({super.key});

  @override
  State<FavTab> createState() => _FavTabState();
}

class _FavTabState extends State<FavTab> {
  final PagingController<int, Photo> _pagingController =
      PagingController(firstPageKey: 0);
  static const _pageSize = 30;

  @override
  void initState() {
    final imageListBloc = context.read<ImageListBloc>();

    _pagingController.addPageRequestListener((pageKey) {
      imageListBloc.add(FetchLikedPhotos(page: pageKey));
    });
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ImageListBloc, ImageListState>(
      listener: (context, state) {
        if (state is ChangingImageList) {
          final newItems = state.photos;
          final isLastPage = newItems.length < _pageSize;

          if (isLastPage) {
            _pagingController.appendLastPage(newItems);
          } else {
            final nextPageKey = state.page + 1;
            _pagingController.appendPage(newItems, nextPageKey);
          }
        } else if (state is ImageListError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(customSnackBar(state.error));
        }
      },
      child: PhotoGrid(
        canShowLikeBtn: false,
        pagingController: _pagingController,
      ),
    );
  }
}
