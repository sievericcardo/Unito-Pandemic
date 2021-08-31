import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:unito_pandemic_decentralized/HealtCareActivity.dart';
import 'package:unito_pandemic_decentralized/model/backend/covidupdate.dart';
import 'package:unito_pandemic_decentralized/ui/constant.dart';
import 'package:unito_pandemic_decentralized/ui/counter.dart';
import 'package:unito_pandemic_decentralized/ui/header.dart';
import 'package:unito_pandemic_decentralized/ui/slidetransition.dart';
import 'package:unito_pandemic_decentralized/utils/ConfigManager.dart';
import 'package:fluttertoast/fluttertoast.dart';

bool ranging = false;

class DashBoardActivity extends StatefulWidget {
  @override
  _DashBoardActivity createState() => _DashBoardActivity();
}

/// Activity for the dashboard of the application containing the main data
///
/// As long as the user gets registered or logged into the application, it
/// will be displayed all the data useful to him.
/// We use the dashboard activity to map them.
class _DashBoardActivity extends StateMVC<DashBoardActivity> with SingleTickerProviderStateMixin {
  double offset = 0;
  ConfigManager cm;
  int positives = 0;
  int deaths = 0;
  int intensiva = 0;
  String latestUpdate = "";

  @override
  void initState() {
    //update data
    updateData();
    var now = new DateTime.now();
    var formatter = new DateFormat('dd-MM-yyyy');
    latestUpdate = formatter.format(now);
    cm = ConfigManager();
    authenticate(context);
    super.initState();
  }

  void updateData() async {
    if (ranging) {
      return;
    }
    Response response;
    response = await http.get(
        "https://raw.githubusercontent.com/pcm-dpc/COVID-19/master/dati-json/dpc-covid19-ita-andamento-nazionale-latest.json",
        headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      var jsonData = (response.body);
      CovidUpdate cu = CovidUpdate.fromJson(json.decode(jsonData)[0]);
      this.positives = cu.nuoviPositivi;
      this.deaths = cu.deceduti;
      this.intensiva = cu.terapiaIntensiva;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onHorizontalDragEnd: (DragEndDetails details) => _onHorizontalDrag(details),
        child: SingleChildScrollView(
          //controller: controller,
          child: Column(
            children: <Widget>[
              MyHeader(
                  title: cm.loc.menuHome,
                  color1: 0xff790e8b,
                  color2: 0xffdf78ef,
                  img1: cm.res.unitoLogo,
                  img2: cm.res.covidImage),
              Padding(
                padding: EdgeInsets.all(4),
                child: InkWell(
                  onTap: () => {
                    FlutterToast.showToast(
                        msg: cm.loc.toastMessage,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.orange,
                        textColor: Colors.white,
                        fontSize: 16.0)
                  },
                  child: Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(2),
                        ),
                        ListTile(
                          leading: CircleAvatar(
                            radius: 40,
                            backgroundImage: AssetImage(cm.res.maskImage),
                            backgroundColor: Colors.white,
                          ),
                          title: Text(cm.loc.homeScreenSituationTitle),
                          subtitle: Text(cm.loc.homeScreenSituationSubTitle),
                        ),
                        Padding(
                          padding: EdgeInsets.all(2),
                        ),
                      ],
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(24.0),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: cm.loc.homeScreenCaseUpdate,
                                style: kTitleTextstyle,
                              ),
                              TextSpan(
                                text: cm.loc.homeScreenLatestUpdate + latestUpdate,
                                style: TextStyle(
                                  color: kTextLightColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 4),
                            blurRadius: 30,
                            color: kShadowColor,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Counter(
                            color: kInfectedColor,
                            number: positives,
                            title: cm.loc.homeScreenPositive,
                          ),
                          Counter(
                            color: kDeathColor,
                            number: deaths,
                            title: cm.loc.homeScreenDeaths,
                          ),
                          Counter(
                            color: kRecovercolor,
                            number: intensiva,
                            title: cm.loc.homeScreenIntensive,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: cm.loc.homeScreenVirusSpread,
                                style: kTitleTextstyle,
                              ),
                              TextSpan(
                                text: cm.loc.homeScreenLatestUpdate + latestUpdate,
                                style: TextStyle(
                                  color: kTextLightColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      padding: EdgeInsets.all(1),
                      height: 180,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 10),
                            blurRadius: 30,
                            color: kShadowColor,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          cm.res.virusSpreadWall,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(0, 50, 0, 0))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  authenticate(BuildContext context) async {
    if (!cm.gear.biometricAuthentication) {
      print("asd");
      print(cm.gear.biometricAuthentication);
      return;
    } else {
      LocalAuthentication auth = LocalAuthentication();
      print("cu");
      print(cm.gear.authenticated);
      while (!cm.gear.authenticated) {
        cm.gear.authenticated = await auth.authenticateWithBiometrics(
            localizedReason: cm.loc.biometricAuth, useErrorDialogs: true, stickyAuth: true);
      }
    }
  }

  _onHorizontalDrag(DragEndDetails details) {
    if (details.primaryVelocity == 0) return; // user have just tapped on screen (no dragging)

    if (details.primaryVelocity.compareTo(0) == -1)
      Navigator.pushReplacement(context, SlideLeftRoute(page: HealthCareActivity()));
  }
}
