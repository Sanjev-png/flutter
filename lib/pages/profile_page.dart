import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, size: 20),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/login',
                (route) => false,
              );
            },
            tooltip: 'Logout',
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const CircleAvatar(
            radius: 50,
            child: Icon(Icons.person, size: 50),
          ),
          const SizedBox(height: 16),
          Card(
            child: ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Personal Information'),
              subtitle: const Text('Update your details'),
              trailing: const Icon(Icons.edit),
              onTap: () {
                // TODO: Implement personal info editing
              },
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Notifications'),
              subtitle: const Text('Manage notifications'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                // TODO: Implement notifications settings
              },
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: ListTile(
              leading: const Icon(Icons.security),
              title: const Text('Security'),
              subtitle: const Text('Update password and security settings'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                // TODO: Implement security settings
              },
            ),
          ),
        ],
      ),
    );
  }
}
