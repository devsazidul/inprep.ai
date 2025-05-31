import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inprep_ai/features/notification/controller/notification_controller.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  final NotificationController notificationController = Get.put(
    NotificationController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F6F7),
      appBar: AppBar(
        title: Text('Notifications'),
        backgroundColor: Color(0xFFF6F6F7),
        elevation: 0,
        centerTitle: true,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          // Mark all as read button aligned right
          Padding(
            padding: EdgeInsets.only(right: 5, top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: notificationController.markAllAsRead,
                  child: Text(
                    'Mark all as read',
                    style: TextStyle(
                      color: Color(0xFF37B874),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // List of notifications takes remaining space
          Expanded(
            child: Obx(() {
              return ListView.separated(
                padding: EdgeInsets.all(16),
                itemCount: notificationController.notifications.length,
                separatorBuilder: (_, __) => SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final notification =
                      notificationController.notifications[index];

                  return Obx(
                    () => GestureDetector(
                      onTap:
                          () => notificationController.markAsRead(
                            notification.id,
                          ),
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color:
                              notification.isRead.value
                                  ? Colors.white
                                  : Color(0xFFEBF8F1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 24,
                              backgroundColor:
                                  notification.isRead.value
                                      ? Colors.grey[300]
                                      : Color(0xFF2E70E8),
                              backgroundImage: NetworkImage(
                                notification.imageUrl,
                              ),
                              child:
                                  notification.isRead.value
                                      ? null
                                      : Text(
                                        notification.message
                                            .substring(0, 2)
                                            .toUpperCase(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                notification.message,
                                style: TextStyle(
                                  color:
                                      notification.isRead.value
                                          ? Color(0xFF333333)
                                          : Color(0xFF0D3C6B),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            SizedBox(width: 12),
                            Text(
                              notification.timeAgo,
                              style: TextStyle(
                                color: Color(0xFF475569),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
