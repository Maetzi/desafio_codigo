import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../bloc.dart';
import '../../../models.dart';
import '../../../widgets.dart';
import 'search_app_bar.dart';

class SearchScaffold extends StatefulWidget {
  const SearchScaffold({super.key});

  @override
  State createState() => _SearchScaffoldState();
}

class _SearchScaffoldState extends State<SearchScaffold> {
  final PagingController<int, Photo> _pagingController =
      PagingController(firstPageKey: 0);
  static const _pageSize = 30;

  @override
  void initState() {
    super.initState();
    final imageListBloc = context.read<ImageListBloc>();

    _pagingController.addPageRequestListener((pageKey) {
      imageListBloc
          .add(FetchPhotoList(page: pageKey, query: imageListBloc.state.query));
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: const SearchAppBar(),
          body: BlocConsumer<ImageListBloc, ImageListState>(
            listener: (context, state) {
              if (state is ChangingImageList) {
                final newItems = state.photos;
                final isLastPage = newItems.length < _pageSize;

                if (isLastPage) {
                  _pagingController.appendLastPage(newItems);
                } else {
                  final nextPageKey = state.page + 1;

                  if (state.canCleanPhotoList) {
                    _pagingController.itemList?.clear();
                  }
                  _pagingController.appendPage(newItems, nextPageKey);
                }
              } else if (state is ImageListError) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(customSnackBar(state.error));
              }
            },
            builder: (BuildContext context, ImageListState state) {
              if (state.photos.isNotEmpty) {
                return PhotoGrid(
                  canShowTitle: true,
                  pagingController: _pagingController,
                );
              }
              return Center(
                child: Image.asset('assets/image_icon.png'),
              );
            },
          )),
    );
  }
}
