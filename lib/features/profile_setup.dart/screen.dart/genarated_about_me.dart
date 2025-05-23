import 'package:flutter/material.dart';
import 'package:inprep_ai/core/common/styles/global_text_style.dart';

class GenaratedAboutMe extends StatelessWidget {
  const GenaratedAboutMe({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "About Me",
          style: getTextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: const Color(0xff212121),
          ),
        ),
      ),
    );
  }
}
