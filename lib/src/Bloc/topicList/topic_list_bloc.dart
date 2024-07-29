import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models.dart';
import '../../services.dart';

part 'topic_list_event.dart';
part 'topic_list_state.dart';

class TopicListBloc extends Bloc<TopicListEvent, TopicListState> {
  final UnsplashService unsplashService;

  TopicListBloc(this.unsplashService) : super(const TopicListInitial()) {
    on<FetchTopicList>(_onFetchTopicList);
  }

  Future<void> _onFetchTopicList(FetchTopicList event, emit) async {
    try {
      final topics = await unsplashService.getTopicList();
      emit(ChangingTopicList(topicList: topics));
    } catch (e) {
      emit(TopicListError(error: e.toString(), topicList: state.topicList));
    }
  }
}
