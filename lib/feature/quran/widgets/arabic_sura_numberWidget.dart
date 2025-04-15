import 'package:flutter/material.dart';
import 'package:theam_mood_with_block/core/extensions.dart';

class ArabicSuraNumber extends StatelessWidget {
  const ArabicSuraNumber({Key? key, required this.i}) : super(key: key);
  final int i;

  @override
  Widget build(BuildContext context) {
    return Text(
      "\uFD3F${(i + 1).toString().toArabicNumbers}\uFD3E",
      style: TextStyle(
        color: Theme.of(context).textTheme.bodyLarge?.color,
        fontFamily: 'me_quran',
        fontSize: 20,
        shadows: const [
          Shadow(
            offset: Offset(.5, .5),
            blurRadius: 1.0,
            color: Colors.amberAccent,
          ),
        ],
      ),
    );
  }
}
