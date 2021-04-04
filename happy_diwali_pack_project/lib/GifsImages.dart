import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:flutter/material.dart';
import 'data/Gifs.dart';
import 'utils/SizeConfig.dart';
import 'GifDetailPage.dart';

class GifsImages extends StatefulWidget {
  String type;
  GifsImages({this.type});
  @override
  _GifsImagesState createState() => _GifsImagesState(type);
}

class _GifsImagesState extends State<GifsImages> {
  String type;
  _GifsImagesState(this.type);

  static final facebookAppEvents = FacebookAppEvents();

  var data;

  @override
  Widget build(BuildContext context) {

     if (type == '1') {
      // Dhanteras
      data = Gifs.dhanteras_gifs_path;
      
    } else if (type == '2') {
      // Kali Chaudas
      data = Gifs.kali_chaudas_gifs_path;
      
    } else if (type == '3') {
      // Diwali
      data = Gifs.diwali_gifs_path;
      
    } else if (type == '4') {
      // New Year
      data = Gifs.new_year_gifs_path;
      
    } else if (type == '5') {
      // Bhai Dooj
      data = Gifs.bhai_dooj_gifs_path;
     
    } 

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Gif Images",
          style: Theme.of(context).appBarTheme.textTheme.headline1,
        ),
      ),
      body: SafeArea(
        child: data != null
            ? GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: Padding(
                      //8.0
                      padding:
                          EdgeInsets.all(1.93 * SizeConfig.widthMultiplier),

                      child: ListTile(
                        title: CachedNetworkImage(
                          imageUrl: data[index],
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          fadeOutDuration: const Duration(seconds: 1),
                          fadeInDuration: const Duration(seconds: 3),
                        ),
                      ),
                    ),
                    onTap: () {
                      print("Click on Gif Grid item $index");
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) =>
                                  GifDetailPage(index,type)));

                      facebookAppEvents.logEvent(
                        name: "GIF List",
                        parameters: {
                          'clicked_on_gif_image_index': '$index',
                        },
                      );
                    },
                  );
                },
                itemCount: data.length,
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
