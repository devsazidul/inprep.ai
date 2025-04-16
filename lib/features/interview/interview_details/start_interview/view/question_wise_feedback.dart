import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inprep_ai/core/common/styles/global_text_style.dart';
import 'package:inprep_ai/core/utils/constants/icon_path.dart';
import 'package:inprep_ai/features/interview/interview_details/start_interview/controller/start_interview_controller.dart';
import 'package:inprep_ai/features/interview/interview_details/start_interview/widget/next_button.dart';
import 'package:inprep_ai/features/interview/interview_details/start_interview/widget/suggestion_container.dart' show SuggestionContainer;

class QuestionWiseFeedback extends StatelessWidget {
  QuestionWiseFeedback({super.key});

  final StartInterviewController controller = Get.find<StartInterviewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: 60, 
            left: 20, 
            right: 20, 
            bottom: 60, 
          ),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Question ${controller.questionNumber.value} feedback',
                style: getTextStyle(
                  color: Color(0xFF212121),
                  fontSize: 24, fontWeight: FontWeight.w500,
                  
                  ),
              ),
              SizedBox(
                height: 2,
              ), 
              Text('Question ${controller.questionNumber.value} Out of ${controller.questions.length.toString()} .   2:30 min'),
              SizedBox(
                height: 40,
              ) ,
              Row(
                children: [
                  Image.asset(IconPath.speechIcon, 
                   width: 40,
                   height: 40,
                  ), 
                  SizedBox(
                    width: 5,
                  ), 
                  Text('Speech',
                   style: getTextStyle(
                    color: Color(0xFF212121), 
                    fontSize: 20, 
                    fontWeight: FontWeight.w500
                   ),
                  )
                ],
              ), 
              SizedBox(
                height: 5,
              ), 
              Text('Great job on your tone and clarity! You sopke confidently, but try to slow down a little for better pacing',
               textAlign: TextAlign.justify,
               style: getTextStyle(
                color: Color(0xFF293649), 
                fontSize: 14, 
                fontWeight: FontWeight.w500, 
               ),
              ), 
              SizedBox(
                height: 24,
              ), 
              Row(
                children: [
                  Image.asset(IconPath.bodyLanguage, 
                   width: 40,
                   height: 40,
                  ), 
                  SizedBox(
                    width: 5,
                  ), 
                  Text('Body Language',
                   style: getTextStyle(
                    color: Color(0xFF212121), 
                    fontSize: 20, 
                    fontWeight: FontWeight.w500
                   ),
                  )
                ],
              ), 
              SizedBox(
                height: 5,
              ), 
              Text('Your body language during the interview was impressive! You maintained good eye contact and had an open posture, which conveyed confidence. Just remember to avoid crossing your arms, as it can come off as defensive. Overall, well done!',
               textAlign: TextAlign.justify,
               style: getTextStyle(
                color: Color(0xFF293649), 
                fontSize: 14, 
                fontWeight: FontWeight.w500, 
               ),
              ), 
              SizedBox(
                height: 24,
              ), 
              Text('Confidence',
                   style: getTextStyle(
                    color: Color(0xFF212121), 
                    fontSize: 20, 
                    fontWeight: FontWeight.w500
                   ),
                  ), 
              Text('80/100',
                   style: getTextStyle(
                    color: Color(0xFF212121), 
                    fontSize: 20, 
                    fontWeight: FontWeight.w500
                   ),
                  ), 
              SizedBox(
                height: 24,
              ), 
              SuggestionContainer(), 
              SizedBox(
                height: 40,
              ), 
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){},
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12), 
                        border: Border.all(
                          color: Color(0xFF37B874)
                        )
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 10
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Retake',
                             style: getTextStyle(
                              color: Color(0xFF37B874), 
                              fontSize: 16, 
                              fontWeight: FontWeight.w500
                             ),
                            ), 
                            SizedBox(
                              width: 5,
                            ), 
                            Image.asset(IconPath.retakeIcon, 
                             height: 24, 
                             width: 24,
                            )
                          ],
                        ),
                      ),
                    ),
                  ), 
                  NextButton(onTap: controller.onFeedbackNext,)
                ],
              ), 
             
            ],
          ),
        ),
      ),
    );
  }
}