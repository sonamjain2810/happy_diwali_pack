import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:happy_diwali_pack/HomePage.dart';
import 'package:happy_diwali_pack/widgets/MessageWidget4.dart';
import 'NativeAdContainer.dart';
import 'data/Strings.dart';
import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'utils/SizeConfig.dart';
import 'AboutUs.dart';
import 'MyDrawer.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';


// Height = 8.96
// Width = 4.14

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

// const String testDevice = 'testDeviceId';

class _DashboardState extends State<Dashboard> {
  static final facebookAppEvents = FacebookAppEvents();
  String interstitialTag = "";

  // Native Ad Open
  static String _adUnitID = Platform.isAndroid
      ? Strings.androidAdmobNativeId
      : Strings.iosAdmobNativeId;

  final _nativeAdController = NativeAdmobController();
  double _height = 0;

  StreamSubscription _subscription;

  String _authStatus = 'Unknown';


//Native Ad Close
  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices:
        Strings.testDevice != null ? <String>[Strings.testDevice] : null,
    //keywords: Keywords.adsKeywords,
    //contentUrl: 'http://foo.com/bar.html',
    childDirected: false,
    nonPersonalizedAds: true,
  );

  InterstitialAd _interstitialAd;

  bool _isInterstitialAdReady = false;

  InterstitialAd createInterstitialAd() {
    return InterstitialAd(
      adUnitId: Platform.isAndroid
          ? Strings.androidAdmobInterstitialId
          : Strings.iosAdmobInterstitialId,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("InterstitialAdId " + _interstitialAd.adUnitId);
        print("InterstitialAd event $event");
        if (event == MobileAdEvent.closed) {
          _isInterstitialAdReady = false;

          _interstitialAd = createInterstitialAd()..load();

          if (interstitialTag != null) {
            switch (interstitialTag) {
              case "about":
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => AboutUs()));
                break;

              case "Dhanteras":
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => HomePage(type: "1")));
                break;

              case "Kalichaudas":
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => HomePage(type: "2")));
                break;

              case "Diwali":
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => HomePage(type: "3")));
                break;

              case "Newyear":
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => HomePage(type: "4")));
                break;

              case "Bhaidooj":
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => HomePage(type: "5")));
                break;

              default:
            }
          }
        } else if (event == MobileAdEvent.opened ||
            event == MobileAdEvent.failedToLoad) {
          _isInterstitialAdReady = false;

          if (interstitialTag != null) {
            switch (interstitialTag) {
              case "about":
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => AboutUs()));
                break;

              case "Dhanteras":
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => HomePage(type: "1")));
                break;

              case "Kalichaudas":
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => HomePage(type: "2")));
                break;

              case "Diwali":
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => HomePage(type: "3")));
                break;

              case "Newyear":
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => HomePage(type: "4")));
                break;

              case "Bhaidooj":
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => HomePage(type: "5")));
                break;

              default:
            }
          }
        } else if (event == MobileAdEvent.loaded) {
          _isInterstitialAdReady = true;
        } else {
          print("InterstitialAdId " + _interstitialAd.adUnitId);
          print(event.toString());
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    FirebaseAdMob.instance.initialize(
        appId: Platform.isAndroid
            ? Strings.androidAdmobAppId
            : Strings.iosAdmobAppId);

    initPlugin();

    _interstitialAd?.dispose();
    _interstitialAd = createInterstitialAd()..load();

    //Native Ad
    _subscription = _nativeAdController.stateChanged.listen(_onStateChanged);
    _nativeAdController.setTestDeviceIds([Strings.testDevice]);

    //
  }

  @override
  void dispose() {
    _interstitialAd?.dispose();
    //Native Ad
    _subscription.cancel();
    _nativeAdController.dispose();
    super.dispose();
  }

   // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlugin() async {
    TrackingStatus status;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      status = await AppTrackingTransparency.requestTrackingAuthorization();
    } on PlatformException {
      _authStatus = 'Failed to open tracking auth dialog.';
    }

    final uuid = await AppTrackingTransparency.getAdvertisingIdentifier();
    print("UUID: $uuid");

    if (!mounted) {
      return;
    }

    setState(() {
      _authStatus = "$status";
    });
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

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Dashboard",
          style: Theme.of(context).appBarTheme.textTheme.headline1,
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(SizeConfig.width(8)),
                    child: Center(
                      child: Text("Festival List",
                          style: Theme.of(context).textTheme.headline1),
                    ),
                  ),

                  Divider(),
                  // Dhanteras

                  InkWell(
                    child: MessageWidget4(
                        headLine: "Dhanteras Wishes",
                        subTitle: "Click Here for Images, Messages, Gifs",
                        imagePath: "assets/1.png",
                        color: Colors.teal[900]),
                    onTap: () {
                      print("Dhanteras Clicked");
                      interstitialTag = "Dhanteras";
                      facebookAppEvents.logEvent(
                        name: "Dhanteras",
                        parameters: {
                          'button_id': 'Dhanteras_button',
                        },
                      );
                      _isInterstitialAdReady == true
                          ? _interstitialAd?.show()
                          : Navigator.of(context).push(new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  HomePage(type: "1")));
                    },
                  ),
                  // Dhanteras
                  Divider(),

                  // Kali Chaudas
                  InkWell(
                    child: MessageWidget4(
                        headLine: "Chhoti Diwali / Kali Chaudas Wishes",
                        subTitle: "Click Here for Images, Messages, Gifs",
                        imagePath: "assets/2.png",
                        color: Colors.deepOrange),
                    onTap: () {
                      print("Kalichaudas Clicked");
                      interstitialTag = "Kalichaudas";
                      facebookAppEvents.logEvent(
                        name: "Kalichaudas",
                        parameters: {
                          'button_id': 'Kalichaudas_button',
                        },
                      );
                      _isInterstitialAdReady == true
                          ? _interstitialAd?.show()
                          : Navigator.of(context).push(new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  HomePage(type: "2")));
                    },
                  ),

                  Divider(),
                  // Diwali
                  InkWell(
                    child: MessageWidget4(
                        headLine: "Diwali Wishes",
                        subTitle: "Click Here for Images, Messages, Gifs",
                        imagePath: "assets/3.png",
                        color: Colors.indigoAccent),
                    onTap: () {
                      print("Diwali Clicked");
                      interstitialTag = "Diwali";
                      facebookAppEvents.logEvent(
                        name: "Diwali",
                        parameters: {
                          'button_id': 'Diwali_button',
                        },
                      );
                      _isInterstitialAdReady == true
                          ? _interstitialAd?.show()
                          : Navigator.of(context).push(new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  HomePage(type: "3")));
                    },
                  ),
                  Divider(),
                  NativeAdContainer(
                    height: _height,
                    adUnitID: _adUnitID,
                    nativeAdController: _nativeAdController,
                    numberAds: 1,
                  ),
                  Divider(),
                  // New Year
                  InkWell(
                    child: MessageWidget4(
                        headLine: "New Year Wishes",
                        subTitle: "Click Here for Images, Messages, Gifs",
                        imagePath: "assets/4.png",
                        color: Colors.teal[600]),
                    onTap: () {
                      print("New Year Clicked");
                      interstitialTag = "Newyear";
                      facebookAppEvents.logEvent(
                        name: "Newyear",
                        parameters: {
                          'button_id': 'Newyear_button',
                        },
                      );
                      _isInterstitialAdReady == true
                          ? _interstitialAd?.show()
                          : Navigator.of(context).push(new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  HomePage(type: "4")));
                    },
                  ),

                  Divider(),

                  InkWell(
                    child: MessageWidget4(
                        headLine: "Bhai Dooj Wishes",
                        subTitle: "Click Here for Images, Messages, Gifs",
                        imagePath: "assets/5.png",
                        color: Colors.pinkAccent),
                    onTap: () {
                      print("Bhai Dooj Clicked");
                      interstitialTag = "Bhaidooj";
                      facebookAppEvents.logEvent(
                        name: "Bhaidooj",
                        parameters: {
                          'button_id': 'Bhaidooj_button',
                        },
                      );
                      _isInterstitialAdReady == true
                          ? _interstitialAd?.show()
                          : Navigator.of(context).push(new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  HomePage(type: "4")));
                    },
                  ),

                  Divider(),
                  NativeAdContainer(
                    height: _height,
                    adUnitID: _adUnitID,
                    nativeAdController: _nativeAdController,
                    numberAds: 1,
                  ),
                  Divider(),
                ],
              ),
            ),
          ],
        ),
      ),
      drawer: MyDrawer(),
    );
  }
}
