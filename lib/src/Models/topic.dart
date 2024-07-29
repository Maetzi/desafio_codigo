class Topic {
  String id;
  String title;
  String? description;
  String? coverPhotoUrl;
  String? link;

  Topic({
    required this.id,
    required this.title,
    this.description,
    this.coverPhotoUrl,
    this.link,
  });

  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      coverPhotoUrl: json['cover_photo']['urls']['small'],
      link: json['links']['photos'],
    );
  }

  Topic copyWith(
    String? id,
    String? title,
    String? description,
    String? coverPhotoUrl,
    String? link,
  ) {
    return Topic(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      coverPhotoUrl: coverPhotoUrl ?? this.coverPhotoUrl,
      link: link ?? this.link,
    );
  }
}
