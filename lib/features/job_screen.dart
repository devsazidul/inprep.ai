// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:inprep_ai/core/controllers/job_controller.dart';

// void main() {
//   runApp(GetMaterialApp(debugShowCheckedModeBanner: false, home: JobScreen()));
// }

// class JobScreen extends StatelessWidget {
//   final JobController jobController = Get.put(JobController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFF6F6F7),
//       appBar: AppBar(
//         title: Text(
//           "My Jobs",
//           style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
//         ),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(12),
//             child: TextField(
//               decoration: InputDecoration(
//                 hintText: "Search for jobs...",
//                 prefixIcon: Icon(Icons.search),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             child: Obx(() {
//               return ListView.builder(
//                 itemCount: jobController.jobs.length,
//                 itemBuilder: (_, index) {
//                   final job = jobController.jobs[index];
//                   return Card(
//                     margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     color: Color(0xFFFFFFFF),
//                     child: ListTile(
//                       title: Text(job.title),
//                       subtitle: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             job.company,
//                             style: TextStyle(
//                               color: Color(0xFFAFAFAF),
//                               fontSize: 14,
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//                           Row(
//                             children: [
//                               Icon(Icons.location_on, size: 16),
//                               SizedBox(width: 4),
//                               Text(
//                                 job.location,
//                                 style: TextStyle(
//                                   color: Color(0xFF676768),
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w400,
//                                 ),
//                               ),
//                               Spacer(),
//                               Icon(Icons.calendar_today, size: 16),
//                               SizedBox(width: 4),
//                               Text(job.date),
//                             ],
//                           ),
//                           SizedBox(height: 6),
//                           Container(
//                             padding: EdgeInsets.symmetric(
//                               horizontal: 8,
//                               vertical: 4,
//                             ),
//                             decoration: BoxDecoration(
//                               color:
//                                   job.applied
//                                       ? Colors.green.shade100
//                                       : Colors.orange.shade100,
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: Text(
//                               job.applied ? 'Applied' : 'Not Applied',
//                               style: TextStyle(fontSize: 12),
//                             ),
//                           ),
//                         ],
//                       ),
//                       trailing: Icon(Icons.arrow_forward, color: Colors.green),
//                     ),
//                   );
//                 },
//               );
//             }),
//           ),
//         ],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: 0,
//         items: [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
//           BottomNavigationBarItem(icon: Icon(Icons.school), label: ''),
//           BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: ''),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
//         ],
//       ),
//     );
//   }
// }
