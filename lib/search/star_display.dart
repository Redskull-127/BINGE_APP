import 'package:flutter/material.dart';

class StarDisplay extends StatelessWidget {
  final double value;

  const StarDisplay({this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          (value - index) >= 1
              ? Icons.star
              : ((value - index) >= 0.5 ? Icons.star_half : Icons.star_border),
//          index < value ? Icons.star : Icons.star_border,
          color: index < value.round() ? Color(0xFFF8662E) : Colors.grey[700],
          size: 20.0,
        );
      }),
    );
  }
}
