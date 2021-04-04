import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:flutter/material.dart';
import 'data/Images.dart';
import 'utils/SizeConfig.dart';
import 'ImageDetailPage.dart';

class ImagesList extends StatefulWidget {
  String type;
  ImagesList({this.type});
  @override
  _ImagesListState createState() => _ImagesListState(type);
}

class _ImagesListState extends State<ImagesList> {
  String type;
  _ImagesListState(this.type);

  static final facebookAppEvents = FacebookAppEvents();

  var data;


  

  @override
  Widget build(BuildContext context) 
  {
     if (type == '1') {
      // Dhanteras
      data = Images.dhanteras_images_path;
    } else if (type == '2') {
      // Kali Chaudas
      data = Images.kali_chaudas_images_path;
    } else if (type == '3') {
      // Diwali
      data = Images.diwali_images_path;
    } else if (type == '4') {
      // New Year
      data = Images.new_year_images_path;
    } else if (type == '5') {
      // Bhai Dooj
      data = Images.bhai_dooj_images_path;
    } 


    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Images",
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
                        print("Click on Image Grid item $index");
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) =>
                                    ImageDetailPage(index, type)));

                        facebookAppEvents.logEvent(
                          name: "Image List",
                          parameters: {
                            'clicked_on_jpeg_image_index': '$index',
                          },
                        );
                      });
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
