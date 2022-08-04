import 'dart:convert';
import 'package:http/http.dart' as http;

class PostResult {
   late String? title;
   late String? thumb;
   late String? filesize_audio;
   late String? filesize_video;
   late String? audio;
   late String? audio_asli;
   late String? video;
   late String? video_asli;

  PostResult({this.title, this.thumb, this.filesize_audio, this.filesize_video,
    this.audio, this.audio_asli, this.video, this.video_asli});

  factory PostResult.createPostResult(Map<String, dynamic> object){
    return PostResult(
      title: object['title'],
      thumb: object['thumb'],
      filesize_audio: object['filesize_audio'],
      filesize_video: object['filesize_video'],
      audio: object['audio'],
      audio_asli: object['audio_asli'],
      video: object['video'],
      video_asli: object['video_asli'],
    );
  }
  static Future<PostResult> connectToApi(String url) async{
    String apiUrl = 'https://api.akuari.my.id/downloader/youtube?link=' + url;
    final response = await http.get(Uri.parse(apiUrl));
    if(response.statusCode == 200) {
      return PostResult.createPostResult(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load url');
    }
  }
}