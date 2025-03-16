import 'package:flutter/material.dart';

class StoreSettingPage extends StatelessWidget {
  const StoreSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Store Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Card(
            child: ListTile(
              leading: const Icon(Icons.store),
              title: const Text('Store Name'),
              subtitle: const Text('Edit your store name'),
              trailing: const Icon(Icons.edit),
              onTap: () {
                // TODO: Implement store name editing
              },
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: ListTile(
              leading: const Icon(Icons.location_on),
              title: const Text('Store Location'),
              subtitle: const Text('Update store address'),
              trailing: const Icon(Icons.edit),
              onTap: () {
                // TODO: Implement location editing
              },
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: ListTile(
              leading: const Icon(Icons.access_time),
              title: const Text('Business Hours'),
              subtitle: const Text('Set your operating hours'),
              trailing: const Icon(Icons.edit),
              onTap: () {
                // TODO: Implement business hours editing
              },
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: ListTile(
              leading: const Icon(Icons.phone),
              title: const Text('Contact Information'),
              subtitle: const Text('Update contact details'),
              trailing: const Icon(Icons.edit),
              onTap: () {
                // TODO: Implement contact info editing
              },
            ),
          ),
        ],
      ),
    );
  }
}
