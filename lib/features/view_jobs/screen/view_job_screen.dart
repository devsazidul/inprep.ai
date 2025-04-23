import 'package:flutter/material.dart';
import 'package:inprep_ai/core/common/styles/global_text_style.dart';
import 'package:inprep_ai/core/utils/constants/icon_path.dart';

class ViewJobScreen extends StatelessWidget {
  const ViewJobScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF6F6F7),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "My Jobs",
                    style: getTextStyle(
                      color: Color(0xff212121),
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      // Wrap TextField in Expanded to constrain its width
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search for jobs...',

                          suffixIcon: Icon(
                            Icons.search,
                            color: Color(0xffABB7C2),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.all(15),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ), // Add spacing between TextField and Icon
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 50,
                        width: 49,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.asset(IconPath.filter),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
