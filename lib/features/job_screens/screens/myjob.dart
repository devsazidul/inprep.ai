import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inprep_ai/core/common/styles/global_text_style.dart';
import 'package:inprep_ai/core/utils/constants/icon_path.dart';
import 'package:inprep_ai/features/job_screens/controller/jobs_controller.dart';
import 'package:inprep_ai/features/job_screens/screens/job_details.dart';
import 'package:inprep_ai/features/job_screens/screens/new_filter_screen.dart';
import 'package:intl/intl.dart'; // Import the intl package

class MyJobsScreen extends StatelessWidget {
  final JobsController jobsController = Get.put(JobsController());

  MyJobsScreen({super.key});

  String formatDate(String dateString) {
    try {
      DateTime dateTime = DateTime.parse(dateString);
      return DateFormat('yyyy-MM-dd').format(dateTime);
    } catch (e) {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F6F7),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 10,
              ),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Image.asset(IconPath.backarrow),
                  ),
                  SizedBox(width: 80),
                  Text(
                    'My Jobs',
                    style: TextStyle(
                      color: Color(0xFF212121),
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 10,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search for jobs...',
                        hintStyle: TextStyle(
                          color: Color(0xFFABB7C2),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Image.asset(
                            IconPath.search,
                            width: 20,
                            height: 20,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Get.dialog(
                          AlertDialog(
                            backgroundColor: Colors.white,
                            content: SingleChildScrollView(
                              child: FilterScreen(),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text("Apply"),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Image.asset(IconPath.filter1),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  itemCount:
                      jobsController
                          .jobsmodel
                          .length, // Correctly use jobsmodel
                  itemBuilder: (context, index) {
                    final job =
                        jobsController
                            .jobsmodel[index]; // Correctly reference jobsmodel
                    return Container(
                      margin: EdgeInsets.only(bottom: 12),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withValues(alpha: 0.1),
                            blurRadius: 8,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Job Title
                                Text(
                                  job.title ??
                                      'No Title', // Added fallback text
                                  style: getTextStyle(
                                    color: Color(0xff212121),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  job.company ??
                                      'No Company', // Added fallback text
                                  style: getTextStyle(
                                    color: Color(0xffAFAFAF),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(IconPath.location),
                                        SizedBox(width: 8),
                                        SizedBox(
                                          width: 160,
                                          child: Text(
                                            job.location ??
                                                'No Location', // Added fallback text
                                            overflow: TextOverflow.ellipsis,
                                            style: getTextStyle(
                                              color: Color(0xff676768),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Row(
                                      children: [
                                        Image.asset(IconPath.calendar),
                                        SizedBox(width: 2.5),
                                        Text(
                                          formatDate(
                                            job.posted ?? '',
                                          ), // Formatting the date
                                          style: getTextStyle(
                                            color: Color(0xff676768),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        job.isApplied!
                                            ? Colors.green[50]
                                            : Colors.orange[50],
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    job.isApplied! ? 'Applied' : 'Not Applied',
                                    style: getTextStyle(
                                      color:
                                          job.isApplied!
                                              ? Color(0xFF37B874)
                                              : Color(0xFFEF9614),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Pass the selected job data to the JobDetailsScreen using Get.to()
                              Get.to(() => JobDetailsScreen(), arguments: job);
                            },
                            child: CircleAvatar(
                              radius: 16,
                              backgroundColor: Color(0xFF37B874),
                              child: Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
