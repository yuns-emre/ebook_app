// ignore_for_file: avoid_unnecessary_containers, no_logic_in_create_state, sized_box_for_whitespace, unused_field

import 'package:carousel_slider/carousel_slider.dart';
import 'package:ebook_app/data/authors.dart';
import 'package:ebook_app/data/books.dart';
import 'package:ebook_app/models/author.dart';
import 'package:ebook_app/pages/book/detail.dart';
import 'package:ebook_app/utilities/scaler.dart';
import 'package:flutter/material.dart';

class AuthorBooksCarousel extends StatefulWidget {
  final int authorId;
  const AuthorBooksCarousel({super.key, required this.authorId});

  @override
  State<StatefulWidget> createState() {
    return _AuthorBooksCarouselState();
  }
}

class _AuthorBooksCarouselState extends State<AuthorBooksCarousel> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    final Author author =
        authors.firstWhere((element) => element.id == widget.authorId);

    final List<Widget> bookList =
        books.where((element) => element.authorId == widget.authorId).map(
      (item) {
        return Container(
          margin: const EdgeInsets.only(top: 16),
          child: InkWell(
            hoverColor: Theme.of(context).colorScheme.background,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPage(
                    id: item.id,
                  ),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 12),
              width: Scaler.width(0.45, context),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        width: Scaler.width(1, context),
                        height: Scaler.width(0.32, context),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.background,
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                              image: AssetImage(item.imageUrl), scale: 1.2),
                        ),
                      ),
                      Text(
                        item.title,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${author.name} ${author.surname}",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSecondary,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  //features
                  Row(
                    children: [
                      Icon(
                        Icons.headphones_rounded,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Read Book",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: CarouselSlider(
            items: bookList,
            carouselController: _controller,
            options: CarouselOptions(
                initialPage: 1,
                autoPlay: true,
                aspectRatio: 1.5,
                enlargeCenterPage: false,
                viewportFraction: 0.5,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
          ),
        ),
      ],
    );
  }
}
