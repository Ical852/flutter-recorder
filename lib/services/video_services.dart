import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;

class VideoServices {
  Future<bool> uploadVideo({
    required XFile? videoFile
  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://api.cloudinary.com/v1_1/dk3lhojel/video/upload'),
      );
      request.files.add(await http.MultipartFile.fromPath('file', videoFile!.path));
      request.fields['upload_preset'] = 'ml_default';
      request.fields['public_id'] = 'random(${DateTime.now().millisecondsSinceEpoch})';
      request.fields['api_key'] = 'xxxxx';

      var response = await request.send();
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}