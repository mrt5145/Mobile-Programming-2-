import 'package:flutter/material.dart';
import 'package:hw2/constant.dart';
import 'package:hw2/models/languages.dart';
import 'package:hw2/models/theme_changer.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(1080, 1920), allowFontScaling: true);
    final theme = Provider.of<ThemeChanger>(context, listen: false);
    final language = Provider.of<Languages>(context, listen: false);
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text(language.drawerName),
          ),
          // SizedBox(height: kSpacingUnit.h * 1),
          Padding(
            padding: EdgeInsets.all(kSpacingUnit.h * 1.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(language.drawerDarkMode),
                Switch(
                  value: theme.isDark,
                  onChanged: (val) => theme.toggleTheme(),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(kSpacingUnit.h * 1.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(language.drawerlanguage),
                DropdownButton(
                  icon: Icon(Icons.arrow_drop_down),
                  value: language.applanguage,
                  items: [
                    DropdownMenuItem<String>(
                      value: 'Turkish',
                      child: Text('Turkish'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'English',
                      child: Text('English'),
                    ),
                  ],
                  onChanged: (newValue){
                    if(newValue == "English")
                      language.makeEnglish();
                    else
                      language.makeTurkish();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
