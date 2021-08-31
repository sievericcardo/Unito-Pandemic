import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:unito_pandemic_decentralized/lang/EnglishLocale.dart';
import 'package:unito_pandemic_decentralized/lang/ItalianLocale.dart';
import 'package:unito_pandemic_decentralized/model/settings.dart';
import 'package:unito_pandemic_decentralized/utils/ConfigManager.dart';
import 'package:unito_pandemic_decentralized/utils/resources.dart';

class LanguageActivity extends StatefulWidget {
  @override
  _LanguageActivity createState() => _LanguageActivity();
}

class _LanguageActivity extends StateMVC with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(
        _animationController); //use Tween animation here, to animate between the values of 1.0 & 2.5.
    _animation.addListener(() {
      //here, a listener that rebuilds our widget tree when animation.value chnages
      setState(() {});
    });
    _animation.addStatusListener((status) {
      //AnimationStatus gives the current status of our animation, we want to go back to its previous state after completing its animation
      if (status == AnimationStatus.completed) {
        _animationController.reverse(); //reverse the animation back here if its completed
        Navigator.pushReplacementNamed(context, '/intro');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Nearby().askLocationPermission();
    return Scaffold(
        backgroundColor: Colors.indigo,
        body: Container(
            width: double.infinity,
            child: Column(
              children: <Widget>[
                Text(
                  "Lingua / Language",
                  textAlign: TextAlign.justify,
                  textScaleFactor: 2,
                  style: TextStyle(color: Colors.white),
                ),
                Padding(padding: EdgeInsets.fromLTRB(0, 50, 0, 0)),
                InkWell(
                  child: IconButton(
                    icon: Image.asset('lib/img/italy.png'),
                    iconSize: 128,
                    onPressed: () {
                      ConfigManager();
                      ConfigManager()
                          .init(new ItalianLocale(), new Resources(), new Settings(false, false));
                      Box box = Hive.box('myself');
                      box.put("lang", "ita");
                      Box s = Hive.box("settings");
                      s.put("authenticated", false);
                      s.put("biometricAuthentication", false);

                      _animationController.forward();
                    },
                  ),
                ),
                Padding(padding: EdgeInsets.all(12)),
                IconButton(
                  icon: Image.asset('lib/img/uk.png'),
                  iconSize: 128,
                  onPressed: () {
                    ConfigManager();
                    ConfigManager()
                        .init(new EnglishLocale(), new Resources(), new Settings(false, false));
                    Box box = Hive.box('myself');
                    box.put("lang", "eng");
                    Box s = Hive.box("settings");
                    s.put("authenticated", false);
                    s.put("biometricAuthentication", false);

                    _animationController.forward();
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
            )));
  }
}
