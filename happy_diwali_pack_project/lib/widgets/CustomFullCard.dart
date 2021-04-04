// Ganesh Chaturathi Rakhi Game
import 'package:happy_diwali_pack/utils/SizeConfig.dart';

import 'package:flutter/material.dart';



class CustomFullCard extends StatelessWidget {
  const CustomFullCard({
    Key key,
    @required this.size,
    @required this.assetsImagePath,
    this.ontap,
  }) : super(key: key);

  final Size size;
  final String assetsImagePath;
  final Function ontap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(
            left: 3.86 * SizeConfig.widthMultiplier,
            top: 3.86 * SizeConfig.widthMultiplier / 2,
            bottom: 3.86 * SizeConfig.widthMultiplier / 2,
            right: 3.86 * SizeConfig.widthMultiplier),
        width: size.width,
        height: 30 * SizeConfig.heightMultiplier,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(assetsImagePath),
            )),
      ),
      onTap: ontap,
    );
  }
}