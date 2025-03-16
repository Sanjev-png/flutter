import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/product.dart';
import '../models/store.dart';
import 'permission_service.dart';
import 'logger_service.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    
    // Check for storage permission before initializing database
    final hasPermission = await PermissionService.hasStoragePermission();
    if (!hasPermission) {
      final granted = await PermissionService.requestStoragePermission();
      if (!granted) {
        throw Exception('Storage permission is required to use the app');
      }
    }

    _database = await _initDB('store.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    try {
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      String path = join(documentsDirectory.path, filePath);
      await Directory(documentsDirectory.path).create(recursive: true);

      return await openDatabase(
        path,
        version: 2,
        onCreate: _createDB,
        onUpgrade: _onUpgrade,
        onConfigure: (db) async {
          await db.execute('PRAGMA foreign_keys = ON');
        },
      );
    } catch (e) {
      LoggerService.error('Error initializing database', e);
      throw Exception('Failed to initialize database: $e');
    }
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE store(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        category TEXT NOT NULL,
        description TEXT NOT NULL,
        imagePath TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE products(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        description TEXT NOT NULL,
        price REAL NOT NULL,
        category TEXT NOT NULL
      )
    ''');

    // Insert default store
    await db.insert('store', {
      'name': 'My Store',
      'category': 'General',
      'description': 'Welcome to my store',
    });
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Create store table
      await db.execute('''
        CREATE TABLE store(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          category TEXT NOT NULL,
          description TEXT NOT NULL,
          imagePath TEXT
        )
      ''');

      // Remove category from products table
      await db.execute('ALTER TABLE products RENAME TO _products_old');
      await db.execute('''
        CREATE TABLE products(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          description TEXT NOT NULL,
          price REAL NOT NULL,
          category TEXT NOT NULL
        )
      ''');
      await db.execute('''
        INSERT INTO products (id, name, description, price, category)
        SELECT id, name, description, price, category FROM _products_old
      ''');
      await db.execute('DROP TABLE _products_old');

      // Insert default store
      await db.insert('store', {
        'name': 'My Store',
        'category': 'General',
        'description': 'Welcome to my store',
      });
    }
  }

  // Store methods
  Future<Store> getStore() async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query('store', limit: 1);
      if (maps.isEmpty) {
        throw Exception('Store not found');
      }
      return Store.fromMap(maps.first);
    } catch (e) {
      LoggerService.error('Error getting store', e);
      throw Exception('Failed to get store: $e');
    }
  }

  Future<int> updateStore(Store store) async {
    try {
      final db = await database;
      return await db.update(
        'store',
        store.toMap(),
        where: 'id = ?',
        whereArgs: [store.id],
      );
    } catch (e) {
      LoggerService.error('Error updating store', e);
      throw Exception('Failed to update store: $e');
    }
  }

  Future<int> insertProduct(Product product) async {
    try {
      final db = await database;
      final Map<String, dynamic> data = product.toMap()..remove('id');
      return await db.insert('products', data);
    } catch (e) {
      LoggerService.error('Error inserting product', e);
      throw Exception('Failed to insert product: $e');
    }
  }

  Future<List<Product>> getAllProducts() async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query('products');
      return List.generate(maps.length, (i) {
        final map = maps[i];
        map['price'] = (map['price'] as num).toDouble();
        return Product.fromMap(map);
      });
    } catch (e) {
      LoggerService.error('Error getting products', e);
      throw Exception('Failed to get products: $e');
    }
  }

  Future<int> updateProduct(Product product) async {
    try {
      final db = await database;
      if (product.id == null) return 0;
      return await db.update(
        'products',
        product.toMap(),
        where: 'id = ?',
        whereArgs: [product.id],
      );
    } catch (e) {
      LoggerService.error('Error updating product', e);
      throw Exception('Failed to update product: $e');
    }
  }

  Future<int> deleteProduct(int id) async {
    try {
      final db = await database;
      return await db.delete(
        'products',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      LoggerService.error('Error deleting product', e);
      throw Exception('Failed to delete product: $e');
    }
  }

  // Debug method to check database content
  Future<void> printAllProducts() async {
    try {
      final db = await database;
      final products = await db.query('products');
      LoggerService.debug('Current products in database:');
      for (var product in products) {
        LoggerService.debug(product.toString());
      }
    } catch (e) {
      LoggerService.error('Error printing products', e);
    }
  }
}
