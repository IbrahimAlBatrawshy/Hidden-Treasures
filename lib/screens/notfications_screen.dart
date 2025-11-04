import 'package:flutter/material.dart';
import 'package:hidden_treasures/constants/app_colors.dart';

// A simple model for a notification
class NotificationItem {
  final String message;
  final String time; // e.g., "Today", "Yesterday"
  final IconData icon;

  NotificationItem(
      {required this.message, required this.time, required this.icon});
}

class NotficationsScreen extends StatefulWidget {
  const NotficationsScreen({super.key});

  @override
  State<NotficationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotficationsScreen> {
  // State to hold the list of notifications
  final List<NotificationItem> _notifications = [
    NotificationItem(
        message:
            "🔥Trending Now: Live Jazz Night at Central Park, 30% off tickets until 8 PM!",
        time: "Today",
        icon: Icons.local_fire_department),
    NotificationItem(
        message: "🚗 Trending Now: Save 25% on compact cars this weekend only!",
        time: "Today",
        icon: Icons.directions_car),
    NotificationItem(
        message:
            "🎟️ Successfully booked the event! Please check your email to get your tickets. Have fun!",
        time: "Yesterday",
        icon: Icons.confirmation_number),
    NotificationItem(
        message: "🚗 Trending Now: Save 25% on compact cars this weekend only!",
        time: "Yesterday",
        icon: Icons.directions_car),
  ];

  void _clearNotifications() {
    setState(() {
      _notifications.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Group notifications by time
    final Map<String, List<NotificationItem>> groupedNotifications = {};
    for (var notif in _notifications) {
      if (groupedNotifications[notif.time] == null) {
        groupedNotifications[notif.time] = [];
      }
      groupedNotifications[notif.time]!.add(notif);
    }

    return Scaffold(
      backgroundColor: Color(0xFFFFF3E0),
      appBar: AppBar(
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.secondary,
        centerTitle: true,
      ),
      body: Column(
        children: [
          if (_notifications.isNotEmpty)
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: _clearNotifications,
                  child: const Text(
                    "Clear All",
                    style: TextStyle(color: AppColors.error, fontSize: 16),
                  ),
                ),
              ),
          Expanded(
            child: _notifications.isEmpty
                ? _buildEmptyState()
                : _buildNotificationsList(groupedNotifications),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_off_outlined,
            size: 100,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 20),
          Text(
            "No new notifications",
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationsList(
      Map<String, List<NotificationItem>> groupedNotifications) {
    final timeKeys = groupedNotifications.keys.toList();

    return ListView.builder(
      itemCount: timeKeys.length,
      itemBuilder: (context, index) {
        final time = timeKeys[index];
        final notifsForTime = groupedNotifications[time]!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 10),
              child: Text(
                time,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            ...notifsForTime
                .map((notif) => _buildNotificationCard(notif))
                .toList(),
          ],
        );
      },
    );
  }

  Widget _buildNotificationCard(NotificationItem notification) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      elevation: 2,
      shadowColor: AppColors.shadowLight,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.secondary.withOpacity(0.1),
          child: Icon(notification.icon, color: AppColors.secondary),
        ),
        title: Text(
          notification.message,
          style: const TextStyle(fontSize: 15, color: AppColors.textPrimary),
        ),
      ),
    );
  }
}
