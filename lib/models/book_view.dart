import 'package:ebook_app/models/author.dart';
import 'package:ebook_app/models/book.dart';
import 'package:ebook_app/models/book_features.dart';

class BookView {
  const BookView(
    this.author,
    this.book,
    this.features,
  );

  final Book book;
  final Author author;
  final List<BookFeatures> features;
}
