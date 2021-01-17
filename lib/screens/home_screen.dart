import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hw2/constant.dart';
import 'package:hw2/features/hes_feature.dart';
import 'package:hw2/features/shopping_feature.dart';
import 'package:hw2/models/languages.dart';
import 'package:hw2/models/transactions.dart';
import 'package:hw2/models/theme_changer.dart';
import 'package:hw2/widgets/my_drawer.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _name = '';

  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    ShoppingFeature(),
    HesFeature(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  void _bottomSheet(BuildContext context, Transactions transactions, Languages languages) {
    bool _isLoading = false;
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      context: context,
      isScrollControlled: true,
      builder: (context) => _isLoading
          ? CircularProgressIndicator()
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: kSpacingUnit.w * 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Center(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: kSpacingUnit.h * 2),
                      child: Text(
                        languages.addingNewTransaction,
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(kSpacingUnit.h * 3)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: kSpacingUnit.h * 2,
                    ),
                    child: TextField(
                      decoration: InputDecoration(hintText: languages.addingNewTransaction),
                      autofocus: true,
                      onChanged: (val) {
                        setState(() {
                          _name = val;
                        });
                      },
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom +
                            kSpacingUnit.h * 1,
                      ),
                      child: RaisedButton(
                        child: Text(languages.add),
                        onPressed: () async {
                          setState(() {
                            _isLoading = true;
                          });
                          try {
                            await transactions.addTransaction(_name, false);
                          } catch (e) {
                            print("An error occured");
                          }
                          setState(() {
                            _isLoading = false;
                          });
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }



  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context, listen: true);
    final transactions = Provider.of<Transactions>(context, listen: false);
    final languages = Provider.of<Languages>(context, listen: true);
    
    var uiOverlayStyle = SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // transparent status bar
      systemNavigationBarColor: Colors.black, // navigation bar color
      statusBarIconBrightness: Brightness.dark, // status bar icons' color
      systemNavigationBarIconBrightness:
          Brightness.dark, //navigation bar icons' color
    );
    var top = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Builder(
          builder: (ctx) => Padding(
            padding: const EdgeInsets.only(top: 8.0, right: 4.0),
            child: IconButton(
              icon: Icon(Icons.settings),
              onPressed: () => Scaffold.of(ctx).openDrawer(),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, right: 4.0),
          child: IconButton(
            icon: theme.themeData == kDarkTheme
                ? Icon(LineAwesomeIcons.sun)
                : Icon(LineAwesomeIcons.moon),
            onPressed: () => theme.toggleTheme(),
          ),
        ),
      ],
    );
    var showSelected = Padding(
      padding: const EdgeInsets.all(8.0),
      child: _widgetOptions.elementAt(_selectedIndex),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HW2',
      theme: theme.themeData,
      home: AnnotatedRegion<SystemUiOverlayStyle>(
        value: uiOverlayStyle,
        child: Scaffold(
          drawer: MyDrawer(),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  top,
                  showSelected, //shows the selected feature such as ShoppingList, ...
                ],
              ),
            ),
          ),
          floatingActionButton: _selectedIndex == 0
              ? Builder(
                  builder: (BuildContext context) => FloatingActionButton(
                    child: new Icon(Icons.add),
                    onPressed: () => _bottomSheet(context, transactions, languages),
                  ),
                )
              : null,
          bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                label: languages.firstPageName,
                icon: Icon(LineAwesomeIcons.marker),
              ),
              BottomNavigationBarItem(
                label: languages.secondPageName,
                icon: Icon(Icons.person),
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.red,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
