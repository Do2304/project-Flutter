import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ImageCompressorApp extends StatefulWidget {
  @override
  _ImageCompressorAppState createState() => _ImageCompressorAppState();
}

class _ImageCompressorAppState extends State<ImageCompressorApp> {
  File? _selectedImage;
  File? _compressedImage;
  bool _isCompressing = false;
  String? _error;

  Future<void> pickImage() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
          _compressedImage = null;
          _error = null;
          _isCompressing = true;
        });

        await compressImage(_selectedImage!);
      }
    } catch (e) {
      setState(() {
        _error = 'Error picking image: $e';
        _isCompressing = false;
      });
    }
  }

  Future<void> compressImage(File image) async {
    try {
      final tempDir = await getTemporaryDirectory();
      final targetPath = '${tempDir.path}/compressed_image.jpg';

      var result = await FlutterImageCompress.compressAndGetFile(
        image.absolute.path,
        targetPath,
        quality: 85,
      );

      if (result != null) {
        final compressedFile = File(result.path);
        if (await compressedFile.exists()) {
          final originalSize = await image.length();
          final compressedSize = await compressedFile.length();

          setState(() {
            _compressedImage = compressedFile;
            _isCompressing = false;
            _error = null;
          });
          print(
            'Original size: ${(originalSize / 1024).toStringAsFixed(2)} KB',
          );
          print(
            'Compressed size: ${(compressedSize / 1024).toStringAsFixed(2)} KB',
          );
        } else {
          throw Exception('Compressed file not found at path: $targetPath');
        }
      } else {
        throw Exception('Compression returned null path');
      }
    } catch (e) {
      setState(() {
        _error = 'Error compressing image: $e';
        _isCompressing = false;
      });
      print('Error compressing image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Compression'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              onPressed: _isCompressing ? null : pickImage,
              child: Text(
                _isCompressing ? 'Compressing...' : 'Pick and Compress Image',
              ),
            ),

            if (_error != null) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(8),
                color: Colors.red.shade100,
                child: Text(_error!, style: const TextStyle(color: Colors.red)),
              ),
            ],
            if (_selectedImage != null) ...[
              const SizedBox(height: 16),
              const Text(
                'Original Image',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Image.file(_selectedImage!),
            ],
            if (_compressedImage != null) ...[
              const SizedBox(height: 16),
              const Text(
                'Compressed Image',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Image.file(_compressedImage!),

              FutureBuilder<List<int>>(
                future: Future.wait([
                  _selectedImage!.length(),
                  _compressedImage!.length(),
                ]),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final originalSize = snapshot.data![0] / 1024;
                    final compressedSize = snapshot.data![1] / 1024;
                    final savings =
                        ((originalSize - compressedSize) / originalSize * 100);

                    return Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        'Original: ${originalSize.toStringAsFixed(2)} KB\n'
                        'Compressed: ${compressedSize.toStringAsFixed(2)} KB\n'
                        'Reduced by: ${savings.toStringAsFixed(1)}%',
                        style: const TextStyle(fontSize: 14),
                      ),
                    );
                  }

                  return const SizedBox();
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}
