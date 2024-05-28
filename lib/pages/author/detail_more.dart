import 'package:ebook_app/components/switch_toogle.dart';
import 'package:ebook_app/models/author.dart';
import 'package:ebook_app/utilities/scaler.dart';
import 'package:flutter/material.dart';

class AuthorMoreDetailPage extends StatelessWidget {
  final Author author;
  const AuthorMoreDetailPage({
    super.key,
    required this.author,
  });

  @override
  Widget build(BuildContext context) {
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
                    "${author.name} ${author.surname}",
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
           
            Container(
              padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: 32, vertical: 8),
              width: Scaler.width(1, context),
              child: Text(
                author.aboutText,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
