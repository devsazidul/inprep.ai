// import 'dart:convert';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:inprep_ai/features/notification/model/notification_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// // for firstWhereOrNull

// class NotificationController extends GetxController {
//   var notifications = <NotificationItem>[].obs;
//   var isLoading = false.obs;
//   var errorMessage = ''.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     fetchNotifications();
//   }

//   Future<void> fetchNotifications() async {
//     debugPrint('Starting fetchNotifications...');
//     isLoading.value = true;
//     errorMessage.value = '';

//     final url = Uri.parse(
//       'https://ai-interview-server-s2a5.onrender.com/api/v1/notifications/getAllNotifications',
//     );

//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final accessToken = prefs.getString('approvalToken');
//       debugPrint('Access token: $accessToken');

//       if (accessToken == null || accessToken.isEmpty) {
//         EasyLoading.showError('Authentication required');
//         isLoading.value = false;
//         return;
//       }

//       final response = await http.get(
//         url,
//         headers: {
//           'Authorization': accessToken, // <-- IMPORTANT
//           'Content-Type': 'application/json',
//         },
//       );

//       debugPrint('Response status code: ${response.statusCode}');
//       debugPrint('Response body: ${response.body}');

//       if (response.statusCode == 200) {
//         final jsonResponse = json.decode(response.body);
//         final allNotification = AllNotification.fromJson(jsonResponse);

//         notifications.value = allNotification.data.notificationList.map((notif) {
//           return NotificationItem(
//             id: notif.id,
//             message: notif.notificationDetail,
//             timeAgo: _formatTimeAgo(notif.createdAt),
//             imageUrl: 'https://placehold.co/48x48',
//             read: notif.isSeen ?? false, // null safety here
//           );
//         }).toList();

//         debugPrint('Notifications list populated with ${notifications.length} items');
//       } else {
//         errorMessage.value = 'Error: ${response.statusCode}';
//         notifications.clear();
//       }
//     } catch (e) {
//       errorMessage.value = 'Failed to fetch data: $e';
//       notifications.clear();
//       debugPrint('Exception: $e');
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   void markAllAsRead() {
//     for (var notification in notifications) {
//       notification.isRead.value = true;
//     }
//   }

//   void markAsRead(String id) {
//     final notif = notifications.firstWhereOrNull((n) => n.id == id);
//     if (notif != null) {
//       notif.isRead.value = true;
//     }
//   }

//   String _formatTimeAgo(DateTime date) {
//     final diff = DateTime.now().difference(date);
//     if (diff.inDays > 0) return '${diff.inDays}d ago';
//     if (diff.inHours > 0) return '${diff.inHours}h ago';
//     if (diff.inMinutes > 0) return '${diff.inMinutes}m ago';
//     return 'Just now';
//   }
// }


import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:inprep_ai/core/urls/endpint.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:inprep_ai/features/notification/model/notification_model.dart';

class NotificationController extends GetxController {
  final RxList<NotificationItem> notifications = <NotificationItem>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final String _readNotificationsKey = 'read_notifications';

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('approvalToken');

      if (accessToken == null || accessToken.isEmpty) {
        EasyLoading.showError('Authentication required');
        return;
      }

      final response = await http.get(
        Uri.parse(Urls.allnotification),
        headers: {
          'Authorization': accessToken,
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final allNotification = AllNotification.fromJson(jsonResponse);
        final readNotifications = await _loadReadNotifications();

        notifications.assignAll(allNotification.data.notificationList.map((notif) {
          final isRead = readNotifications.contains(notif.id) || notif.isSeen;
          return NotificationItem(
            id: notif.id,
            message: notif.notificationDetail,
            timeAgo: _formatTimeAgo(notif.createdAt),
            imageUrl: 'https://placehold.co/48x48',
            read: isRead,
          );
        }));
      } else {
        errorMessage.value = 'Error: ${response.statusCode}';
        notifications.clear();
      }
    } catch (e) {
      errorMessage.value = 'Failed to fetch data: $e';
      notifications.clear();
      debugPrint('Exception: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<Set<String>> _loadReadNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final readNotificationsJson = prefs.getString(_readNotificationsKey);
    return readNotificationsJson != null 
        ? Set<String>.from(json.decode(readNotificationsJson) as List)
        : <String>{};
  }

  Future<void> _saveReadNotifications(Set<String> readIds) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_readNotificationsKey, json.encode(readIds.toList()));
  }

  Future<void> markAllAsRead() async {
    final readIds = notifications.map((n) => n.id).toSet();
    await _saveReadNotifications(readIds);
    for (final notification in notifications) {
      notification.isRead.value = true;
    }
  }

  Future<void> markAsRead(String id) async {
    final notif = notifications.firstWhereOrNull((n) => n.id == id);
    if (notif != null) {
      final readNotifications = await _loadReadNotifications();
      readNotifications.add(id);
      await _saveReadNotifications(readNotifications);
      notif.isRead.value = true;
    }
  }

  String _formatTimeAgo(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inDays > 0) return '${diff.inDays}d ago';
    if (diff.inHours > 0) return '${diff.inHours}h ago';
    if (diff.inMinutes > 0) return '${diff.inMinutes}m ago';
    return 'Just now';
  }
}