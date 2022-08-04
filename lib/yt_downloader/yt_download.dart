import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:princes/widgets/medium_text.dart';
import 'package:princes/widgets/small_text.dart';
import 'package:princes/yt_downloader/post_result.dart';
import '../widgets/appbar.dart';
import '../widgets/navigation_drawer_widget.dart';

class YTDownload extends StatefulWidget {
  const YTDownload({Key? key}) : super(key: key);

  @override
  State<YTDownload> createState() => _YTDownloadState();
}

class _YTDownloadState extends State<YTDownload> {
  late PostResult postResult;
  String url = "";
  String title = "";
  String thumb = "";
  String filesize_audio = "";
  String filesize_video = "";
  String audio = "";
  String audio_asli = "";
  String video = "";
  String video_asli = "";
  String progress = "";
  bool isLoading = false;
  String directory = "";

  final textController = TextEditingController();
  final padding = EdgeInsets.all(8.0);
  ReceivePort _port = ReceivePort();
  var dio = Dio();
  
  Future<void> downloadVideo(String url, String name, String format) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    getDownloadPath().then((value){
      setState(() {
        isLoading = true;
        directory = value!;
      });
    });

    // final baseStorage = await getExternalStorageDirectory();
    await dio.download(url, directory + "/" + name + format, onReceiveProgress: (rec, total) {
      setState(() {
        isLoading = false;
        progress = "Downloading.. " + ((rec / total) * 100).toStringAsFixed(0) + "%";
      });
    });
    setState(() {
      if(progress.contains('100')){
        progress = "Download Successful";
      }
    });
  }
  Future<String?> getDownloadPath() async {
    Directory? directory;
    try {
      if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = Directory('/storage/emulated/0/Download');
        // Put file in global download folder, if for an unknown reason it didn't exist, we fallback
        // ignore: avoid_slow_async_io
        if (!await directory.exists()) directory = await getExternalStorageDirectory();
      }
    } catch (err, stack) {
      print("Cannot get download folder path");
    }
    return directory!.path;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // PostResult();
    // postResult;
    textController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawer(),
      appBar: CustomAppBar(),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: padding,
              child: Column(
                children: [
                  Image.network(
                    thumb != "" ? thumb : "https://i.ibb.co/qYTFsDx/placeholder.png",
                    height: 150,
                    width: 150,),
                  SmallText(text: title,),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          downloadVideo(audio, title, ".mp3");
                        },
                        child: Row(
                          children: [
                            MediumText(text: "MP3", size: 16,),
                            SizedBox(width: 10,),
                            SmallText(text: filesize_audio, size: 12,)
                          ],
                        ),
                      ),
                      SizedBox(width: 20,),
                      ElevatedButton(
                        onPressed: (){
                          downloadVideo(video, title, ".mp4");
                        },
                        child: Row(
                          children: [
                            MediumText(text: "MP4", size: 16,),
                            SizedBox(width: 10,),
                            SmallText(text: filesize_video, size: 12,)
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),

            Padding(padding: EdgeInsets.all(8.0),
              child:  TextField(
                controller: textController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(8.0),
                  hintText: "Paste link youtubenya disini cantik",
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () async {
                      setState(() {
                        url = textController.text;
                        isLoading = true;
                      });
                      await PostResult.connectToApi(url).then((value) {
                        postResult = value;
                        setState(() {
                          title = postResult.title!;
                          thumb = postResult.thumb!;
                          filesize_audio = postResult.filesize_audio!;
                          filesize_video = postResult.filesize_video!;
                          audio = postResult.audio!;
                          audio_asli = postResult.audio_asli!;
                          video = postResult.video!;
                          video_asli = postResult.video_asli!;
                          isLoading = false;
                        });
                      });
                    },
                  ),
                ),
                onSubmitted: (url) => PostResult.connectToApi(url).then((value) {
                  postResult = value;
                  setState(() {
                    title = postResult.title!;
                    thumb = postResult.thumb!;
                    filesize_audio = postResult.filesize_audio!;
                    filesize_video = postResult.filesize_video!;
                    audio = postResult.audio!;
                    audio_asli = postResult.audio_asli!;
                    video = postResult.video!;
                    video_asli = postResult.video_asli!;
                  });
                }),
                textInputAction: TextInputAction.search,
              ),
            ),
            SizedBox(height: 20,),
            isLoading ? Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: CircularProgressIndicator(),
              ),
            ) : MediumText(text: progress)
          ],
        ),
      ),
    );
  }
}
