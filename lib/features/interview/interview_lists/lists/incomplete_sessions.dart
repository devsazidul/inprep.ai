import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inprep_ai/core/common/styles/global_text_style.dart'
    show getTextStyle;
import 'package:inprep_ai/core/utils/constants/icon_path.dart';
import 'package:inprep_ai/features/interview/interview_lists/controller/interview_list_controller.dart';

class IncompleteSessions extends StatelessWidget {
  IncompleteSessions({super.key});

  final InterviewListController controller =
      Get.find<InterviewListController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Incomplete Sessions",
          style: getTextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 15),
        SizedBox(
          height: 170,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.incompleteSessions.length,
            itemBuilder: (context, index) {
              var session = controller.incompleteSessions[index];
              return Padding(
                padding: const EdgeInsets.only(right:  10.0),
                child: Container(
                  width: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: session['color'],
                  ),
                
                  child: Row(
                    children: [
                      Container(
                        height: double.infinity,
                        width: 78,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: AssetImage(session['image']),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 140,
                              child: Text(
                                session['title'],
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: getTextStyle(
                                  color: Color(0xFF212121),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              '${session['positions'].toString()} Positions',
                              style: getTextStyle(
                                color: Color(0xFF676768),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 5),
                            InkWell(
                              onTap: (){},
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Color(0xFF37B874), 
                                  )
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 10
                                  ), 
                                  child: Row(
                                    children: [
                                      Text("Resume", 
                                       style: getTextStyle(
                                        color: Color(0xFF37B874),
                                        fontSize: 14, 
                                        fontWeight: FontWeight.w500 
                                       ),
                                      ), 
                                      SizedBox(
                                        width: 3,
                                      ), 
                                      Image.asset(IconPath.resumeIcon,
                                       width: 16,
                                       height: 16,
                                      )
                              
                                    ],
                                  )
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
