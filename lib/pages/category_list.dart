import 'package:ebook_app/components/switch_toogle.dart';
import 'package:ebook_app/data/authors.dart';
import 'package:ebook_app/data/books.dart';
import 'package:ebook_app/data/categories.dart';
import 'package:ebook_app/data/features.dart';
import 'package:ebook_app/models/book_features.dart';
import 'package:ebook_app/models/book_view.dart';
import 'package:ebook_app/pages/book/detail.dart';
import 'package:ebook_app/utilities/scaler.dart';
import 'package:flutter/material.dart';

class CategoryListPage extends StatelessWidget {
  final int categoryId;
  const CategoryListPage({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    final category =
        categories.firstWhere((element) => element.id == categoryId);

    final List<BookView> bookList = books
        .where((book) => categoryId == 0 ? true : book.categoryId == categoryId)
        .map(
      (item) {
        final author = authors.where((a) => a.id == item.authorId).first;

        List<BookFeatures> featuresList = item.features.map((e) {
          BookFeatures data = features.firstWhere((f) => f.id == e);
          return BookFeatures(data.id, data.title, data.icon);
        }).toList();

        return BookView(author, item, featuresList);
      },
    ).toList();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const LightDarkSwitch(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(100),
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  Text(
                    category.title,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 24,
                  ),
                ],
              ),
            ),
            for (int i = 0; i < bookList.length; i++)
              InkWell(
                hoverColor: Theme.of(context).colorScheme.background,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailPage(
                        id: bookList[i].book.id,
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
                  child: Container(
                    width: Scaler.width(1, context),
                    height: Scaler.width(0.4, context),
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            bookList[i].book.imageUrl,
                            fit: BoxFit.cover,
                            height: Scaler.height(1, context),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          width: Scaler.width(0.46, context),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    bookList[i].book.title,
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "${bookList[i].author.name} ${bookList[i].author.surname}",
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      for (int k = 0;
                                          k < bookList[i].book.rating;
                                          k++)
                                        Icon(
                                          Icons.star_rate_rounded,
                                          color: Colors.amber[400],
                                          weight: 16,
                                        ),
                                      for (int k = 5;
                                          k > bookList[i].book.rating;
                                          k--)
                                        Icon(
                                          Icons.star_rate_rounded,
                                          color: Colors.grey[300],
                                          weight: 16,
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                              Wrap(
                                alignment: WrapAlignment.start,
                                children: [
                                  for (var fea in bookList[i].features)
                                    Container(
                                      width: 80,
                                      margin: const EdgeInsets.only(right: 4),
                                      child: Row(
                                        children: [
                                          Icon(
                                            fea.icon,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            fea.title,
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 24,
                          width: 24,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Theme.of(context).colorScheme.primary),
                          child: InkWell(
                            onTap: () {},
                            hoverColor: Theme.of(context).colorScheme.primary,
                            child: const Icon(
                              Icons.favorite_rounded,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
