import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inprep_ai/core/controllers/job_controller.dart';
import 'package:inprep_ai/features/job_screens/job_details.dart';
import 'package:inprep_ai/features/job_screens/new_filter_screen.dart';

class MyJobsScreen extends StatelessWidget {
  final JobController controller = Get.put(JobController());

  MyJobsScreen({super.key});

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
                  //Icon(Icons.arrow_back_ios, color: Colors.black),
                  InkWell(onTap: (){Get.back();}, child: Image.asset('assets/icons/job_screen_icons/back_arrow.png')),
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

            // Search and Filter
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
                          padding: const EdgeInsets.all(
                            12.0,
                          ), // adjust spacing as needed
                          child: Image.asset(
                            "assets/icons/job_screen_icons/search.png",
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

                  // Filter Icon
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: GestureDetector(
                      // Alert Dialog for Filter
                      onTap: () {
                        Get.dialog(
                          AlertDialog(
                            //title: Center(child: Text("Filter")),
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
                      child: Image.asset(
                        "assets/icons/job_screen_icons/filter.png",
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Job List
            Expanded(
              child: Obx(
                () => ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  itemCount: controller.jobs.length,
                  itemBuilder: (context, index) {
                    final job = controller.jobs[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: 12),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            blurRadius: 8,
                            spreadRadius: 2,
                          ),
                        ],
                      ),

                      // Card Elements
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Job Title
                                Text(
                                  job.title,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),

                                // Company Name
                                Text(
                                  job.company,
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                                SizedBox(height: 10),
                                // Row(
                                //   children: [
                                //     Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
                                //     SizedBox(width: 4),
                                //     Text(job.location),
                                //     SizedBox(width: 16),
                                //     Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
                                //     SizedBox(width: 4),
                                //     Text(job.date),
                                //   ],
                                // ),

                                // Location and Date
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        // Icon(
                                        //   Icons.location_on,
                                        //   size: 16,
                                        //   color: Colors.grey[600],
                                        // ),
                                        Image.asset(
                                          "assets/icons/job_screen_icons/location.png",
                                        ),
                                        SizedBox(width: 4),
                                        Text(job.location),
                                      ],
                                    ),
                                    Spacer(),
                                    Row(
                                      children: [
                                        // Icon(
                                        //   Icons.calendar_today,
                                        //   size: 16,
                                        //   color: Colors.grey[600],
                                        // ),
                                        Image.asset(
                                          "assets/icons/job_screen_icons/calendar.png",
                                        ),
                                        SizedBox(width: 2),
                                        SizedBox(width: 4),
                                        Text(job.date),
                                      ],
                                    ),
                                  ],
                                ),

                                SizedBox(height: 10),

                                // Applied Status
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        job.applied
                                            ? Colors.green[50]
                                            : Colors.orange[50],
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    job.applied ? 'Applied' : 'Not Applied',
                                    style: TextStyle(
                                      color:
                                          job.applied
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
                          //  NAVIGATION -- Go to the Job Details screen
                          GestureDetector(
                            onTap: () {
                              Get.to(() => JobDetailsScreen());
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
