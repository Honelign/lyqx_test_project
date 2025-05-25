import 'package:flutter/material.dart';

class DefaultSizedBox extends StatelessWidget {
  final double height;
  final double width;

  /// Default vertical spacing (height: 16, width: 0)
  const DefaultSizedBox.vertical({super.key})
      : height = 16.0,
        width = 0.0;

  /// Default horizontal spacing (height: 0, width: 16)
  const DefaultSizedBox.horizontal({super.key})
      : height = 0.0,
        width = 16.0;

  /// Small vertical spacing (height: 8, width: 0)
  const DefaultSizedBox.verticalSmall({super.key})
      : height = 8.0,
        width = 0.0;

  /// Small horizontal spacing (height: 0, width: 8)
  const DefaultSizedBox.horizontalSmall({super.key})
      : height = 0.0,
        width = 8.0;

  /// Large vertical spacing (height: 32, width: 0)
  const DefaultSizedBox.verticalLarge({super.key})
      : height = 32.0,
        width = 0.0;

  /// Large horizontal spacing (height: 0, width: 32)
  const DefaultSizedBox.horizontalLarge({super.key})
      : height = 0.0,
        width = 32.0;

  const DefaultSizedBox({
    super.key,
    this.height = 0.0,
    this.width = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height, width: width);
  }
}