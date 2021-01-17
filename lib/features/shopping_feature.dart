import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hw2/constant.dart';
import 'package:hw2/models/languages.dart';
import 'package:hw2/widgets/shopping_list.dart';
import 'package:provider/provider.dart';

class ShoppingFeature extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final language = Provider.of<Languages>(context, listen: true);
    ScreenUtil.init(context,
        designSize: Size(1080, 1920), allowFontScaling: true);
    var heading = Padding(
      padding: EdgeInsets.only(
          bottom: kSpacingUnit.h * 2, left: kSpacingUnit.w * 1.5),
      child: Text(
        language.title,
        style: TextStyle(
          fontSize: ScreenUtil().setSp(kSpacingUnit.h * 3),
        ),
      ),
    );
    var heading2 = Padding(
      padding: EdgeInsets.only(
          bottom: kSpacingUnit.h * 1, left: kSpacingUnit.w * 1.5),
      child: Text(language.subtitle),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        heading,
        heading2,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: kSpacingUnit.w * 1),
          child: ShoppingList(),
        ),
      ],
    );
  }
}
