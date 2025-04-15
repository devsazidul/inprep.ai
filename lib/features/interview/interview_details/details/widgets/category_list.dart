import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show CircleAvatar, Colors, Icons;
import 'package:get/get.dart';
import 'package:inprep_ai/core/common/styles/global_text_style.dart';
import 'package:inprep_ai/core/utils/constants/icon_path.dart';
import 'package:inprep_ai/features/interview/interview_details/category_details/view/category_details_view.dart';
import 'package:inprep_ai/features/interview/interview_details/details/controller/details_controller.dart';

class CategoryList extends StatelessWidget {
   CategoryList({super.key});

  final DetailsController controller = Get.find<DetailsController>(); 

  @override
  Widget build(BuildContext context) {
    var length = controller.categoryList.length * 80;
    return SizedBox(
      height: length.toDouble(),
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: controller.categoryList.length,
        itemBuilder: (context, index){
          var data = controller.categoryList[index];
          return Padding(
            padding: const EdgeInsets.only(
              bottom: 12,
            ),
            child: GestureDetector(
              onTap: (){
                Get.to(() => CategoryDetailsView(),
                 arguments:  data['title']
                ); 
              },
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white, 
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.all(12), 
                   child: Row(
                    children: [
                      Image.asset(IconPath.codeIcon,
                       height: 40,
                       width: 40,
                      ), 
                      SizedBox(
                        width: 20,
                      ), 
                      Text(data['title'], 
                       style: getTextStyle(
                        fontSize: 16, 
                        fontWeight: FontWeight.w500, 
                        color: Color(0xFF212121),
                       ),
                      ), 
                      Spacer(), 
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: Color(0xFF37B874),
                        child: Center(
                          child: Icon(Icons.arrow_forward,
                           color: Colors.white,
                          ),
                        ),
                      )
                    ],
                   ),
                  ),
              ),
            ),
          ); 
        }
        ),
    );
  }
}