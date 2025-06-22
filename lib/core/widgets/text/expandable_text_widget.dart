import 'package:flutter/material.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;
  final TextStyle mainTextStyle;
  final TextStyle subTextStyles;

  const ExpandableTextWidget({
    super.key,
    required this.text,
    required this.mainTextStyle,
    required this.subTextStyles,
  });

  @override
  ExpandableTextWidgetState createState() => ExpandableTextWidgetState();
}

class ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  bool isExpanded = false;
  final int maxLines = 7;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedSize(
          duration: const Duration(milliseconds: 200),
          child: ConstrainedBox(
            constraints: isExpanded
                ? const BoxConstraints()
                : BoxConstraints(maxHeight: maxLines * 20.0),
            // Adjust height as needed
            child: Text(
              widget.text,
              overflow:
                  isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
              maxLines: isExpanded ? null : maxLines,
              style: widget.mainTextStyle,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Text(
            isExpanded ? "Read less" : "Read more...",
            style: widget.subTextStyles,
          ),
        ),
      ],
    );
  }
}
