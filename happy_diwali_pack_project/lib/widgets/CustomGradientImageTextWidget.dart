

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:happy_diwali_pack/utils/SizeConfig.dart';

class CustomGradientImageTextWidget extends StatelessWidget {
  const CustomGradientImageTextWidget({
    Key key,
    @required this.size,
    @required this.isleft,
    @required this.color1,
    @required this.color2,
    @required this.imageUrl,
    @required this.title,
    @required this.bodyText,
    @required this.bottomText,
    this.ontap,
  }) : super(key: key);

  final Size size;
  final Color color1, color2;
  final String imageUrl, title, bodyText, bottomText;
  final Function ontap;
  final bool isleft;
  //"https://pngimg.com/uploads/ganesha/ganesha_PNG40.png"

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              top: SizeConfig.width(30.0),
              left: SizeConfig.width(8.0),
              right: SizeConfig.width(8.0),
              bottom: SizeConfig.width(8.0),
            ),
            child: Container(
                height: size.height * 0.32,
                width: size.width * 0.49,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    colors: [
                      color1,
                      color2,
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: isleft
                        ? Radius.circular(SizeConfig.height(40))
                        : Radius.circular(SizeConfig.height(8)),
                    topRight: isleft
                        ? Radius.circular(SizeConfig.height(8))
                        : Radius.circular(SizeConfig.height(40)),
                    bottomLeft: Radius.circular(SizeConfig.height(8)),
                    bottomRight: Radius.circular(SizeConfig.height(8)),
                  ),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 0),
                        blurRadius: 4,
                        color: Colors.grey),
                  ],
                )),
          ),
          isleft
              ? Positioned(
                  top: -1,
                  left: 0,
                  child: Padding(
                    padding: EdgeInsets.only(left: SizeConfig.width(8.0)),
                    child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        fadeOutDuration: const Duration(seconds: 1),
                        fadeInDuration: const Duration(seconds: 3),
                        height: SizeConfig.height(60),
                        width: SizeConfig.width(60),
                        fit: BoxFit.fill),
                  ),
                )
              : Positioned(
                  top: -1,
                  right: 0,
                  child: Padding(
                    padding: EdgeInsets.only(left: SizeConfig.width(8.0)),
                    child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        fadeOutDuration: const Duration(seconds: 1),
                        fadeInDuration: const Duration(seconds: 3),
                        height: SizeConfig.height(60),
                        width: SizeConfig.width(60),
                        fit: BoxFit.fill),
                  ),
                ),
          Positioned(
            top: 65,
            child: Padding(
              padding: EdgeInsets.only(
                  left: SizeConfig.width(15.0), right: SizeConfig.width(15.0)),
              child: Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                maxLines: 2,
              ),
            ),
          ),
          Positioned(
            top: 100,
            child: Padding(
              padding: EdgeInsets.only(left: SizeConfig.width(15.0)),
              child: Text(
                bodyText,
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Positioned(
            bottom: 15,
            child: Padding(
              padding: EdgeInsets.only(left: SizeConfig.width(15.0)),
              child: Text(
                bottomText,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      onTap: ontap,
    );
  }
}