import 'package:get/get_rx/src/rx_types/rx_types.dart';

class NotificationItem {
  final String id;
  final String message;
  final String timeAgo;
  final String imageUrl;
  RxBool isRead;

  NotificationItem({
    required this.id,
    required this.message,
    required this.timeAgo,
    required this.imageUrl,
    bool read = false,
  }) : isRead = read.obs;
}