import 'package:flutter/material.dart';
import 'package:princes/function/sound_function.dart';
import 'package:audioplayers/audioplayers.dart';
import 'medium_text.dart';


class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Color? color;
  CustomAppBar({Key? key, this.color}) : preferredSize = Size.fromHeight(kToolbarHeight), super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar>{
  late SoundFunction sound;
  bool isPlaying = true;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sound = SoundFunction();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: widget.color,
      centerTitle: true,
      title: MediumText(text: "PRINCESS", color: Colors.white,),
    );
  }
}
