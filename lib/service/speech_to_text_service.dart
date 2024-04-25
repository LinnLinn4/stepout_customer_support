import 'package:stepout_customer_support/service/network_api_service.dart';

class SpeechToText {
  final _api = NetworkAPI();

  Future<SpeechToTextResponse> recognize(List<int> file) async {
    try {
      final response = await _api.speechToTextWisper(file);
      return SpeechToTextResponse(
          text: response['text'] ?? '', isSuccess: true);
    } catch (e) {
      return SpeechToTextResponse(text: e.toString());
    }
  }
}

class SpeechToTextResponse {
  final bool isSuccess;
  final String text;
  SpeechToTextResponse({
    this.isSuccess = false,
    required this.text,
  });
}
