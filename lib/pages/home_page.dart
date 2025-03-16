import 'package:flutter/material.dart';
import 'product_list_page.dart';
import 'store_setting_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome to Store Creator',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Card(
              child: ListTile(
                leading: const Icon(Icons.store, size: 32),
                title: const Text('Create New Store'),
                subtitle: const Text('Start building your online store'),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () {
                  // TODO: Implement store creation
                },
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                leading: const Icon(Icons.shopping_bag, size: 32),
                title: const Text('Manage Products'),
                subtitle: const Text('Add or edit your products'),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProductListPage(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                leading: const Icon(Icons.analytics, size: 32),
                title: const Text('Analytics'),
                subtitle: const Text('View your store statistics'),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () {
                  // TODO: Implement analytics
                },
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                leading: const Icon(Icons.settings, size: 32),
                title: const Text('Store Settings'),
                subtitle: const Text('Configure your store'),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const StoreSettingPage(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
