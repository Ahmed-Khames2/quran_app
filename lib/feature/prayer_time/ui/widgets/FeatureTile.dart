import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class FeatureTile extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const FeatureTile({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  State<FeatureTile> createState() => _FeatureTileState();
}

class _FeatureTileState extends State<FeatureTile> {
  bool _glow = false;

  void _handleTap() {
    setState(() {
      _glow = true;
    });

    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _glow = false;
      });
    });

    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        splashColor: theme.primaryColor.withOpacity(0.2),
        highlightColor: theme.primaryColor.withOpacity(0.1),
        onTap: _handleTap,
        child: Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOut,
              padding: EdgeInsets.all(_glow ? 6 : 0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: _glow
                    ? [
                        BoxShadow(
                          color: theme.primaryColor.withOpacity(0.6),
                          blurRadius: 20,
                          spreadRadius: 4,
                        )
                      ]
                    : [],
              ),
              child: CircleAvatar(
                radius: 28,
                backgroundColor: theme.cardColor,
                child: Icon(
                  widget.icon,
                  size: 30,
                  color: theme.iconTheme.color,
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: 80,
              height: 20,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final textStyle = TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: 'me_quran',
                    color: theme.textTheme.bodyLarge?.color,
                  );

                  final textPainter = TextPainter(
                    text: TextSpan(text: widget.label, style: textStyle),
                    maxLines: 1,
                    textDirection: TextDirection.rtl,
                  )..layout(maxWidth: double.infinity);

                  if (textPainter.width > constraints.maxWidth) {
                    return Marquee(
                      text: widget.label,
                      style: textStyle,
                      scrollAxis: Axis.horizontal,
                      blankSpace: 20.0,
                      velocity: 30.0,
                      pauseAfterRound: const Duration(seconds: 1),
                      startPadding: 10.0,
                      accelerationDuration: const Duration(seconds: 1),
                      accelerationCurve: Curves.linear,
                      decelerationDuration: const Duration(milliseconds: 500),
                      decelerationCurve: Curves.easeOut,
                      textDirection: TextDirection.ltr,
                    );
                  } else {
                    return Text(
                      widget.label,
                      textAlign: TextAlign.center,
                      style: textStyle,
                      overflow: TextOverflow.ellipsis,
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
