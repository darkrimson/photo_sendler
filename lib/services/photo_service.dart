import 'package:http/http.dart' as http;
import '../models/photo_model.dart';

class PhotoService {
  Future<void> sendPhoto(PhotoModel photoModel) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('https://flutter-sandbox.free.beeceptor.com/upload_photo/'),
      );

      request.headers['Content-Type'] = 'application/javascript';

      request.fields['comment'] = photoModel.comment;
      request.fields['latitude'] = photoModel.latitude.toString();
      request.fields['longitude'] = photoModel.longitude.toString();
      request.files.add(
          await http.MultipartFile.fromPath('photo', photoModel.photoPath));

      print("Request URL: ${request.url}");
      print("Request Headers: ${request.headers}");
      print("Request Fields: ${request.fields}");
      print(
          "Request Files: ${request.files.map((file) => file.filename).toList()}");

      final response = await request.send();
      if (response.statusCode == 200) {
        print("The photo was sent successfully!");
      } else {
        print("Error when sending a photo: ${response.statusCode}");
      }
    } catch (e) {
      print("Error when sending a photo: $e");
    }
  }
}
