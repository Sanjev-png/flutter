import 'package:flutter/material.dart';
import 'dart:io';
import '../models/store.dart';
import '../services/database_helper.dart';
import '../services/logger_service.dart';

class StoreSettingsPage extends StatefulWidget {
  const StoreSettingsPage({super.key});

  @override
  State<StoreSettingsPage> createState() => _StoreSettingsPageState();
}

class _StoreSettingsPageState extends State<StoreSettingsPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _categoryController = TextEditingController();
  final _descriptionController = TextEditingController();
  Store? _store;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadStore();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _categoryController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _loadStore() async {
    try {
      setState(() => _isLoading = true);
      final store = await DatabaseHelper.instance.getStore();
      setState(() {
        _store = store;
        _nameController.text = store.name;
        _categoryController.text = store.category;
        _descriptionController.text = store.description;
        _isLoading = false;
      });
    } catch (e) {
      LoggerService.error('Error loading store', e);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading store: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
      setState(() => _isLoading = false);
    }
  }

  Future<void> _saveStore() async {
    if (_formKey.currentState!.validate() && _store != null) {
      try {
        final updatedStore = _store!.copyWith(
          name: _nameController.text.trim(),
          category: _categoryController.text.trim(),
          description: _descriptionController.text.trim(),
        );

        await DatabaseHelper.instance.updateStore(updatedStore);
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Store settings saved successfully!'),
              duration: Duration(seconds: 2),
            ),
          );
          Navigator.pop(context, true);
        }
      } catch (e) {
        LoggerService.error('Error saving store', e);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error saving store: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Store Settings'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Store Image
                    Center(
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.grey[300],
                            backgroundImage: _store?.imagePath != null
                                ? FileImage(File(_store!.imagePath!))
                                : null,
                            child: _store?.imagePath == null
                                ? const Icon(Icons.store, size: 60)
                                : null,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: CircleAvatar(
                              backgroundColor: Theme.of(context).primaryColor,
                              child: IconButton(
                                icon: const Icon(Icons.camera_alt),
                                color: Colors.white,
                                onPressed: () {
                                  // TODO: Implement image picker
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Store Name
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Store Name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a store name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    // Store Category
                    TextFormField(
                      controller: _categoryController,
                      decoration: const InputDecoration(
                        labelText: 'Store Category',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a store category';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    // Store Description
                    TextFormField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Store Description',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a store description';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _saveStore,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Text('Save Settings'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
