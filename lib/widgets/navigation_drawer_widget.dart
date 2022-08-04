import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:princes/widgets/medium_text.dart';
import 'package:princes/widgets/small_text.dart';
import 'package:princes/yt_downloader/yt_download.dart';
import 'package:audioplayers/audioplayers.dart';

class NavigationDrawer extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);

  @override
  Widget build(BuildContext context) {
    final name = 'Hapid Fadli';
    final email = 'hapidzfadli@gmail.com';
    final urlImage = "assets/image/hapidz.png";
    return Drawer(
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
                Navigator.pushNamed(context, '/home');
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
