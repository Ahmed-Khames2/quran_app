// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeatureTile extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const FeatureTile({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

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
        borderRadius: BorderRadius.circular(16.r), // استخدام ScreenUtil للحدود
        // ignore: deprecated_member_use
        splashColor: theme.primaryColor.withOpacity(0.2),
        // ignore: deprecated_member_use
        highlightColor: theme.primaryColor.withOpacity(0.1),
        onTap: _handleTap,
        child: Column(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOut,
              padding:
                  EdgeInsets.all(_glow ? 6.r : 0), // استخدام ScreenUtil للأبعاد
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: _glow
                    ? [
                        BoxShadow(
                          // ignore: deprecated_member_use
                          color: theme.primaryColor.withOpacity(0.6),
                          blurRadius: 20.r, // استخدام ScreenUtil للظل
                          spreadRadius: 4.r, // استخدام ScreenUtil للظل
                        )
                      ]
                    : [],
              ),
              child: CircleAvatar(
                radius: 28.r, // استخدام ScreenUtil للأبعاد
                backgroundColor: theme.cardColor,
                child: Icon(
                  widget.icon,
                  size: 30.sp, // استخدام ScreenUtil لحجم الأيقونة
                  color: theme.iconTheme.color,
                ),
              ),
            ),
            SizedBox(height: 8.h), // استخدام ScreenUtil للأبعاد
            SizedBox(
              width: 80.w, // استخدام ScreenUtil للأبعاد
              height: 22.h, // استخدام ScreenUtil للأبعاد
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final textStyle = TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: 'me_quran',
                    color: theme.textTheme.bodyLarge?.color,
                    fontSize: 14.sp, // استخدام ScreenUtil لحجم الخط
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
