

import 'package:happy_diwali_pack/utils/SizeConfig.dart';

import 'package:flutter/material.dart';

class RatingWidget extends StatelessWidget {
  final String ratingText;
  const RatingWidget({
    Key key, this.ratingText='1.0',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: SizeConfig.height(8), horizontal: SizeConfig.width(6)
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(SizeConfig.width(16)),
      
      boxShadow: [
        BoxShadow(
          offset: Offset(3,7),
          blurRadius: 20,
          color: Colors.grey.withOpacity(0.5),
        )

      ],
      ),
      child: Column(
        children: <Widget>[
          Icon(
            Icons.star,
            color: Theme.of(context).iconTheme.color,
            size: SizeConfig.width(15),
            
          ),
          SizedBox( height: SizeConfig.height(5)),
          Text(ratingText,
          style: Theme.of(context).textTheme.subtitle2,)
        ],
      ),
    );
  }
}
