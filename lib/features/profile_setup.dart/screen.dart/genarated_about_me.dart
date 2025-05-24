import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inprep_ai/core/common/styles/global_text_style.dart';

// ignore: must_be_immutable
class GenaratedAboutMe extends StatelessWidget {
  GenaratedAboutMe({super.key});

  GenaratedAboutMe genaratedAboutMe = Get.put(GenaratedAboutMe());

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
      // body: SingleChildScrollView(
      //   child: Padding(
      //     padding: EdgeInsetsGeometry.all(15),
      //     child: Column(
      //       children: [
      //         Align(
      //           alignment: Alignment.center,
      //           child: Text(
      //             "About Me Genarated bye Ai",
      //             style: TextStyle(
      //               fontSize: 20,
      //               fontWeight: FontWeight.w500,
      //               color: Color(0xff212121),
      //             ),
      //           ),
      //         ),
      //         SizedBox(
      //           height: 20,
      //         ),
      //         TextField(
      //           maxLines: 3,
      //         )
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
