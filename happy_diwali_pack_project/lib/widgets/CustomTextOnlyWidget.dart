import 'package:happy_diwali_pack/utils/SizeConfig.dart';

import 'package:flutter/material.dart';

class CustomTextOnlyWidget extends StatelessWidget {
  const CustomTextOnlyWidget({
    Key key,
    @required this.size,
    @required this.color,
    @required this.borderColor,
    @required this.text,
    this.headingText,
    this.ontap,
  }) : super(key: key);

  final Size size;
  final Color color, borderColor;
  final String text, headingText;
  final Function ontap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.all(SizeConfig.width(4)),
        height: size.height * 0.41,
        width: size.width * 0.46,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: borderColor,
          borderRadius: BorderRadius.circular(SizeConfig.height(11)),
        ),
        child: Container(
          height: size.height * 0.39,
          width: size.width * 0.43,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(SizeConfig.height(10)),
          ),
          child: Padding(
            padding: EdgeInsets.all(SizeConfig.width(2)),
            child: Column(
              children: [
                headingText != null
                    ? Text(
                        headingText,
                        style: Theme.of(context).textTheme.bodyText1,
                        textAlign: TextAlign.center,
                      )
                    : Container(),
                headingText != null ? Divider() : Container(),
                Text(
                  text,
                  style: Theme.of(context).textTheme.subtitle1,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
      onTap: ontap,
    );
  }
}
