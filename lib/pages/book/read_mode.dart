import 'package:ebook_app/components/switch_toogle.dart';
import 'package:ebook_app/data/book_read_listen_data.dart';
import 'package:ebook_app/data/books.dart';
import 'package:ebook_app/models/book.dart';
import 'package:ebook_app/models/book_read_listen.dart';
import 'package:ebook_app/utilities/scaler.dart';
import 'package:flutter/material.dart';

class ReadModePage extends StatefulWidget {
  final int id;
  const ReadModePage({super.key, required this.id});

  @override
  State<StatefulWidget> createState() {
    return _ReadModePageState();
  }
}

class _ReadModePageState extends State<ReadModePage> {
  int pageCount = 0;

  @override
  Widget build(BuildContext context) {
    int id = widget.id;
    final Book book = books.firstWhere((element) => element.id == id);
    final List<BookReadListen> pages =
        readListenData.where((element) => element.bookId == id).toList();

    BookReadListen page = pages[pageCount];

    void nextPage() {
      pageCount += 1;
      setState(() {});
    }

    void backPage() {
      pageCount -= 1;
      setState(() {});
    }

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
                    "OKUMA",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Text(
                      "Syf. ${page.pageNumber}",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      book.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  SizedBox(
                    height: Scaler.height(0.18, context),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              book.title,
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
                                  color: Theme.of(context).colorScheme.primary,
                                  size: 24,
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Icon(
                                    Icons.favorite_border_rounded,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    size: 24,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Icon(
                                    Icons.headphones_rounded,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    size: 24,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            if (page.pageNumber != 1)
                              TextButton(
                                style: ButtonStyle(
                                  alignment: Alignment.center,
                                  backgroundColor: MaterialStatePropertyAll(
                                      Theme.of(context)
                                          .colorScheme
                                          .onSecondary),
                                ),
                                onPressed: () {
                                  setState(() {
                                    backPage();
                                  });
                                },
                                child: const Row(
                                  children: [
                                    Icon(
                                      Icons.arrow_back_rounded,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      "Geri",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            if (page.pageNumber !=
                                pages[pages.length - 1].pageNumber)
                              TextButton(
                                style: ButtonStyle(
                                  alignment: Alignment.center,
                                  backgroundColor: MaterialStatePropertyAll(
                                      Theme.of(context).colorScheme.primary),
                                ),
                                onPressed: () {
                                  setState(() {
                                    nextPage();
                                  });
                                },
                                child: const Row(
                                  children: [
                                    Text(
                                      "İleri",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Icon(
                                      Icons.arrow_forward_rounded,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  ],
                                ),
                              )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
              child: Text(
                page.text,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
