part of 'topic_list_bloc.dart';

@immutable
sealed class TopicListState {
  final List<Topic> topicList;

  const TopicListState({required this.topicList});
}

final class TopicListInitial extends TopicListState {
  const TopicListInitial({super.topicList = const []});
}

class ChangingTopicList extends TopicListState {
  const ChangingTopicList({required super.topicList});
}

class TopicListError extends TopicListState {
  final String error;

  const TopicListError({required this.error, required super.topicList});
}
