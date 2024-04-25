import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';

class AudioPlayerService {
  late AudioPlayer _mPlayer;

  AudioPlayerService({
    double volume = 1,
  }) {
    initAudioPlayer(volume);
  }

  Future<void> setAudioVolume(double volume) async {
    await _mPlayer.setVolume(volume);
  }

  Future<void> initAudioPlayer(double volume) async {
    _mPlayer = AudioPlayer();
    _mPlayer.setVolume(volume);
  }

  void dispose() {
    stopPlayer();
    _mPlayer.dispose();
  }

  void stopPlayer() {
    _mPlayer.pause();
  }

  Future<void> play(
    String url, {
    bool isAssetUrl = true,
    VoidCallback? whenFinished,
  }) async {
    if (isAssetUrl) {
      await _mPlayer.play(AssetSource(url));
    } else {
      await _mPlayer.play(UrlSource(url));
    }
  }

  UrlSource urlSourceFromBytes(Uint8List bytes,
      {String mimeType = "audio/mpeg"}) {
    return UrlSource(Uri.dataFromBytes(bytes, mimeType: mimeType).toString());
  }

  Future<void> playStream(
    Uint8List data, {
    VoidCallback? whenFinished,
  }) async {
    await _mPlayer.play(urlSourceFromBytes(data));
  }

  Future<void> pausePlayer() async {
    if (_mPlayer.state == PlayerState.playing) {
      await _mPlayer.pause();
    }
  }

  Future<void> resumePlayer() async {
    if (_mPlayer.state == PlayerState.paused) {
      await _mPlayer.resume();
    }
  }
}
