import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../bloc.dart';
import 'topic_item.dart';

class ExploreTab extends StatefulWidget {
  const ExploreTab({super.key});

  @override
  State<ExploreTab> createState() => _ExploreTabState();
}

class _ExploreTabState extends State<ExploreTab> {
  @override
  void initState() {
    final topicListBloc = context.read<TopicListBloc>();

    topicListBloc.add(FetchTopicList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return BlocBuilder<TopicListBloc, TopicListState>(
      buildWhen: (previous, current) => current is ChangingTopicList,
      builder: (context, state) {
        final topicList = state.topicList;

        return GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          padding: const EdgeInsets.all(8.0)
              .add(EdgeInsets.only(top: height * 0.04)),
          children: topicList.map((e) => TopicItem(topic: e)).toList(),
        );
      },
    );
  }
}
