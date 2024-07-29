part of 'photo_detail_bloc.dart';

@immutable
sealed class PhotoDetailEvent {}

class DownloadPhoto extends PhotoDetailEvent {
  final String url;

  DownloadPhoto({required this.url});
}

class LikePhoto extends PhotoDetailEvent {
  final String id;

  LikePhoto({required this.id});
}
