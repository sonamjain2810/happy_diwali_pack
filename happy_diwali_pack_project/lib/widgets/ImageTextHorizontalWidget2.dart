import 'package:cached_network_image/cached_network_image.dart';
import 'package:happy_diwali_pack/utils/SizeConfig.dart';

import 'package:flutter/material.dart';

class ImageTextHorizontalWidget2 extends StatelessWidget {
  const ImageTextHorizontalWidget2({
    Key key,
    @required this.context,
    @required this.imageUrl,
    @required this.title,
    @required this.subTitle,
    @required this.isOnlineImage,
  
  }) : super(key: key);

  final BuildContext context;
  final String imageUrl,title,subTitle;
  final bool isOnlineImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(3.86 * SizeConfig.widthMultiplier),
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title,
                  maxLines: 2, 
                  style: Theme.of(context).textTheme.headline1,
                  ),
              SizedBox(
                height: 1.12 * SizeConfig.heightMultiplier,
              ),
              Text(subTitle, style: Theme.of(context).textTheme.subtitle1),
            ],
          ),
          SizedBox(
            //20
            width: 4.83 * SizeConfig.widthMultiplier,
          ),
          Container(
            alignment: Alignment.centerRight,
            width: SizeConfig.width(180),
            height: SizeConfig.height(180),
            decoration: BoxDecoration(
              
              borderRadius:
                  BorderRadius.circular(2.23 * SizeConfig.heightMultiplier),
            ),

            child: isOnlineImage ? 
            CachedNetworkImage(
                height: SizeConfig.height(180),
                width: SizeConfig.width(180),
                imageUrl: imageUrl,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fadeOutDuration: const Duration(seconds: 1),
                fadeInDuration: const Duration(seconds: 3),
              ) :
            Container(
                    height: SizeConfig.height(150),
                    width: SizeConfig.width(150),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          imageUrl,
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
          ),

          
          
          
        ],
      ),
    );
  }
}
