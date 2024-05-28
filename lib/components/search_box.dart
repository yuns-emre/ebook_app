// ignore_for_file: avoid_print

import 'package:ebook_app/data/books.dart';
import 'package:flutter/material.dart';

class SearchBox extends StatefulWidget {
  const SearchBox({super.key});
  @override
  State<SearchBox> createState() => _SearchBox();
}

class _SearchBox extends State<SearchBox> {
  var allItems = books;
  var items = [];
  var searcHistory = [];
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController.addListener(queryListener);
  }

  @override
  void dispose() {
    searchController.removeListener(queryListener);
    searchController.dispose();
    super.dispose();
  }

  void queryListener() {
    search(searchController.text);
  }

  void search(String query) {
    if (query.isNotEmpty) {
      setState(() {
        items = allItems
            .where((e) => e.title.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    } else {
      items = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(32, 8, 32, 24),
      child: SearchBar(
        elevation: const MaterialStatePropertyAll(0.0),
        backgroundColor: MaterialStatePropertyAll(
          Theme.of(context).colorScheme.secondary,
        ),
        onSubmitted: (value) {
          print(value);
        },
        hintStyle: MaterialStatePropertyAll(
          TextStyle(
            fontSize: 16.0,
            color: Theme.of(context).colorScheme.onPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
        textStyle: MaterialStatePropertyAll(
          TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        controller: searchController,
        hintText: "Search...",
        leading: IconButton(
          onPressed: () {
            print(searchController.text);
          },
          icon: Icon(
            Icons.search,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}
