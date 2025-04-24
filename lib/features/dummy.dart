import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class JobController extends GetxController {
  var jobs =
      [
        Job(
          "Software Developer",
          "Tech Innovators Inc.",
          "San Francisco, CA",
          "April 10, 2025",
          false,
        ),
        Job(
          "Product Manager",
          "Creative Solutions LLC",
          "Austin, TX",
          "May 15, 2025",
          true,
        ),
        Job("UX Designer", "Design Co.", "New York, NY", "June 20, 2025", true),
        Job(
          "Data Analyst",
          "Insightful Data",
          "Chicago, IL",
          "July 1, 2025",
          false,
        ),
        Job(
          "Marketing Specialist",
          "Brand Builders",
          "Los Angeles, CA",
          "August 5, 2025",
          true,
        ),
      ].obs;
}

class Job {
  final String title;
  final String company;
  final String location;
  final String date;
  final bool applied;

  Job(this.title, this.company, this.location, this.date, this.applied);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(home: JobScreen(), debugShowCheckedModeBanner: false);
  }
}

class JobScreen extends StatelessWidget {
  final JobController controller = Get.put(JobController());

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
                  Image.asset('assets/icons/job_screen_icons/back_arrow.png'),
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
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        children: [
                          // Icon(Icons.search, color: Colors.grey),
                          // SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search for jobs...',
                                hintStyle: TextStyle(
                                  color: Color(0xFFABB7C2),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          // Search Icon
                          //Icon(Icons.search, color: Colors.grey),
                          Image.asset(
                            "assets/icons/job_screen_icons/search.png",
                          ),
                        ],
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
                    child:
                    //Icon(Icons.filter_alt_outlined, color: Colors.black),
                    Image.asset("assets/icons/job_screen_icons/filter.png"),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                          CircleAvatar(
                            radius: 16,
                            backgroundColor: Color(0xFF37B874),
                            child: Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.home, size: 28, color: Color(0xFF878788)),
                  Icon(Icons.school, size: 28, color: Color(0xFF878788)),
                  Icon(Icons.auto_graph, size: 28, color: Color(0xFF878788)),
                  Icon(Icons.person, size: 28, color: Color(0xFF878788)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
