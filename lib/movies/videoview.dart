import 'dart:io';
import 'package:flutter/material.dart';
import 'package:princes/widgets/medium_text.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;

class VideoView extends StatefulWidget {
  late String url;
  late List? listUrl;
  VideoView({Key? key, required this.url, this.listUrl}) : super(key: key);

  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  late String url = widget.url;
  late List listUrl;
  late WebViewController _webViewController;

  Future<String> getUrlFembed(String url) async {
    http.Request req = http.Request("Get", Uri.parse(url))..followRedirects = false;
    http.Client baseClient = http.Client();
    http.StreamedResponse response = await baseClient.send(req);
    Uri redirectUri = Uri.parse(response.headers['location'].toString());
    return redirectUri.toString();
  }
  @override
  void initState() {
    // TODO: implement initState
     listUrl = widget.listUrl!;
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    getUrlFembed(url).then((value){
      var cekhost = Uri.parse(url);
      if(cekhost.host == 'www.fembed.com'){
        _webViewController.loadUrl(value);
      }
    });
    return SafeArea(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.7,
            child: WebView(
              onWebViewCreated: (WebViewController c) {
                _webViewController = c;
              },
              initialUrl: url,
              javascriptMode: JavascriptMode.unrestricted,
              navigationDelegate: (NavigationRequest request) {
                return NavigationDecision.prevent;
              },
            ),
          ),
          SizedBox(
            height: 70,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: listUrl.length,
                itemBuilder: (BuildContext context, index) {
                  return Container(
                    margin: EdgeInsets.only(top: 16, bottom: 16, left: 8),
                    child: ElevatedButton(
                      onPressed: (){
                        _webViewController.loadUrl(listUrl[index]);
                      },
                      child: MediumText(text: "Server " + (index+1).toString(),)
                      ,),
                  );
                }
            ),
          )
        ],
      ),
    );
  }
}
