import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:typed_data';
import 'package:stepout_customer_support/utility/constants.dart';

import 'package:http/http.dart' as http;

class NetworkAPI {
  Future<Map> speechToTextWisper(
    List<int> file,
  ) async {
    try {
      final request = http.MultipartRequest(
          'POST', Uri.parse("https://api.openai.com/v1/audio/transcriptions"));
      request.fields['model'] = "whisper-1";
      request.files.add(http.MultipartFile.fromBytes(
        'file',
        file,
        filename: "audio.wav",
      ));
      request.headers.addAll({
        "Content-Type": 'multipart/form-data',
        "Authorization": "Bearer $openAIToken"
      });
      final p = (await request.send());
      final t = await p.stream.bytesToString();
      final response = jsonDecode(t);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Uint8List?> openAITTS(
    String text, {
    String model = "tts-1",
    String voice = "echo",
    double speed = 1.0,
  }) async {
    const apiUrl = "https://api.openai.com/v1/audio/speech";
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $openAIToken",
        },
        body: jsonEncode(
          {
            "model": model,
            "input": text,
            "voice": voice,
            "speed": speed,
          },
        ),
      );
      if (response.statusCode == 200) {
        return response.bodyBytes;
      }
    } catch (e) {
      dev.log(e.toString());

      throw Exception();
    }
    return null;
  }
}
