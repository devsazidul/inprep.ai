
// // ignore_for_file: use_super_parameters
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:inprep_ai/core/common/styles/global_text_style.dart';
// import 'package:inprep_ai/features/notification/controller/notification_controller.dart';

// class NotificationScreen extends StatelessWidget {
//   NotificationScreen({Key? key}) : super(key: key);

//   final NotificationController notificationController = Get.put(
//     NotificationController(),
//   );

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF6F6F7),
//       appBar: AppBar(
//         title: Text(
//           'Notifications',
//           style: getTextStyle(
//             color: const Color(0xff333333),
//             fontSize: 24,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         backgroundColor: const Color(0xFFF6F6F7),
//         elevation: 0,
//         centerTitle: true,
//         foregroundColor: Colors.black,
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(right: 5, top: 5),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 TextButton(
//                   onPressed: notificationController.markAllAsRead,
//                   child: Text(
//                     'Mark all as read',
//                     style: getTextStyle(
//                       color: const Color(0xFF37B874),
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: Obx(() {
//               if (notificationController.notifications.isEmpty) {
//                 return const Center(child: Text('No notifications'));
//               }
//               return ListView.separated(
//                 padding: const EdgeInsets.all(16),
//                 itemCount: notificationController.notifications.length,
//                 separatorBuilder: (_, __) => const SizedBox(height: 12),
//                 itemBuilder: (context, index) {
//                   final notification =
//                       notificationController.notifications[index];
//                   return GestureDetector(
//                     onTap:
//                         () =>
//                             notificationController.markAsRead(notification.id),
//                     child: Obx(
//                       () => Container(
//                         padding: const EdgeInsets.all(16),
//                         decoration: BoxDecoration(
//                           color:
//                               notification.isRead.value
//                                   ? Colors.white
//                                   : const Color(0xFFEBF8F1),
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Row(
//                           children: [
//                             CircleAvatar(
//                               radius: 24,
//                               backgroundColor:
//                                   notification.isRead.value
//                                       ? Colors.grey[300]
//                                       : Color(0xFF2E70E8),
//                               child: ClipOval(
//                                 child: FadeInImage.assetNetwork(
//                                   placeholder:
//                                       'assets/icons/notification.png', // local placeholder asset
//                                   image:
//                                       notification.imageUrl.isNotEmpty
//                                           ? notification.imageUrl
//                                           : '',
//                                   fit: BoxFit.cover,
//                                   imageErrorBuilder: (
//                                     context,
//                                     error,
//                                     stackTrace,
//                                   ) {
//                                     return Center(
//                                       child: Text(
//                                         notification.message.length >= 2
//                                             ? notification.message
//                                                 .substring(0, 2)
//                                                 .toUpperCase()
//                                             : notification.message
//                                                 .toUpperCase(),
//                                         style: getTextStyle(
//                                           color: Colors.white,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               ),
//                             ),
//                             SizedBox(width: 12),
//                             Expanded(
//                               child: Text(
//                                 notification.message,
//                                 style: getTextStyle(
//                                   color:
//                                       notification.isRead.value
//                                           ? const Color(0xFF333333)
//                                           : const Color(0xFF0D3C6B),
//                                   fontWeight: FontWeight.w500,
//                                   fontSize: 14,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(width: 12),
//                             Text(
//                               notification.timeAgo,
//                               style: getTextStyle(
//                                 color: const Color(0xFF475569),
//                                 fontSize: 12,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               );
//             }),
//           ),
//         ],
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inprep_ai/core/common/styles/global_text_style.dart';
import 'package:inprep_ai/features/notification/controller/notification_controller.dart';
import 'package:inprep_ai/features/notification/model/notification_model.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  final NotificationController notificationController = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F7),
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: getTextStyle(
            color: const Color(0xff333333),
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: const Color(0xFFF6F6F7),
        elevation: 0,
        centerTitle: true,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 5, top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: notificationController.markAllAsRead,
                  child: Text(
                    'Mark all as read',
                    style: getTextStyle(
                      color: const Color(0xFF37B874),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              if (notificationController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              
              if (notificationController.errorMessage.value.isNotEmpty) {
                return Center(child: Text(notificationController.errorMessage.value));
              }
              
              if (notificationController.notifications.isEmpty) {
                return const Center(child: Text('No notifications'));
              }
              
              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: notificationController.notifications.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final notification = notificationController.notifications[index];
                  return _buildNotificationItem(notification);
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem(NotificationItem notification) {
    return GestureDetector(
      onTap: () => notificationController.markAsRead(notification.id),
      child: Obx(
        () => Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: notification.isRead.value
                ? Colors.white
                : const Color(0xFFEBF8F1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: notification.isRead.value
                    ? Colors.grey[300]
                    : const Color(0xFF2E70E8),
                child: ClipOval(
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/icons/notification.png',
                    image: notification.imageUrl,
                    fit: BoxFit.cover,
                    imageErrorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Text(
                          notification.message.length >= 2
                              ? notification.message.substring(0, 2).toUpperCase()
                              : notification.message.toUpperCase(),
                          style: getTextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  notification.message,
                  style: getTextStyle(
                    color: notification.isRead.value
                        ? const Color(0xFF333333)
                        : const Color(0xFF0D3C6B),
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                notification.timeAgo,
                style: getTextStyle(
                  color: const Color(0xFF475569),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}