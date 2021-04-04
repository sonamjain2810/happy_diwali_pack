import 'package:flutter/material.dart';
import 'package:happy_diwali_pack/utils/SizeConfig.dart';

class MessageWidget4 extends StatelessWidget {
  const MessageWidget4({
    Key key,
    @required this.headLine,
    @required this.subTitle,
    @required this.imagePath,
    @required this.color,
  }) : super(key: key);

  final String headLine;
  final String subTitle;
  final String imagePath;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: SizeConfig.width(10.0)),
      child: Column(
        children: [
          Container(
            width: SizeConfig.width(300),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(SizeConfig.width(5))),
              boxShadow: [
                BoxShadow(
                  offset: Offset(4, 4),
                  blurRadius: 3,
                  color: Colors.grey.withOpacity(0.50),
                )
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(SizeConfig.width(10.0)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Item2
                  Container(
                    height: SizeConfig.height(270),
                    width: SizeConfig.width(270),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          imagePath,
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  
                  // Item1 with two Text
                  Container(
                    width: SizeConfig.width(200),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                                            Text(
                          subTitle,
                          style: Theme.of(context).textTheme.subtitle2,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                
                  
                
                ],

              ),
            ),
          ),
       
       
          Padding(
            padding: EdgeInsets.only(top: SizeConfig.height(4)),
            child: Text(
                        headLine,
                        style: Theme.of(context).textTheme.headline6,
                        textAlign: TextAlign.center,
                      ),
          ),

       
        ],
      ),
    );
  }
}
