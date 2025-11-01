import 'package:flutter/material.dart';

import '../utils/font_style.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title, style: AppFontStyle.fontReemKafi20w600titleColor);
  }
}
