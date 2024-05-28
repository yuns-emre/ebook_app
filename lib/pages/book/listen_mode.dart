import 'package:audioplayers/audioplayers.dart';
import 'package:ebook_app/components/auido_player.dart';
import 'package:ebook_app/components/switch_toogle.dart';
import 'package:ebook_app/data/authors.dart';
import 'package:ebook_app/data/book_read_listen_data.dart';
import 'package:ebook_app/data/books.dart';
import 'package:ebook_app/models/author.dart';
import 'package:ebook_app/models/book.dart';
import 'package:ebook_app/models/book_read_listen.dart';
import 'package:ebook_app/utilities/scaler.dart';
import 'package:flutter/material.dart';

class ListenModePage extends StatefulWidget {
  final int id;
  const ListenModePage({super.key, required this.id});

  @override
  State<StatefulWidget> createState() {
    return _ListenModePageState();
  }
}

class _ListenModePageState extends State<ListenModePage> {
  int pageCount = 0;
  String _url = "ambient_v_motion.mp3";

  late AudioPlayer player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
    player.setReleaseMode(ReleaseMode.stop);
    // final BookReadListen data =
    //     readListenData.firstWhere((element) => element.id == widget.id);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await player.setSource(AssetSource(_url));
      await player.resume();
    });
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int id = widget.id;
    final Book book = books.firstWhere((element) => element.id == id);
    final Author author = authors.firstWhere((element) => element.id == id);
    final List<BookReadListen> pages =
        readListenData.where((element) => element.bookId == id).toList();
    BookReadListen page = pages[pageCount];

    setState(() {
      _url = page.auidoUrl;

      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await player.setSource(AssetSource(_url));
        await player.resume();
      });
    });

    void nextPage() {
      if (page.pageNumber == pages[pages.length - 1].pageNumber) {
        return;
      }
      pageCount += 1;
      setState(() {
      });
    }

    void backPage() {
      if (page.pageNumber == 1) {
        return;
      }
      pageCount -= 1;
      setState(() {
      });
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: Scaler.width(1, context),
              height: Scaler.width(1, context) * 1.1,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(book.bgImageUrl),
                  fit: BoxFit.cover,
                ),
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(24),
                  bottomLeft: Radius.circular(24),
                ),
              ),
              child: Column(
                children: [
                  const LightDarkSwitch(),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(100),
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.white,
                          ),
                        ),
                        const Text(
                          "DİNLEME",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 16, top: 32),
                    width: Scaler.width(0.4, context),
                    height: Scaler.width(0.4, context) * 1.5,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 25,
                        ),
                      ],
                      image: DecorationImage(
                        image: AssetImage(book.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        book.title,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 4),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Text(
                          "Syf. ${page.pageNumber}",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset(
                          author.imageUrl,
                          fit: BoxFit.cover,
                          width: 48,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        "${author.name} ${author.surname}",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                  //Player Auido
                  SizedBox(
                    width: Scaler.width(1, context),
                    child: PlayerWidget(player: player),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextButton(
                        style: ButtonStyle(
                          alignment: Alignment.center,
                          backgroundColor: MaterialStatePropertyAll(
                              page.pageNumber == 1
                                  ? Theme.of(context)
                                      .colorScheme
                                      .onSecondary
                                      .withOpacity(0.5)
                                  : Theme.of(context).colorScheme.onSecondary),
                          minimumSize: MaterialStatePropertyAll(
                            Size(Scaler.width(0.44, context), 50),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            backPage();
                          });
                        },
                        child: const Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.arrow_back_rounded,
                              color: Colors.white,
                              size: 24,
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Text(
                              "Geri",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                      ),
                      TextButton(
                        style: ButtonStyle(
                          alignment: Alignment.center,
                          backgroundColor: MaterialStatePropertyAll(
                              page.pageNumber ==
                                      pages[pages.length - 1].pageNumber
                                  ? Theme.of(context)
                                      .colorScheme
                                      .onSecondary
                                      .withOpacity(0.5)
                                  : Theme.of(context).colorScheme.primary),
                          minimumSize: MaterialStatePropertyAll(
                            Size(Scaler.width(0.44, context), 50),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            nextPage();
                          });
                        },
                        child: const Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "İleri",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Icon(
                              Icons.arrow_forward_rounded,
                              color: Colors.white,
                              size: 24,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),

                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Bilgilendirme",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    page.text,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
