import 'package:audioplayers/audioplayers.dart';

class SoundFunction {
  late AudioPlayer audioPlayer = AudioPlayer();
  late AudioPlayer audioPlayerLoop = AudioPlayer();

  late PlayerState playerState;

  SoundFunction(){
    playerState = PlayerState.stopped;
    audioPlayer = AudioPlayer();
    audioPlayer = AudioPlayer();
    audioPlayerLoop.setReleaseMode(ReleaseMode.loop);
  }
  void playSound(String url) async {
    playerState = PlayerState.playing;
    await audioPlayer.play(AssetSource(url));
  }
  void playSoundLoop (String url) async {
    playerState = PlayerState.playing;
    await audioPlayerLoop.play(AssetSource(url));
  }
  void stopSound() async {
    await audioPlayer.stop();
    await audioPlayerLoop.stop();
    playerState = PlayerState.stopped;
  }
  void resumeSound() async {
    await audioPlayer.resume();
    await audioPlayerLoop.resume();
    playerState = PlayerState.playing;
  }
  @override
  void dispose(){
    stopSound();
    resumeSound();
    audioPlayer.dispose();
    audioPlayerLoop.dispose();
  }
}