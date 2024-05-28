import 'package:ebook_app/components/author_books_carousel.dart';
import 'package:ebook_app/components/switch_toogle.dart';
import 'package:ebook_app/data/authors.dart';
import 'package:ebook_app/pages/author/detail_more.dart';
import 'package:ebook_app/utilities/scaler.dart';
import 'package:flutter/material.dart';

class AuthorDetailPage extends StatelessWidget {
  final int id;
  const AuthorDetailPage({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    final author = authors.firstWhere((element) => element.id == id);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const LightDarkSwitch(),

            //AppBar
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
                    "YAZAR DETAY",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.share,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Icon(
                        Icons.favorite_border_rounded,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            //Author Profil Container
            Container(
              padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 32,
                vertical: 16,
              ),
              width: Scaler.width(1, context),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.primary,
                        width: 3,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        author.imageUrl,
                        fit: BoxFit.cover,
                        width: 112,
                      ),
                    ),
                  ),

                  //
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "${author.name}\n${author.surname.toUpperCase()}",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Yazar",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),

            //About Container
            Container(
              padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 32,
                vertical: 16,
              ),
              width: Scaler.width(1, context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "About",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    author.shortDescription,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextButton(
                    style: const ButtonStyle(
                      padding: MaterialStatePropertyAll(EdgeInsets.all(0)),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AuthorMoreDetailPage(
                            author: author,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      "Read More",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ],
              ),
            ),

            //Carousel Author Book
            AuthorBooksCarousel(
              authorId: author.id,
            ),

            //
            const SizedBox(
              height: 32,
            ),
          ],
        ),
      ),
    );
  }
}
