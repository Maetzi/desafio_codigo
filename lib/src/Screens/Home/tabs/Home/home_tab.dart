import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../bloc.dart';
import '../../../../models.dart';
import '../../../../widgets.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final PagingController<int, Photo> _pagingController =
      PagingController(firstPageKey: 1);
  static const _pageSize = 30;

  @override
  void initState() {
    final imageListBloc = context.read<ImageListBloc>();

    _pagingController.addPageRequestListener((pageKey) {
      imageListBloc.add(FetchPhotoList(page: pageKey));
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
      child: PhotoGrid(pagingController: _pagingController),
    );
  }
}
