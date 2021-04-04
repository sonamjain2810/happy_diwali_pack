import 'package:cached_network_image/cached_network_image.dart';
import 'package:happy_diwali_pack/utils/SizeConfig.dart';

import 'package:flutter/material.dart';

import 'RatingWidget.dart';


class CustomGridItemBook extends StatelessWidget {
  const CustomGridItemBook({
    Key key,
    @required this.size,
    @required this.title,
    @required this.subtitle,
    @required this.lightButtonText,
    @required this.darkButtonText,
    @required this.url,
    @required this.rating,
    this.ontap,
  }) : super(key: key);

  final Size size;
  final String title, subtitle, rating, lightButtonText, darkButtonText;
  final Function ontap;
  final String url;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        //245
        height: size.height * 0.30,
        //202
        //replace color
        width: (size.width < 450) ? size.width * 0.50 : size.width * 0.30,

        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: <Widget>[
                // item blue
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: constraints.maxHeight * 0.80,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius:
                          BorderRadius.circular(SizeConfig.height(30)),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 10),
                            blurRadius: 30,
                            color: Theme.of(context).colorScheme.secondary)
                      ],
                    ),
                  ),
                ),
                CachedNetworkImage(
                  imageUrl: url,
                  height: constraints.maxHeight / 2,
                  width: constraints.maxWidth / 2,
                  fit: BoxFit.fitWidth,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fadeOutDuration: const Duration(seconds: 1),
                  fadeInDuration: const Duration(seconds: 3),
                ),
                Positioned(
                  top: constraints.maxHeight * 0.22,
                  right: constraints.maxWidth * 0.125,
                  child: Column(
                    children: <Widget>[
                      Icon(Icons.keyboard_arrow_right,
                          color: Theme.of(context).primaryIconTheme.color),
                      RatingWidget(ratingText: rating),
                    ],
                  ),
                ),

                Positioned(
                  top: constraints.maxHeight * 0.50,
                  child: Container(
                    padding: EdgeInsets.only(top: SizeConfig.height(8)),
                    height: constraints.maxHeight * 0.50,
                    width: constraints.maxWidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: SizeConfig.width(24)),
                          child: RichText(
                              text: TextSpan(
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(text: title),
                              TextSpan(
                                  text: "\n" + subtitle,
                                  style: Theme.of(context).textTheme.subtitle2)
                            ],
                          )),
                        ),
                        Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                width: constraints.maxWidth / 2,
                                padding: EdgeInsets.symmetric(
                                    vertical: SizeConfig.height(10)),
                                alignment: Alignment.center,
                                child: Text(lightButtonText,
                                    style:
                                        Theme.of(context).textTheme.subtitle1),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                width: constraints.maxWidth / 2,
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(
                                    vertical: SizeConfig.height(10)),
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryVariant,
                                  borderRadius: BorderRadius.only(
                                    topLeft:
                                        Radius.circular(SizeConfig.height(30)),
                                    bottomRight:
                                        Radius.circular(SizeConfig.height(30)),
                                  ),
                                ),
                                child: Text(
                                  darkButtonText,
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
      onTap: ontap,
    );
  }
}
