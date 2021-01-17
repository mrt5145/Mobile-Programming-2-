import 'package:flutter/material.dart';
import 'package:hw2/models/languages.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hw2/constant.dart';

class HesFeature extends StatefulWidget {
  @override
  _HesFeatureState createState() => _HesFeatureState();
}

class _HesFeatureState extends State<HesFeature> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<String> _yourHesCode;

  void _generateHesCode() async {
    var uuid = Uuid();
    var generatedHesCode = uuid.v1();
    print(generatedHesCode);
    final SharedPreferences prefs = await _prefs;
    setState(() {
      _yourHesCode = prefs
          .setString('hes', generatedHesCode)
          .then((bool succes) => generatedHesCode);
    });
  }

  @override
  void initState() {
    super.initState();
    _yourHesCode = _prefs.then((SharedPreferences prefs) {
      return (prefs.getString('hes') ?? 'Hes Kodun Yok');
    });
  }

  @override
  Widget build(BuildContext context) {
    final language = Provider.of<Languages>(context);

    ScreenUtil.init(context,
        designSize: Size(1080, 1920), allowFontScaling: true);

    var heading = Padding(
      padding: EdgeInsets.only(bottom: kSpacingUnit.h * 2),
      child: Text(
        language.secondPageName,
        style: TextStyle(
          fontSize: ScreenUtil().setSp(kSpacingUnit.h * 3),
        ),
      ),
    );
    var buttonGenerateHes = Padding(
      padding: EdgeInsets.only(bottom: kSpacingUnit.h * 1),
      child: RaisedButton(
        child: Text(language.generateHesCode),
        onPressed: _generateHesCode,
      ),
    );
    var showHes = Padding(
      padding: EdgeInsets.only(
          bottom: kSpacingUnit.h * 2),
      child: FutureBuilder(
        future: _yourHesCode,
        builder: (ctx, snap) =>
          snap.connectionState == ConnectionState.done ? 
         Text(snap.data) : CircularProgressIndicator(),
      ),
    );

    return Center(
      child: Column(
        children: [
          heading,
          SizedBox(height: kSpacingUnit.h * 5,),
          buttonGenerateHes,
          showHes,
        ],
      ),
    );
  }
}
