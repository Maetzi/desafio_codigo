import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models.dart';
import '../../services.dart';

part 'image_list_event.dart';
part 'image_list_state.dart';

class ImageListBloc extends Bloc<ImageListEvent, ImageListState> {
  final UnsplashService unsplashService;

  ImageListBloc(this.unsplashService) : super(const ImageListInitial()) {
    on<FetchPhotoList>(_onFetchPhotoList);
    on<FetchLikedPhotos>(_onFetchLikedPhotos);
  }

  Future<void> _onFetchPhotoList(FetchPhotoList event, emit) async {
    final query = event.query;
    final page = event.page;

    try {
      final newPhotoList = await (query != null
          ? unsplashService.searchPhotos(page: page, query: query)
          : unsplashService.getPhotoList(page: page));

      emit(ChangingImageList(
        canCleanPhotoList: event.canCleanPhotoList,
        page: page,
        photos: newPhotoList,
        query: query,
      ));
    } catch (e) {
      emit(ImageListError(
        error: e.toString(),
        page: state.page,
        photos: state.photos,
        query: state.query,
      ));
    }
  }

  Future<void> _onFetchLikedPhotos(FetchLikedPhotos event, emit) async {
    final page = event.page;

    try {
      final newPhotoList =
          await unsplashService.listLikedPhotos(page: event.page);

      emit(ChangingImageList(
        canCleanPhotoList: false,
        page: page,
        photos: newPhotoList,
      ));
    } catch (e) {
      emit(ImageListError(
        error: e.toString(),
        page: state.page,
        photos: state.photos,
        query: state.query,
      ));
    }
  }
}
