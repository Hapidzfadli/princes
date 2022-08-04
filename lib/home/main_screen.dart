import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:princes/function/sound_function.dart';
import 'package:princes/widgets/medium_text.dart';
import 'package:princes/widgets/navigation_drawer_widget.dart';
import 'package:princes/widgets/small_text.dart';

import '../yt_downloader/yt_download.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}
class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  late AnimationController _controller1;
  late Animation<double> _animation1;
  final padding = EdgeInsets.symmetric(horizontal: 20);
  late AnimationController _controller2;
  late Animation<double> _animation2;
  late AnimationController _controller3;
  late Animation<double> _animation3;
  late AnimationController _controller4;
  late Animation<double> _animation4;
  late AnimationController _controller5;
  late Animation<double> _animation5;

  late AnimationController _controller6;

  // late AudioPlayer audioPlayer;
  // late AudioPlayer audioPlayerLoop;

  late SoundFunction sound;
  bool isPlaying = true;

  initState() {
    super.initState();

    sound = SoundFunction();
    // audioPlayer = AudioPlayer();
    // audioPlayerLoop = AudioPlayer();
    // audioPlayerLoop.setReleaseMode(ReleaseMode.loop);

    _controller1 = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _controller6 = AnimationController(vsync: this,);

    _animation1 = CurvedAnimation(
        parent: _controller1,
        curve: Curves.easeInToLinear,
    );
    _controller1.forward();


    _controller2 = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation2 = CurvedAnimation(
      parent: _controller2,
      curve: Curves.easeInToLinear,
    );

    _controller3 = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation3 = CurvedAnimation(
      parent: _controller3,
      curve: Curves.easeInToLinear,
    );

    _controller4 = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation4 = CurvedAnimation(
      parent: _controller4,
      curve: Curves.easeInToLinear,
    );

    _controller5 = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _animation5 = CurvedAnimation(
      parent: _controller5,
      curve: Curves.fastOutSlowIn,
    );

    Timer(Duration(seconds: 2), () {
      _controller2.forward();
      Timer(Duration(seconds: 2), () {
        _controller3.forward();
        Timer(Duration(seconds: 3), () {
          _controller4.forward();
          Timer(Duration(seconds: 2), () {
            _controller5.forward();
          });
        });
      });
    });
  }

  //fungsi

  // void playSound(String url) async {
  //   await audioPlayer.play(AssetSource(url));
  // }
  // void playSoundLoop (String url) async {
  //   await audioPlayerLoop.play(AssetSource(url));
  // }
  // void stopSound() async {
  //   await audioPlayer.stop();
  //   await audioPlayerLoop.stop();
  // }
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: MediumText(text: "Hai Orang Baik", color: Colors.grey,),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                SmallText(text: "Jangan lupa bahagia yah, doaku menyertaimu", color: Colors.black87,),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Terimakasih'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  @override
  void dispose() {
    // audioPlayer.dispose();
    // audioPlayerLoop.dispose();
    sound.audioPlayer.dispose();
    sound.audioPlayerLoop.dispose();
    sound.dispose();
    sound.playSoundLoop("sound/Single-Firework-Sound.mp3");
    sound.playSound("sound/Happy-Birthday-Songs-2020.mp3");
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    _controller4.dispose();
    _controller5.dispose();
    _controller6.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final name = 'Hapid Fadli';
    final email = 'hapidzfadli@gmail.com';
    final urlImage = "assets/image/hapidz.png";
    return Scaffold(
      drawer: Drawer(
        child: Material(
          color: Color.fromRGBO(50, 75, 205, 1),
          child: ListView(
            children: [
              buildHeader(
                urlImage: urlImage,
                name: name,
                email: email,
                onClicked: () {
                  Navigator.of(context).pop();
                },
              ),
              Container(
                padding: padding,
                child: Column(
                  children: [
                    buildMenuItem(text: "Home",
                        icon: Icons.home,
                        onClicked: () => selectedItem(context, 2)
                    ),
                    buildMenuItem(text: "Youtube",
                        icon: Icons.video_label_sharp,
                        onClicked: () => selectedItem(context, 0)
                    ),
                    buildMenuItem(text: "Nonton Film",
                        icon: Icons.video_label_sharp,
                        onClicked: () => selectedItem(context, 1)
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: appBar(sound),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final Size biggest = constraints.biggest;
          return Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
              color: Colors.white70,
            ),
            child: Stack(
              children: [
                Positioned(
                  top: biggest.height / 2 - 150,
                  left: biggest.width / 2 - 150,
                  child: Column(
                    children: [
                      FadeTransition(
                        opacity: _animation1,
                        child: CircleAvatar(
                            backgroundImage: AssetImage("assets/image/ecaaa.png"),
                            radius: 150,
                            backgroundColor: Colors.transparent
                        ),
                      ),
                      SizedBox(height: 20),
                      ScaleTransition(
                        scale: _controller5,
                        child: MediumText(text: "ELZA AGUSTINA", color: Colors.grey,)
                      ),
                      // ElevatedButton(
                      //     onPressed: stopSound,
                      //     child: MediumText(text: "Stop", color: Colors.black,
                      //     ),
                      // ),

                      SizedBox(height: 20),
                      FadeTransition(
                        opacity: _animation3,
                        child: GestureDetector(
                          onTap: _showMyDialog,
                          child: Lottie.asset("assets/animations/gift.json",
                              height: 100),
                        ),
                      )
                    ],
                  )
                ),
                Positioned(
                  top: 80,
                  left: 38,
                  child: FadeTransition(
                    opacity: _animation3,
                    child: Lottie.asset("assets/animations/72239-birthday.json",
                        height: 300,
                      repeat: true,
                    ),
                  ),
                ),
                Positioned(
                  top: 150,
                  right: 0,
                  child: FadeTransition(
                    opacity: _animation2,
                    child: Lottie.asset(
                        "assets/animations/72239-birthday.json",
                        height: 300,
                      repeat: true,
                      onLoaded: (composition){
                        _controller6.duration = composition.duration;
                        _controller6.forward();
                        _controller6.addListener(() {
                          sound.playSoundLoop("sound/Single-Firework-Sound.mp3");
                        });
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: biggest.width / 2 - 200,
                  child: FadeTransition(
                    opacity: _animation2,
                    child: Lottie.asset("assets/animations/name-birthday.json",
                        height: 280,
                      repeat: true,
                      onLoaded: (composition){
                        _controller6.duration = composition.duration;
                        _controller6.forward();
                        _controller6.addListener(() {
                          sound.playSound("sound/Happy-Birthday-Songs-2020.mp3");
                        });
                      },
                    ),
                  ),
                ),
                PositionedTransition(
                  rect: RelativeRectTween(
                    begin: RelativeRect.fromSize(
                         Rect.fromLTWH(0 - 150 , biggest.height, 10, 10), biggest),
                    end: RelativeRect.fromSize(
                        Rect.fromLTWH(0, biggest.height - 170, 150, 150), biggest),
                  ).animate(
                      CurvedAnimation(
                        parent: _controller3,
                        curve: Curves.elasticInOut,
                      )),
                  child: Transform.rotate(
                    angle: 6,
                    child: Lottie.asset("assets/animations/birthday-party.json",),
                  ),
                ),
                PositionedTransition(
                  rect: RelativeRectTween(
                    begin: RelativeRect.fromSize(
                         Rect.fromLTWH(biggest.width, biggest.height, 10, 10), biggest),
                    end: RelativeRect.fromSize(
                        Rect.fromLTWH(biggest.width - 160, biggest.height - 150, 150, 150), biggest),
                  ).animate(
                      CurvedAnimation(
                        parent: _controller2,
                        curve: Curves.elasticInOut,
                      )),
                  child: Transform.rotate(
                    angle: 17,
                    child: Lottie.asset("assets/animations/birthday-party.json",),
                  ),
                ),
              ],
            ),
          );
        },
      )
    );
  }
  AppBar appBar(SoundFunction sound){
    return AppBar(
      centerTitle: true,
      title: MediumText(text: "PRINCESS", color: Colors.white,),
      actions: [
        IconButton(
            icon: isPlaying ?  Icon(Icons.volume_up) : Icon(Icons.volume_off),
            onPressed: () {
              if(sound.playerState == PlayerState.playing){
                sound.stopSound();
                setState(() {
                  isPlaying = false;
                });
                sound.playerState = PlayerState.stopped;
              } else if (sound.playerState == PlayerState.stopped){
                sound.resumeSound();
                setState(() {
                  isPlaying = true;
                });
                sound.playerState = PlayerState.playing;
              }
            }
        ),
      ],
    );
  }
  Widget buildHeader ({
    required String urlImage,
    required String name,
    required String email,
    required VoidCallback onClicked,
  }) => InkWell (
    onTap: onClicked,
    child: Container(
      padding: padding.add(EdgeInsets.symmetric(vertical: 40)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(radius: 60, backgroundImage: AssetImage(urlImage)),
          SizedBox(height: 20,),
          MediumText(text: name , color: Colors.white,),
          SmallText(text: email, color: Colors.white,)
        ],
      ),
    ),
  );

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: SmallText(text: text, color: color,),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }
  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/youtube');
        break;
      case 1:
        Navigator.pushNamed(context, '/movie');
        break;
      case 2:
        Navigator.pushNamed(context, '/home');
        break;
    }
  }
}
