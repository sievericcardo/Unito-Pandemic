import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:unito_pandemic_decentralized/ui/form.dart' as myForm;
import 'package:unito_pandemic_decentralized/utils/ConfigManager.dart';

class TutorialActivity extends StatefulWidget {
  TutorialActivity({Key key}) : super(key: key);
  @protected
  @override
  createState() => _TutorialActivity();
}

/// Display a tutorial to the user when he/she first opens the application.
/// 
/// The user must first choose the language to be used (italian or english)
/// next, we show them a simple tutorial on what is the application, as well as 
/// its purpose.
/// At the of the tutorial we ask the user that data for the registration.
class _TutorialActivity extends StateMVC {
  //IntroScreenState() : super(Controller());
  List<Slide> slides = new List();
  ConfigManager cm;
  @override
  void initState() {
    //Spawniamo un isolate col while true
    //Isolate.spawn(isolateTrial, "");
    cm = ConfigManager();
    super.initState();
    slides.add(
      new Slide(
        title: cm.loc.presentation1title,
        maxLineTitle: 2,
        description: cm.loc.presentation1body,
        pathImage: cm.res.unitoLogo,
        backgroundColor: Color(0xfff5a623),
      ),
    );
    slides.add(
      new Slide(
        title: cm.loc.presentation2title,
        maxLineTitle: 2,
        description: cm.loc.presentation2body,
        pathImage: cm.res.covidImage,
        backgroundColor: Color(0xff203152),
      ),
    );
    slides.add(
      new Slide(
        title: cm.loc.presentation3title,
        maxLineTitle: 2,
        description: cm.loc.presentation3body,
        pathImage: cm.res.contactsImage,
        backgroundColor: Color(0xff9932CC),
      ),
    );
    slides.add(
      new Slide(
        title: cm.loc.presentation4title,
        maxLineTitle: 3,
        centerWidget: Container(
          padding: EdgeInsets.all(32.0),
          child: myForm.Form().build(context),
        ),
        backgroundColor: Colors.purple,
      ),
    );
  }

  void onDonePress() async {
    //await Controller.initialize();
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return new IntroSlider(
      slides: this.slides,
      isShowDoneBtn: true,
      onDonePress: onDonePress,
      isShowSkipBtn: false,
    );
  }
}
