class Photo {
  final String id;
  String? description;
  String? downloadLink;
  String? enSlug;
  String? esSlug;
  int? height;
  bool likedByUser;
  String? slug;
  final String url;
  int? width;

  Photo({
    required this.id,
    this.description,
    this.downloadLink,
    this.enSlug,
    this.esSlug,
    this.height,
    this.likedByUser = false,
    this.slug,
    required this.url,
    this.width,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'],
      description: json['description'] ?? json['alt_description'],
      downloadLink: json['links']['download'],
      enSlug: json['alternative_slugs']['en'],
      esSlug: json['alternative_slugs']['es'],
      height: json['height'],
      likedByUser: json['liked_by_user'],
      slug: json['slug'],
      url: json['urls']['small'],
      width: json['width'],
    );
  }

  Photo copyWith({
    String? id,
    String? description,
    String? downloadLink,
    String? enSlug,
    String? esSlug,
    int? height,
    bool? likedByUser,
    String? slug,
    String? url,
    int? width,
  }) {
    return Photo(
      id: id ?? this.id,
      description: description ?? this.description,
      downloadLink: downloadLink ?? this.downloadLink,
      enSlug: enSlug ?? this.enSlug,
      esSlug: esSlug ?? this.esSlug,
      height: height ?? this.height,
      likedByUser: likedByUser ?? this.likedByUser,
      slug: slug ?? this.slug,
      url: url ?? this.url,
      width: width ?? this.width,
    );
  }
}
