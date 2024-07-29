import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import '../../models.dart';
import '../../services.dart';

part 'photo_detail_event.dart';
part 'photo_detail_state.dart';

class PhotoDetailBloc extends Bloc<PhotoDetailEvent, PhotoDetailState> {
  final UnsplashService unsplashService;

  PhotoDetailBloc(this.unsplashService) : super(PhotoDetailInitial()) {
    on<DownloadPhoto>(_onDownloadPhoto);
    on<LikePhoto>(_onLikePhoto);
  }

  Future<void> _onDownloadPhoto(DownloadPhoto event, emit) async {
    final res = await http.get(Uri.parse(event.url));
    final statusCode = res.statusCode;

    if (statusCode == 200) {
      emit(DownloadingPhoto(photoBytes: res.bodyBytes));
    } else {
      String error = 'Ocurrió un error';

      switch (statusCode) {
        case 400:
          error = 'Error en la petición';
          break;
        case 401:
          error = 'Unauthorized';
          break;
        case 403:
          error = 'Forbidden';
          break;
        case 404:
          error = 'Page Not Found';
          break;
        case 408:
          error = 'Timeout';
          break;
        default:
          error = 'Ocurrió un error';
      }

      if (statusCode >= 500) error = 'Server error';
      emit(PhotoDetailError(error: error));
    }
  }

  Future<void> _onLikePhoto(LikePhoto event, emit) async {
    try {
      final likedPhoto = await unsplashService.likeAPhoto(id: event.id);

      emit(PhotoLiked(photo: likedPhoto));
    } catch (e) {
      emit(PhotoDetailError(error: e.toString()));
    }
  }
}
