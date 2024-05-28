// ignore_for_file: avoid_unnecessary_containers, no_logic_in_create_state, sized_box_for_whitespace, unused_field, avoid_print

import 'package:carousel_slider/carousel_slider.dart';
import 'package:ebook_app/data/categories.dart';
import 'package:ebook_app/pages/category_list.dart';
import 'package:flutter/material.dart';

class CategoriesCarousel extends StatefulWidget {
  const CategoriesCarousel({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CategoriesCarouselState();
  }
}

class _CategoriesCarouselState extends State<CategoriesCarousel> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  int hoverCategoryId = 0;
  bool isHover = true;

  @override
  Widget build(BuildContext context) {
    final List<Widget> categoryList = categories
        .map(
          (item) => Container(
            margin: const EdgeInsets.only(left: 16),
            child: InkWell(
              borderRadius: BorderRadius.circular(24),
              onHover: (value) {
                setState(() {
                  isHover = value;
                  hoverCategoryId = item.id;
                });
              },
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoryListPage(
                      categoryId: item.id,
                    ),
                  ),
                );
              },
              child: Container(
                alignment: Alignment.center,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: isHover && hoverCategoryId == item.id
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.secondary,
                ),
                child: Text(
                  item.title,
                  style: TextStyle(
                    color: isHover && hoverCategoryId == item.id
                        ? Theme.of(context).colorScheme.secondary
                        : Theme.of(context).colorScheme.onSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        )
        .toList();

    return Container(
      child: CarouselSlider(
        items: categoryList,
        carouselController: _controller,
        options: CarouselOptions(
            initialPage: 1,
            aspectRatio: 12,
            viewportFraction: 0.3,
            enableInfiniteScroll: false,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            }),
      ),
    );
  }
}
