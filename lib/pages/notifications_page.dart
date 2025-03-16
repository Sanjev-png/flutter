import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // TODO: Implement notification settings
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: 0, // TODO: Replace with actual notifications count
        itemBuilder: (context, index) {
          return const Card(
            child: ListTile(
              leading: CircleAvatar(child: Icon(Icons.notifications)),
              title: Text('Notification Title'),
              subtitle: Text('Notification description goes here'),
              trailing: Text('2h ago'),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implement mark all as read
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('All notifications marked as read'),
              duration: Duration(seconds: 2),
            ),
          );
        },
        child: const Icon(Icons.done_all),
      ),
    );
  }
}
