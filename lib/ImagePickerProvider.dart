
import 'dart:io';
import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImagePickerProvider extends ChangeNotifier {

  File? _image;
  String? _error;
  bool _isLoading = false;

  File? get image => _image;
  String? get error => _error;
  bool get isLoading => _isLoading;

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage(
      ImageSource source, {
        double? maxWidth,
        double? maxHeight,
        BuildContext? context,
        int? imageQuality,
      }) async {
    try {
      Navigator.pop(context!);
      _setLoading(true);
      _clearError();
      // Request permission based on source
      final permissionStatus = await _requestPermission(source);
      if (!permissionStatus) {
        _setError('Permission denied', source);
        AppSettings.openAppSettings(type: AppSettingsType.camera);
        return;
      }
      final pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        imageQuality: imageQuality
      );
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        _setError('No image selected');
      }
    } catch (e) {
      _setError('Error picking image: $e');
    } finally {
      _setLoading(false);
      notifyListeners();
    }
  }

  Future<bool> _requestPermission(ImageSource source) async {
    final permission =
    source == ImageSource.camera ? Permission.camera : Permission.photos;
    final status = await permission.status;
    if (status.isGranted) return true;
    if (status.isLimited) {
      // Handle iOS limited photo library access
      _setError('Limited access to photos. Please allow full access.');
      await openAppSettings();
      return false;
    }
    if (status.isPermanentlyDenied) {
      _setError(
          'Permission permanently denied. Please enable it in settings.', source);
      await openAppSettings();
      return false;
    }
    final newStatus = await permission.request();
    return newStatus.isGranted;
  }

  Future<void> showImageSourceDialog(BuildContext context) async {
    final source = await showDialog<ImageSource>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Image Source'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, ImageSource.camera),
            child: const Text('Camera'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, ImageSource.gallery),
            child: const Text('Gallery'),
          ),
        ],
      ),
    );
    if (source != null) {
      await pickImage(source);
    }
  }

  void clearImage() {
    _image = null;
    _clearError();
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
  }

  void _setError(String error, [ImageSource? source]) {
    switch (error) {
      case 'Permission denied':
        _error = 'Please grant permission to access '
            '${source == ImageSource.camera ? 'camera' : 'photos'}.';
        break;
      case 'No image selected':
        _error = 'No image was selected. Please try again.';
        break;
      case 'Limited access to photos. Please allow full access.':
      case 'Permission permanently denied. Please enable it in settings.':
        _error = error;
        break;
      default:
        _error = 'An error occurred: $error';
    }
  }

  void _clearError() {
    _error = null;
  }

  @override
  void dispose() {
    _image = null;
    super.dispose();
  }
}