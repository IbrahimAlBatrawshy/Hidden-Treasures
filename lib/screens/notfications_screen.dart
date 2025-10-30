import 'package:flutter/material.dart';

class NotficationsScreen extends StatefulWidget {
  const NotficationsScreen({super.key});

  @override
  State<NotficationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotficationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new_outlined,
                      size: 30,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Scaffold(
                          body: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.notifications_off,
                                  size: 100,
                                  color: Colors.grey[400],
                                ),
                                Text(
                                  "No new notifications",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey[400],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Text(
                      "clear all",
                      style: TextStyle(color: Colors.red, fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Notifications list
            Expanded(
              child: ListView(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Today",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildNotificationCard(
                    "🔥Trending Now: Live Jazz Night at Central Park,\n30% off tickets until 8 PM!",
                  ),
                  _buildNotificationCard(
                    "🚗 Trending Now: Save 25% on compact cars this weekend only!",
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Yesterday",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildNotificationCard(
                    "🎟️ Successfully booked the event! Please check your email to get your tickets. Have fun!",
                  ),
                  _buildNotificationCard(
                    "🚗 Trending Now: Save 25% on compact cars this weekend only!",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationCard(String message) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.grey.shade200,
        ),
        child: Text(message, style: const TextStyle(fontSize: 15)),
      ),
    );
  }
}
