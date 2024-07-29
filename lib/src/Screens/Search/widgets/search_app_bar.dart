import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc.dart';
import '../../../widgets.dart';

class SearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  const SearchAppBar({super.key});

  @override
  State createState() => _SearchAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}

class _SearchAppBarState extends State<SearchAppBar> {
  final _border = const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white),
    gapPadding: 0.0,
  );
  final _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: TextField(
        autofocus: true,
        controller: _textController,
        decoration: InputDecoration(
          border: _border,
          enabledBorder: _border,
          focusedBorder: _border,
          hintText: 'Search',
          suffixIcon: IconButton(
            onPressed: () {
              _textController.text = '';
            },
            icon: const Icon(Icons.clear),
          ),
        ),
        textInputAction: TextInputAction.search,
        onSubmitted: (value) {
          if (value != '') {
            final imageListBloc = context.read<ImageListBloc>();

            imageListBloc.add(
                FetchPhotoList(canCleanPhotoList: true, page: 1, query: value));
          } else {
            ScaffoldMessenger.of(context)
                .showSnackBar(customSnackBar('Insert a term to search'));
          }
        },
      ),
    );
  }
}
