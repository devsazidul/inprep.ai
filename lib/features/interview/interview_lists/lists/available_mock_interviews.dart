import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inprep_ai/core/common/styles/global_text_style.dart';
import 'package:inprep_ai/features/interview/interview_details/details/view/details_view.dart';
import 'package:inprep_ai/features/interview/interview_lists/controller/interview_list_controller.dart';

class AvailableMockInterviews extends StatelessWidget {
   AvailableMockInterviews({super.key});

  final InterviewListController controller = Get.find<InterviewListController>(); 

  @override
  Widget build(BuildContext context) {
    
    return Column(
      children: [
        SizedBox(
          height: 400,
          child: ListView.builder(
            
            padding: EdgeInsets.zero,
            itemCount: controller.allInterviews.length,
            itemBuilder: (context, index){
              var availablemockinterviews = controller.allInterviews[index]; 
              return Padding(
                padding: EdgeInsets.only(
                  bottom: 12,
                ),
                child: GestureDetector(
                  onTap: (){
    
                    Get.to(() => DetailsView(),
                     arguments: [
                      availablemockinterviews.interviewName, 
                      availablemockinterviews.img, 
                      availablemockinterviews.totalPositions, 
                      availablemockinterviews.description, 
                      availablemockinterviews.id,
                      
                     ]           
                    ); 
                    
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white, 
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(
                      12
                    ),
                     child: Row(
                      children: [
                        Container(
                          width: 64,
                          height: 68,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: NetworkImage(availablemockinterviews.img),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ), 
                        SizedBox(
                          width: 5,
                        ), 
                        SizedBox(
                          width: 180,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(availablemockinterviews.interviewName, 
                               style: getTextStyle(
                                color: Color(0xFF212121), 
                                fontSize: 16, 
                                fontWeight: FontWeight.w500
                               ),
                              ), 
                              SizedBox(
                                height: 5,
                              ), 
                              Text("${availablemockinterviews.totalPositions.toString()} Job Titles", 
                               style: getTextStyle(
                                color: Color(0xFFAFAFAF), 
                                fontSize: 14, 
                                fontWeight: FontWeight.w400
                               ),
                              ),
                            ],
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
        ),
      ],
    );
  }
}