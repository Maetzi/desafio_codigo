part of 'image_list_bloc.dart';

@immutable
sealed class ImageListEvent {}

class FetchPhotoList extends ImageListEvent {
  final bool canCleanPhotoList;
  final int page;
  final String? query;

  FetchPhotoList({
    this.canCleanPhotoList = false,
    required this.page,
    this.query,
  });
}

class FetchLikedPhotos extends ImageListEvent {
  final int page;

  FetchLikedPhotos({required this.page});
}
