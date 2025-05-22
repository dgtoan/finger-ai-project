import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:image/image.dart' as img;
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

@injectable
class ImageService {
  Future<File?> pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null &&
        result.files.isNotEmpty &&
        result.files.first.path != null) {
      return File(result.files.first.path!);
    }
    return null;
  }

  Future<File?> processImage(File imageFile) async {
    try {
      // Read the image
      final imageBytes = await imageFile.readAsBytes();
      final decodedImage = img.decodeImage(imageBytes);

      if (decodedImage == null) {
        throw Exception('Failed to decode image');
      }

      // Process the image (e.g., resize, convert)
      final processedImage = img.copyResize(
        decodedImage,
        width: 512,
        height: 512,
      );

      // Save the processed image
      final tempDir = await getTemporaryDirectory();
      final tempPath = path.join(
        tempDir.path,
        'processed_${DateTime.now().millisecondsSinceEpoch}.png',
      );
      final processedFile = File(tempPath);

      await processedFile.writeAsBytes(img.encodePng(processedImage));
      return processedFile;
    } catch (e) {
      print('Error processing image: $e');
      return null;
    }
  }
}
