class Book {
  const Book(
    this.id,
    this.title,
    this.authorId,
    this.categoryId,
    this.bookYear,
    this.aboutDescription,
    this.features,
    this.pagesCount,
    this.sharingCount,
    this.rating,
    this.imageUrl,
    this.bgImageUrl,
  );

  final int id;
  final String title;
  final int authorId;
  final int categoryId;
  final String bookYear;
  final int pagesCount;
  final int sharingCount;
  final String aboutDescription;
  final List<int> features;
  final int rating;
  final String imageUrl;
  final String bgImageUrl;
}
