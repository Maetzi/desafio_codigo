part of 'topic_list_bloc.dart';

@immutable
sealed class TopicListEvent {}

class FetchTopicList extends TopicListEvent {}
