part of 'image_list_bloc.dart';

@immutable
sealed class ImageListState {
  final int page;
  final List<Photo> photos;
  final String? query;

  const ImageListState({
    required this.page,
    required this.photos,
    this.query,
  });
}

final class ImageListInitial extends ImageListState {
  const ImageListInitial({
    super.page = 1,
    super.photos = const [],
    super.query,
  });
}

final class ChangingImageList extends ImageListState {
  final bool canCleanPhotoList;

  const ChangingImageList({
    required this.canCleanPhotoList,
    required super.page,
    required super.photos,
    super.query,
  });
}

final class ImageListError extends ImageListState {
  final String error;
  const ImageListError({
    required this.error,
    required super.page,
    required super.photos,
    super.query,
  });
}
