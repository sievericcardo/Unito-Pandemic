import 'package:flip_card/flip_card.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import 'package:flutter/material.dart';
import 'package:unito_pandemic_decentralized/DashBoardActivity.dart';
import 'package:unito_pandemic_decentralized/contactTracing.dart';
import 'package:unito_pandemic_decentralized/ui/constant.dart';
import 'package:unito_pandemic_decentralized/ui/header.dart';
import 'package:unito_pandemic_decentralized/ui/preventcard.dart';
import 'package:unito_pandemic_decentralized/ui/slidetransition.dart';
import 'package:unito_pandemic_decentralized/utils/ConfigManager.dart';

class HealthCareActivity extends StatefulWidget {
  @override
  _HealthCareActivity createState() => _HealthCareActivity();
}

/// Heal care activity that contains all the data useful to the user
/// 
/// To make it easier to the user to possibly track its contagion, as well
/// as possible counter measures we encapsulate all useful data inside this
/// activity.
/// We divide this activity into two main sections:
/// 
/// 1. Possible syntomps that helps user to eventually get a visit
/// 2. Countermeasures defined by OMS to ensure maximum safety against it
class _HealthCareActivity extends StateMVC<HealthCareActivity> {
  ConfigManager cm;

  @override
  void initState() {
    this.cm = ConfigManager();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
      onHorizontalDragEnd: (DragEndDetails details) => _onHorizontalDrag(details),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MyHeader(
                title: cm.loc.menuHealthCare,
                color1: 0xff388e3c,
                color2: 0xff6abf69,
                img1: cm.res.unitoLogo,
                img2: cm.res.caduceusImage),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                Text(
                  cm.loc.healthCareScreenStatus,
                  style: kTitleTextstyle,
                ),
                SizedBox(height: 20),
                FlipCard(
                  direction: FlipDirection.VERTICAL, // default
                  front: Container(
                    child: PreventCard(
                      text: cm.loc.healthCareScreenFlipSubtitle,
                      image: cm.res.shield,
                      title: cm.loc.healthCareScreenFlipTitleFront,
                    ),
                  ),
                  back: PreventCard(
                    text: cm.loc.healthCareScreenFlipSubtitleR,
                    image: cm.res.benedict,
                    title: cm.loc.healthCareScreenFlipTitleRear,
                  ),
                ),
              ]),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    cm.loc.healthCareScreenCommonSynthoms,
                    style: kTitleTextstyle,
                  ),
                  SizedBox(height: 20),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: SymptomCard(
                            image: cm.res.headacheImage,
                            title: cm.loc.healthCareScreenHeadAche,
                            isActive: false,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: SymptomCard(
                            image: cm.res.coughImage,
                            title: cm.loc.healthCareScreenCough,
                            isActive: false,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: SymptomCard(
                            image: cm.res.feverImage,
                            title: cm.loc.healthCareScreenFever,
                            isActive: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(cm.loc.healthCareScreenPrevention, style: kTitleTextstyle),
                  SizedBox(height: 20),
                  PreventCard(
                    text: cm.loc.washHandsSub,
                    image: "lib/img/washing-hands.png",
                    title: cm.loc.washHands,
                  ),
                  PreventCard(
                    text: cm.loc.socialDistancesSub,
                    image: "lib/img/social-distancing.png",
                    title: cm.loc.socialDistances,
                  ),
                  SizedBox(height: 50),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }

  _onHorizontalDrag(DragEndDetails details) {
    if (details.primaryVelocity == 0) return; // user have just tapped on screen (no dragging)

    if (details.primaryVelocity.compareTo(0) == -1)
      Navigator.pushReplacement(context, SlideLeftRoute(page: ContactTracingActivity()));
    else
      Navigator.pushReplacement(context, SlideRightRoute(page: DashBoardActivity()));
  }
}

/// Class that displays the symptom data as a card
/// 
/// To make it more responsive and modern, the card implemented can be changed
/// by simply tapping on that. As such we needed to implement the code for the
/// card as is, and the card to be
class SymptomCard extends StatelessWidget {
  final String image;
  final String title;
  final bool isActive;
  const SymptomCard({
    Key key,
    this.image,
    this.title,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          isActive
              ? BoxShadow(
                  offset: Offset(0, 10),
                  blurRadius: 20,
                  color: kActiveShadowColor,
                )
              : BoxShadow(
                  offset: Offset(0, 3),
                  blurRadius: 6,
                  color: kShadowColor,
                ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Image.asset(image, height: 90),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
