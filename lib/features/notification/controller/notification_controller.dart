import 'package:get/get.dart';
import 'package:inprep_ai/features/notification/model/notification_model.dart';

class NotificationController extends GetxController {
  final notifications = <NotificationItem>[
    NotificationItem(
      id: '1',
      message: 'Your task to inspect the roof of the XYZ building has been assigned. Review the details.',
      timeAgo: '15h',
      imageUrl: 'https://placehold.co/48x48',
      read: false,
    ),
    NotificationItem(
      id: '2',
      message: 'The plumbing system of the ABC building needs maintenance. Schedule a visit.',
      timeAgo: '2d',
      imageUrl: 'https://placehold.co/48x48',
      read: true,
    ),
    // Add more notifications here...
  ].obs;

  void markAllAsRead() {
    for (var notification in notifications) {
      notification.isRead.value = true;
    }
  }

  void markAsRead(String id) {
    final notif = notifications.firstWhere((n) => n.id == id);
    notif.isRead.value = true;
  }
}
