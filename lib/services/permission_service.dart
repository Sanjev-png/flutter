import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';

class PermissionService {
  static final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  static Future<bool> requestStoragePermission() async {
    if (Platform.isAndroid) {
      if (await _isAndroid13OrHigher()) {
        // For Android 13 and above, request media permissions
        final photos = await Permission.photos.request();
        final videos = await Permission.videos.request();
        final audio = await Permission.audio.request();
        
        return photos.isGranted && videos.isGranted && audio.isGranted;
      }
    }
    
    // For Android 12 and below, request storage permission
    final status = await Permission.storage.request();
    return status.isGranted;
  }

  static Future<bool> hasStoragePermission() async {
    if (Platform.isAndroid) {
      if (await _isAndroid13OrHigher()) {
        return await Permission.photos.isGranted &&
               await Permission.videos.isGranted &&
               await Permission.audio.isGranted;
      }
    }
    
    return await Permission.storage.isGranted;
  }

  static Future<bool> _isAndroid13OrHigher() async {
    if (Platform.isAndroid) {
      final androidInfo = await _deviceInfo.androidInfo;
      return androidInfo.version.sdkInt >= 33;
    }
    return false;
  }
}
