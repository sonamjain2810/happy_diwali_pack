import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'data/Gifs.dart';
import 'package:dio/dio.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'NativeAdContainer.dart';
import 'data/Strings.dart';
import 'utils/SizeConfig.dart';
/*
how to pass data into another screen watch this video
https://www.youtube.com/watch?v=d5PpeNb-dOY
 */

class GifDetailPage extends StatefulWidget {
  
  int index;
  String type;
  GifDetailPage( this.index, this.type);

  @override
  _GifDetailPageState createState() => _GifDetailPageState(index,type);
}

// Height = 8.96
// Width = 4.14
class _GifDetailPageState extends State<GifDetailPage> {
  int index;
  String type;
  _GifDetailPageState( this.index, this.type);

  static final facebookAppEvents = FacebookAppEvents();

  // Native Ad Open
  static String _adUnitID = Strings.iosAdmobNativeId;

  final _nativeAdController = NativeAdmobController();
  double _height = 0;

  StreamSubscription _subscription;

  var data;

//Native Ad Close

  @override
  void initState() {
    super.initState();
    _requestPermission();
    //Native Ad
    _subscription = _nativeAdController.stateChanged.listen(_onStateChanged);
    //
  }

  @override
  void dispose() {
    //Native Ad
    _subscription.cancel();
    _nativeAdController.dispose();
    super.dispose();
  }

  void _onStateChanged(AdLoadState state) {
    switch (state) {
      case AdLoadState.loading:
        setState(() {
          _height = 0;
        });
        break;

      case AdLoadState.loadCompleted:
        setState(() {
          _height = 36.83 * SizeConfig.heightMultiplier;
        });
        break;

      default:
        break;
    }
  }

  bool visible = false;

  loadProgress() {
    if (visible == true) {
      setState(() {
        visible = false;
      });
    } else {
      setState(() {
        visible = true;
      });
    }
  }

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

    // TODO: implement build
    return PageView.builder(
      controller: PageController(
          initialPage: index, keepPage: true, viewportFraction: 1),
      itemBuilder: (context, index) {
          return Scaffold(
        appBar: AppBar(
            title: Text(
          "Gif No. ${index + 1}",
          //20 & 2
          style: Theme.of(context).appBarTheme.textTheme.headline1,
        )),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(1.93 * SizeConfig.widthMultiplier),
                child: new Card(
                  child: new Container(
                    padding:
                        new EdgeInsets.all(1.93 * SizeConfig.widthMultiplier),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        CachedNetworkImage(
                          imageUrl: data[index],
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          fadeOutDuration: const Duration(seconds: 1),
                          fadeInDuration: const Duration(seconds: 3),
                        ),
                        
                        Padding(
                          padding:
                              EdgeInsets.all(1.93 * SizeConfig.widthMultiplier),
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Visibility(
                                  maintainSize: true,
                                  maintainAnimation: true,
                                  maintainState: true,
                                  visible: visible,
                                  child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                                    children: [
                                      
                                        Text("We are downloading your image to share.. \nBe Paitence Thanks!!", style: Theme.of(context).textTheme.bodyText1,),
                                          CircularProgressIndicator(),
                                    ],
                                  )),
                              RaisedButton(
                                
                                onPressed:() async {
                                  loadProgress();
                                  await shareGIFImageFromUrl();
                                  loadProgress();
                                }, 
                                
                                child: Text('Share'),
                              ),
                            ],
                          ),
                        ),

                        Divider(),
                        NativeAdContainer(
                            height: _height,
                            adUnitID: _adUnitID,
                            nativeAdController: _nativeAdController,
                            numberAds: 1 ,

                            ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        
      
      );
      }
    );
  }

   Future<void> shareGIFImageFromUrl() async 
  {
    try {
      var request = await HttpClient().getUrl(Uri.parse(data[index]));
      var response = await request.close();
      Uint8List bytes = await consolidateHttpClientResponseBytes(response);
      await Share.file('Share GIF', 'share_gif.gif', bytes, 'image/gif');
    } catch (e) {
      print('error: $e');
    }

    facebookAppEvents.logEvent(
                        name: "GIF Share",
                        parameters: {
                          'gif_image_url': '$Gifs.gifs_path[index]',
                        },
                      );
  }

  _requestPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();

    final info = statuses[Permission.storage].toString();
    print(info);
    //_toastInfo(info);
  }

  saveGif() async {
    var appDocDir = (await getApplicationDocumentsDirectory()).path;
    String savePath = appDocDir + "/screenshot/temp${"index+1"}.gif";
    await Dio().download(data[index], savePath);
    final result = await ImageGallerySaver.saveFile(savePath);
    print(result + "Downloded Image");
    //Fluttertoast.showToast(msg: result, toastLength: Toast.LENGTH_LONG);
    _toastInfo("$result");
  }

  _toastInfo(String info) {
    //Fluttertoast.showToast(msg: info, toastLength: Toast.LENGTH_LONG);
  }
}
