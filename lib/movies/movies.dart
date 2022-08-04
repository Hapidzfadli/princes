import 'dart:ui';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:princes/movies/constant_movie.dart';
import 'package:princes/movies/movies_result.dart';
import 'package:princes/movies/videoview.dart';
import 'package:princes/widgets/medium_text.dart';
import 'package:princes/widgets/small_text.dart';
import '../widgets/appbar.dart';
import '../widgets/navigation_drawer_widget.dart';

class Movies extends StatefulWidget {
  const Movies({Key? key}) : super(key: key);

  @override
  State<Movies> createState() => _MoviesState();
}

class _MoviesState extends State<Movies> {
  late MovieResult movieResult = MovieResult();
  final String urlPage = 'http://128.199.45.92/wp-json/wl/v1/posts?page=';
  final String urlSearch = 'http://128.199.45.92/wp-json/wl/v1/posts?search=';
  final String urlId = 'http://128.199.45.92/wp-json/wl/v1/posts?id=';
  late String queryUrl = urlPage;
  late String valueUrl = "1";
  late String panjang = "";
  late String id = "";
  late List data = [];
  var title = [];
  late String iframe = "";
  final textController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    movieResult.getData(queryUrl, valueUrl).then((value) {
      data = value;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final screenHeight = MediaQuery.of(context).size.height;
    // final screenWidth = MediaQuery.of(context).size.height;
    return FutureBuilder(
        future: movieResult.getData(queryUrl, valueUrl.toString()).then((value) {
          data = value;
        }),
        builder: (context , snapshot) {
          var returnBody;
          if (snapshot.connectionState == ConnectionState.done) {
            if(queryUrl != urlId) {
              returnBody = Scaffold(
                backgroundColor: ColorsMovie.backgroundColor,
                drawer: NavigationDrawer(),
                appBar: CustomAppBar(color: ColorsMovie.backgroundColor,),
                body: LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints constraints) {
                      final padding = EdgeInsets.all(16.0);
                      return Stack(
                        children: [
                          Positioned(
                              top: constraints.maxHeight  * 0.1,
                              left:  -88,
                              child: Container(
                                height: 166,
                                width: 166,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ColorsMovie.blurColorGrey.withOpacity(0.5),
                                ),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaX: 166,
                                    sigmaY: 166,
                                  ),
                                  child: Container(
                                    height: 166,
                                    width: 166,
                                    color: Colors.transparent,
                                  ),
                                ),
                              )
                          ),
                          Positioned(
                              top: constraints.maxHeight  * 0.4,
                              right:  -88,
                              child: Container(
                                height: 166,
                                width: 166,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ColorsMovie.blurColorPink.withOpacity(0.5),
                                ),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaX: 166,
                                    sigmaY: 166,
                                  ),
                                  child: Container(
                                    height: 166,
                                    width: 166,
                                    color: Colors.transparent,
                                  ),
                                ),
                              )
                          ),
                          Positioned(
                              bottom: -88,
                              left:  -88,
                              child: Container(
                                height: 166,
                                width: 166,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ColorsMovie.blurColorBlue.withOpacity(0.5),
                                ),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaX: 166,
                                    sigmaY: 166,
                                  ),
                                  child: Container(
                                    height: 166,
                                    width: 166,
                                    color: Colors.transparent,
                                  ),
                                ),
                              )
                          ),
                          SafeArea(
                              bottom: false,
                              child: ListView(
                                children: [
                                  SizedBox(height: 24,),
                                  Center(child: MediumText(text: "Banyak Film Yang Bisa\nDi Tonton Disini", color:  Colors.white, textAlign: TextAlign.center),),
                                  SizedBox(height: 24,),
                                  Center(
                                    child: Container(
                                      width: constraints.maxWidth * 0.9,
                                      height: 36,
                                      child: TextField(
                                        style: TextStyle(color: Colors.white),
                                        controller: textController,
                                        decoration: InputDecoration(
                                          fillColor: ColorsMovie.blurColorPink.withOpacity(0.1), filled: true,
                                          hintText: "Search",
                                          hintStyle: TextStyle(color: Colors.white),
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              setState(()  {
                                                queryUrl = urlSearch;
                                                valueUrl = textController.text;
                                              });
                                            },
                                            icon: Icon(Icons.search, color: Colors.white,),
                                          ),
                                        ),
                                        onSubmitted: (text){
                                          setState(()  {
                                            queryUrl = urlSearch;
                                            valueUrl = text;
                                          });
                                        },
                                        textInputAction: TextInputAction.search,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 24,),
                                  Padding(
                                    padding: padding,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SmallText(text: "MOVIES", color: Colors.white, size: 18,),
                                        SizedBox(height: 24,),
                                        SizedBox(
                                          height: 200,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: data.length,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                  onTap: (){
                                                    setState(() {
                                                      queryUrl = urlId;
                                                      valueUrl = data[index]['id'];
                                                    });
                                                  },
                                                  child: Container(
                                                    margin: EdgeInsets.only(left: 8.0),
                                                    height: 180,
                                                    width: 140,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(20),
                                                      color: Colors.black38.withOpacity(0.5),
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Container(
                                                          height: 150,
                                                          decoration: BoxDecoration(
                                                            image: DecorationImage(
                                                              image: NetworkImage(data[index]['IDMUVICORE'][0]['IDMUVICORE_Poster']),
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                        SmallText(
                                                          text: data[index]['post_title'],
                                                          color: Colors.white,
                                                          size: 12,
                                                          overFlow: TextOverflow.ellipsis,
                                                          textAlign: TextAlign.center,
                                                        ),
                                                        SizedBox(height: 2,),
                                                      ],
                                                    ),
                                                  )
                                              );
                                            },
                                            shrinkWrap: true,

                                          ),
                                        ),
                                        SizedBox(height: 24,),
                                        SmallText(text: "POPULAR MOVIES", color: Colors.white, size: 18,),
                                        SizedBox(height: 24,),
                                      ],
                                    ),
                                  )
                                ],
                              )
                          )
                        ],
                      );
                    }
                ),
              );
            } else {
              List linknonton = [];
              iframe = data[0]['IDMUVICORE'][0]['IDMUVICORE_Player1'] != null ? data[0]['IDMUVICORE'][0]['IDMUVICORE_Player1'] : "";
              var iframe2 = data[0]['IDMUVICORE'][0]['IDMUVICORE_Player2'] != null ? data[0]['IDMUVICORE'][0]['IDMUVICORE_Player2'] : "";
              var iframe3 = data[0]['IDMUVICORE'][0]['IDMUVICORE_Player3'] != null ? data[0]['IDMUVICORE'][0]['IDMUVICORE_Player3'] : "";
              String? linkiframe;
              if(iframe != "") {
                var iframehtml = parse(iframe);
                linkiframe = iframehtml.getElementsByTagName('iframe')[0].attributes['src'].toString();
                linknonton.add(linkiframe);
              }
              if(iframe2 != "") {
                var iframehtml = parse(iframe2);
                var linkiframe2 = iframehtml.getElementsByTagName('iframe')[0].attributes['src'].toString();
                linknonton.add(linkiframe2);
              }
              if(iframe3 != "") {
                var iframehtml = parse(iframe3);
                var linkiframe3 = iframehtml.getElementsByTagName('iframe')[0].attributes['src'].toString();
                linknonton.add(linkiframe3);
              }


              returnBody = Scaffold(
                  backgroundColor: ColorsMovie.backgroundColor,
                  drawer: NavigationDrawer(),
                  appBar: CustomAppBar(color: ColorsMovie.backgroundColor,),
                  body: LayoutBuilder(
                      builder: (BuildContext context, BoxConstraints constraints) {
                        final padding = EdgeInsets.all(16.0);
                        return Stack(
                          children: [
                            Positioned(
                                top: constraints.maxHeight  * 0.1,
                                left:  -88,
                                child: Container(
                                  height: 166,
                                  width: 166,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: ColorsMovie.blurColorGrey.withOpacity(0.5),
                                  ),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                      sigmaX: 166,
                                      sigmaY: 166,
                                    ),
                                    child: Container(
                                      height: 166,
                                      width: 166,
                                      color: Colors.transparent,
                                    ),
                                  ),
                                )
                            ),
                            Positioned(
                                top: constraints.maxHeight  * 0.4,
                                right:  -88,
                                child: Container(
                                  height: 166,
                                  width: 166,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: ColorsMovie.blurColorPink.withOpacity(0.5),
                                  ),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                      sigmaX: 166,
                                      sigmaY: 166,
                                    ),
                                    child: Container(
                                      height: 166,
                                      width: 166,
                                      color: Colors.transparent,
                                    ),
                                  ),
                                )
                            ),
                            Positioned(
                                bottom: -88,
                                left:  -88,
                                child: Container(
                                  height: 166,
                                  width: 166,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: ColorsMovie.blurColorBlue.withOpacity(0.5),
                                  ),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                      sigmaX: 166,
                                      sigmaY: 166,
                                    ),
                                    child: Container(
                                      height: 166,
                                      width: 166,
                                      color: Colors.transparent,
                                    ),
                                  ),
                                )
                            ),
                            SafeArea(
                              child: Column(
                                children: [
                                  IconButton(
                                    onPressed: (){
                                      setState(() {
                                        queryUrl = urlPage;
                                        valueUrl = '1';
                                      });
                                    },
                                    icon: Icon(Icons.arrow_back, color: Colors.white,),
                                  ),
                                  linkiframe != null ? VideoView(url: linkiframe, listUrl: linknonton,) : MediumText(text: "Maff belum bisa nonton", color: Colors.white,),
                                ],
                              ),
                            ),

                          ],
                        );
                      }
                  )
              );
            }
            return returnBody;
          } else {
            return Scaffold(
              backgroundColor: ColorsMovie.backgroundColor,
              drawer: NavigationDrawer(),
              appBar: CustomAppBar(color: ColorsMovie.backgroundColor,),
              body: Center(
                child: CircularProgressIndicator(),
              )
            );
          }
        }
    );
  }
}
