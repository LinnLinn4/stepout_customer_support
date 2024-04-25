// ignore_for_file: depend_on_referenced_packages, constant_identifier_names
import 'dart:developer' as dev;
import 'package:stepout_customer_support/service/audio_player_service.dart';
import 'package:stepout_customer_support/service/network_api_service.dart';
import 'package:stepout_customer_support/service/speech_to_text_service.dart';
import 'package:stepout_customer_support/utility/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:http/http.dart' as http;
import 'package:record/record.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:stepout_customer_support/cart_notifier.dart';

enum SystemMessageTypes {
  doctor_info,
  date,
  consultation_ended,
}

enum CustomMessageTypes {
  reminder,
}

class ChatViewModel extends ChangeNotifier {
  late String path;
  AudioRecorder record = AudioRecorder();

  final AudioPlayerService _audioPlayerService = AudioPlayerService(volume: 1);
  final networkAPI = NetworkAPI();
  late SpeechToText speechToText;
  late AutoScrollController scrollController;
  bool isRecording = false;
  bool isAIProcessing = false;
  bool isAISpeaking = false;
  final gemini = Gemini.instance;
  final List<types.Message> messagesList = [];
  bool initializing = true;
  final List<Product> productsList = [
    Product(
        id: 1,
        name: "Nike Dunk Low",
        price: 5000,
        description:
            "Enjoy a calm and comfortable experience wherever you go on holiday.")
  ];
  void init(BuildContext context) async {
    try {
      scrollController = AutoScrollController();
      path = "";
      speechToText = SpeechToText();
      await _audioPlayerService.initAudioPlayer(1);
      initializing = false;
      notifyListeners();
    } catch (e) {
      dev.log(e.toString());
      notifyListeners();
      init(context);
    }
  }

  @override
  void dispose() {
    record.dispose();
    _audioPlayerService.dispose();
    super.dispose();
  }

  void addMessage(types.Message message) {
    messagesList.add(message);
    notifyListeners();
    Future.delayed(
      const Duration(milliseconds: 300),
      () {
        scrollToBottom();
      },
    );
  }

  void recordOrStop() {
    if (isAIProcessing) {
      return;
    }
    scrollToBottom();
    if (isRecording) {
      stopRecording();
      return;
    }
    startRecording();
  }

  void scrollToBottom() {
    scrollController.scrollToIndex(
      99999,
      preferPosition: AutoScrollPosition.end,
      duration: const Duration(milliseconds: 300),
    );
  }

  void startRecording() async {
    isRecording = true;
    notifyListeners();
    try {
      _audioPlayerService.play(AssetManager.beforeSpeakAudio);
      await record.start(
        const RecordConfig(
          bitRate: 16000,
          sampleRate: 16000,
          numChannels: 1,
          encoder: AudioEncoder.wav,
        ),
        path: path,
      );
    } catch (e) {
      isRecording = false;
      notifyListeners();
    }
  }

  void sendMessage(String text) async {
    addMessage(
      types.TextMessage(
        text: text,
        author: const types.User(id: "user"),
        id: "${DateTime.now().minute}-${DateTime.now().second}-${text.toString()}",
      ),
    );
    processAIResponse();
  }

  void stopRecording() async {
    isRecording = false;
    notifyListeners();
    _audioPlayerService.play(AssetManager.afterSpeakAudio);
    try {
      path = await record.stop() ?? '';
      final file = await _getAudioContent();
      final response = await speechToText.recognize(file);
      if (!response.isSuccess) {
        return;
      }
      addMessage(
        types.TextMessage(
          text: response.text,
          author: const types.User(id: "user"),
          id: "${DateTime.now().minute}-${DateTime.now().second}-${response.text.toString()}",
        ),
      );
      processAIResponse();
    } catch (e) {
      dev.log(e.toString());
      isRecording = false;
      notifyListeners();
    }
  }

  List<String> processAIResponseString(String responseText) {
    //TODO
    return [responseText];
  }

  processAIResponse() async {
    if (isAIProcessing) return;
    isAIProcessing = true;
    notifyListeners();
    try {
      final response = await gemini.chat([
        Content(parts: [
          Parts(text:
              //Include other products when we have time, connect with parent app, and update prompt
              """Act as a customer support for StepOut company. You sell nike shoes.
                   Your name is Brian.
                    We have the following products ${productsList.map((e) => "${e.name} which is ${e.price} Baht, ")} and
                    Only recommend the products we have when i asked for recommendations. 
                    we have trade-in program. 
                    If they ask for trade-in program, you can say click to below button to go to trade-in page.
                    Never Include additional information except for the informations asked""")
        ], role: 'user'),
        Content(parts: [Parts(text: 'Yes, I understand that.')], role: 'model'),
        ...messagesList.whereType<types.TextMessage>().map((e) {
          return Content(
              role: e.author.id == "user" ? 'user' : 'model',
              parts: [
                Parts(text: e.text),
              ]);
        })
      ]);
      if (response != null) {
        final messages = processAIResponseString(response.output.toString());
        String text = messages.first;

        addMessage(types.TextMessage(
          text: text,
          author: const types.User(id: "assistant"),
          id: response.index.toString(),
        ));
        if (text.contains("Nike Dunk")) {
          addMessage(types.CustomMessage(
            author: const types.User(id: "assistant"),
            id: "product-cart-${response.index}",
          ));
        }
        if (text.toLowerCase().contains("trade")) {
          addMessage(types.CustomMessage(
            author: const types.User(id: "assistant"),
            id: "trade-${response.index}",
          ));
        }
        final audioData = await networkAPI.openAITTS(text);
        if (audioData == null) throw Exception();
        isAISpeaking = true;
        notifyListeners();
        await _audioPlayerService.playStream(
          audioData,
          whenFinished: () {
            isAISpeaking = false;
            notifyListeners();
          },
        );
        isAISpeaking = false;
        isAIProcessing = false;
        notifyListeners();
      }
    } catch (e) {
      print((e as GeminiException).message.toString());
      isAIProcessing = false;
      notifyListeners();
    }
  }

  Future<List<int>> _getAudioContent() async {
    final uri = Uri.parse(path);
    final client = http.Client();
    final request = await client.get(uri);
    return request.bodyBytes;
  }
}
