import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inprep_ai/core/controllers/job_details_controller.dart';

class JobDetailsScreen extends StatelessWidget {
  final JobDetailsController controller = Get.put(JobDetailsController());

  JobDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Software Developer',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFFF8F8F8),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildInfoRow(
                      'Company',
                      'Tech Innovators Inc.',
                      Color(0xFF37B874),
                    ),
                    buildInfoRow(
                      'Location',
                      'San Francisco, CA',
                      Color(0xFF37B874),
                    ),
                    buildInfoRow(
                      'Apply Date',
                      'April 10, 2025',
                      Color(0xFF37B874),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              Text('Job Description', style: sectionTitleStyle()),
              SizedBox(height: 8),
              Text(
                'Develop scalable applications in JavaScript & Python. Work with cloud technologies like AWS, GCP, Azure. Collaborate with cross-functional teams.',
                style: bodyStyle(),
              ),
              SizedBox(height: 24),
              Text('Job Requirements', style: sectionTitleStyle()),
              SizedBox(height: 8),
              Text(
                'Strong coding skills in JavaScript, Python. Knowledge of cloud technologies.',
                style: bodyStyle(),
              ),
              SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF37B874),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                  onPressed: () {},
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Start Mock Interview',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.play_arrow),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 32),
              Text('Previous Interview Results', style: sectionTitleStyle()),
              SizedBox(height: 8),
              Text('Inprep Score', style: bodyStyle()),
              Obx(
                () => Text(
                  '${controller.inprepScore}/100',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Text('Feedback', style: bodyStyle()),
              SizedBox(height: 4),
              Text(controller.feedback, style: bodyStyle()),
              SizedBox(height: 24),
             
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInfoRow(String label, String value, Color valueColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey[700])),
          Text(value, style: TextStyle(color: valueColor)),
        ],
      ),
    );
  }

  TextStyle sectionTitleStyle() {
    return TextStyle(fontWeight: FontWeight.bold, fontSize: 18);
  }

  TextStyle bodyStyle() {
    return TextStyle(fontSize: 14, color: Colors.black87);
  }
}
