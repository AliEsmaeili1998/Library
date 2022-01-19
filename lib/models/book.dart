class Book {
  final String name;
  final bool? read;
  final String? writer;
  final String? publisher;
  final String? translator;
  final double rating;
  final String? comment;
  final int? id;

  Book({
    required this.name,
    this.read,
    this.writer,
    this.publisher,
    this.translator,
    this.rating = 0.0,
    this.comment,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'read': read,
      'writer': writer,
      'publisher': publisher,
      'translator': translator,
      'rating': rating,
      'comment': comment,
      'id': id,
    };
  }
}
