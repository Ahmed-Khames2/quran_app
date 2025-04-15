import 'package:flutter/material.dart';

class QuranCard extends StatelessWidget {
  final Function onTap;

  const QuranCard({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: theme.cardColor, // The background color will follow the theme.
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                // color: theme.secondaryHeaderColor, // The icon background will use the theme's primary color.
                // color: const Color.fromARGB(255, 226, 219, 136),
                color: theme.appBarTheme.backgroundColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.menu_book_rounded,
                color: const Color.fromARGB(255, 226, 219, 136),
                // The icon color will follow the theme's icon color.
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            Text(
              "القرآن الكريم",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'me_quran',
                color: theme.textTheme.bodyLarge
                    ?.color, // The text color will use the theme's bodyText1 color.
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/** color: theme.appBarTheme
                    .backgroundColor,  */
