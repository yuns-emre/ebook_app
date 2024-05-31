// ignore_for_file: avoid_unnecessary_containers, no_logic_in_create_state, sized_box_for_whitespace, unused_field

import 'package:carousel_slider/carousel_slider.dart';
import 'package:ebook_app/data/authors.dart';
import 'package:ebook_app/pages/author/detail.dart';
import 'package:ebook_app/pages/author/list.dart';
import 'package:ebook_app/utilities/scaler.dart';
import 'package:flutter/material.dart';

class AuthorCarousel extends StatefulWidget {
  const AuthorCarousel({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AuthorCarouselState();
  }
}

class _AuthorCarouselState extends State<AuthorCarousel> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    final List<Widget> bookList = authors.map(
      (item) {
        return Container(
          child: InkWell(
            hoverColor: Theme.of(context).colorScheme.background,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AuthorDetailPage(
                    id: item.id,
                  ),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  width: Scaler.width(0.28, context),
                  height: Scaler.width(0.28, context),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary,
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(100)),
                        child: Image.asset(
                          alignment: Alignment.center,
                          scale: 0.9,
                          item.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      )
                    ],
                  ),
                ),
                Text(
                  "${item.name} ${item.surname}",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSecondary,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
        );
      },
    ).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 32, top: 16),
              child: Text(
                "Haftanın Yazarları",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 32, top: 16),
              child: InkWell(
                hoverColor: Theme.of(context).colorScheme.background,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AuthorListPage(),
                    ),
                  );
                },
                child: Text(
                  "See All",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
        Container(
          child: CarouselSlider(
            items: bookList,
            carouselController: _controller,
            options: CarouselOptions(
                initialPage: 1,
                autoPlay: true,
                enlargeCenterPage: false,
                viewportFraction: 0.38,
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
