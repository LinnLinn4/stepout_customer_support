import 'dart:convert';
import 'dart:typed_data';
import 'package:dio/dio.dart';

import 'package:http/http.dart' as http;
import 'package:stepout_customer_support/utility/constants.dart';

class NetworkAPI {
  Future<Map> speechToTextWisper(
    List<int> file,
  ) async {
    try {
      final request = http.MultipartRequest(
          'POST', Uri.parse("https://dev.api.lango.ai/v1/temp/sttWhisper/"));
      request.files.add(http.MultipartFile.fromBytes(
        'audioFile',
        file,
        filename: "audio.wav",
      ));
      request.headers.addAll({
        "Content-Type": 'multipart/form-data',
        "Authorization": "Bearer $sTTKey"
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
    try {
      final ssml = '''
      <speak version="1.0" xmlns="http://www.w3.org/2001/10/synthesis" xml:lang="en-US">
        <voice name="en-US-AdamMultilingualNeural">
          $text
        </voice>
      </speak>
    ''';
      final response = await Dio().postUri(
        Uri.parse(
            "https://southeastasia.tts.speech.microsoft.com/cognitiveservices/v1"),
        options: Options(
          contentType: "application/ssml+xml",
          responseType: ResponseType.bytes,
          headers: {
            "Ocp-Apim-Subscription-Key": ttsKey,
            "Content-Type": "application/ssml+xml",
            "X-Microsoft-OutputFormat": "audio-16khz-128kbitrate-mono-mp3",
          },
        ),
        data: ssml,
      );

      return Uint8List.fromList(response.data);
    } catch (e) {
      print('Error: $e');
    }
    return Uint8List.fromList([]);
  }
}
