import 'package:flutter/material.dart';

import '../../../../models.dart';

class TopicItem extends StatelessWidget {
  const TopicItem({super.key, required this.topic});

  final Topic topic;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final itemSideSize = screenWidth / 2 - 16.0;

    return Container(
      height: itemSideSize,
      width: itemSideSize,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        image: topic.coverPhotoUrl != null
            ? DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(topic.coverPhotoUrl!),
              )
            : null,
      ),
      child: Center(
        child: Text(
          topic.title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 18.0,
            letterSpacing: 0.8,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
