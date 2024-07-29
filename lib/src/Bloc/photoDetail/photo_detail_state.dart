part of 'photo_detail_bloc.dart';

@immutable
sealed class PhotoDetailState {}

final class PhotoDetailInitial extends PhotoDetailState {}

class PhotoDetailError extends PhotoDetailState {
  final String error;

  PhotoDetailError({required this.error});
}

class DownloadingPhoto extends PhotoDetailState {
  final Uint8List photoBytes;

  DownloadingPhoto({required this.photoBytes});
}

class PhotoLiked extends PhotoDetailState {
  final Photo photo;

  PhotoLiked({required this.photo});
}
