class BookReadListen {
  const BookReadListen(
    this.id,
    this.bookId,
    this.auidoUrl,
    this.pageNumber,
    this.shortDescription,
    this.text,
  );

  final int id;
  final int bookId;
  final int pageNumber;
  final String text;
  final String auidoUrl;
  final String shortDescription;
}
