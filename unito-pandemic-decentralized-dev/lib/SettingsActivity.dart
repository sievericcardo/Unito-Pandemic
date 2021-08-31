import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:nice_button/NiceButton.dart';
import 'package:unito_pandemic_decentralized/contactTracing.dart';
import 'package:unito_pandemic_decentralized/ui/constant.dart';
import 'package:unito_pandemic_decentralized/ui/preventcard.dart';
import 'package:unito_pandemic_decentralized/ui/slidetransition.dart';
import 'package:unito_pandemic_decentralized/utils/ConfigManager.dart';
import 'package:unito_pandemic_decentralized/model/backend/contagion.dart';
import 'package:unito_pandemic_decentralized/model/backend/disease.dart';
import 'package:http/http.dart' as http;
import 'package:unito_pandemic_decentralized/utils/database.dart';

import 'model/backend/contagion.dart';
import 'model/backend/disease.dart';

class SettingsActivity extends StatefulWidget {
  SettingsActivity({Key key}) : super(key: key);

  @override
  _SettingsActivity createState() => _SettingsActivity();
}

/// Activity to map the possible settings that the user can interact with
///
/// To ensure security and privacy, we wanted the user to choose whether or not
/// to make his/her account private, as well as choosing wether or not to use
/// the biometric sensor of the smartphone.
/// We decided not to enforce the usage of the biometric scan, as not all
/// smartphones have that option.
class _SettingsActivity extends StateMVC<SettingsActivity> with SingleTickerProviderStateMixin {
  // Default placeholder text
  String userName;
  ConfigManager cm;
  UnitoPandemicDatabase db;
  bool private;
  bool biometric;
  final TextStyle whiteText = TextStyle(color: Colors.white);
  Box user;
  Box settings;
  @override
  void initState() {
    this.dbInit();
    user = Hive.box('myself');
    settings = Hive.box("settings");
    if (user.name != null) {
      userName = user.get("name");
    } else {
      this.userName = "Antonio";
    }
    cm = ConfigManager();
    this.private = true;
    this.biometric = cm.gear.biometricAuthentication;
    super.initState();
  }

  Future<int> dbInit() async {
    db = await $FloorUnitoPandemicDatabase.databaseBuilder('unitoPandemic.db').build();
    return 1;
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
            _buildHeader(),
            Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    cm.loc.account,
                  ),
                  const SizedBox(height: 10.0),
                  Card(
                    elevation: 0.5,
                    margin: const EdgeInsets.symmetric(
                      vertical: 4.0,
                      horizontal: 0,
                    ),
                    child: Column(
                      children: <Widget>[
                        SwitchListTile(
                          activeColor: Colors.purple,
                          value: this.private,
                          title: Text(cm.loc.privateAccount),
                          onChanged: (val) {
                            this.private = !this.private;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                  Card(
                    elevation: 0.5,
                    margin: const EdgeInsets.symmetric(
                      vertical: 4.0,
                      horizontal: 0,
                    ),
                    child: Column(
                      children: <Widget>[
                        SwitchListTile(
                          activeColor: Colors.purple,
                          value: cm.gear.biometricAuthentication,
                          title: Text(cm.loc.biometricAuth),
                          onChanged: (val) {
                            this.biometric = !this.biometric;
                            cm.gear.biometricAuthentication = !cm.gear.biometricAuthentication;
                            settings.put("biometricAuthentication", val);
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50.0),
                  Text("DATABASE LOG"),
                  const SizedBox(height: 20.0),
                  FutureBuilder(
                    future: this.dbInit.call(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done ||
                          snapshot == null ||
                          !snapshot.hasData) {
                        return Text("");
                      } else
                        return FutureBuilder(
                          future: db.diseaseDao.allDiseases.call(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState != ConnectionState.done ||
                                snapshot == null ||
                                !snapshot.hasData) {
                              return Text(cm.loc.diseaseNumber);
                            } else
                              return Text(
                                cm.loc.diseaseNumber + snapshot.data.length.toString(),
                                style: TextStyle(fontSize: 16),
                              );
                          },
                        );
                    },
                  ),
                  const SizedBox(height: 20.0),
                  FutureBuilder(
                    future: this.dbInit.call(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done ||
                          snapshot == null ||
                          !snapshot.hasData) {
                        return Text("");
                      } else
                        return FutureBuilder(
                          future: db.contagionDao.allContagions.call(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState != ConnectionState.done ||
                                snapshot == null ||
                                !snapshot.hasData) {
                              return Text(cm.loc.contagionNumber);
                            } else
                              return Text(
                                cm.loc.contagionNumber + snapshot.data.length.toString(),
                                style: TextStyle(fontSize: 16),
                              );
                          },
                        );
                    },
                  ),
                  const SizedBox(height: 50.0),
                  Text(
                    cm.loc.underHood,
                  ),
                  const SizedBox(height: 50.0),
                  NiceButton(
                    radius: 40,
                    background: null,
                    padding: const EdgeInsets.all(12),
                    text: cm.loc.personalData,
                    icon: Icons.account_box,
                    gradientColors: [Color(0xff5b86e5), Color(0xff36d1dc)],
                    onPressed: () {
                      showMaterialModalBottomSheet(
                        context: context,
                        builder: (context, scrollController) => Container(
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: SingleChildScrollView(
                              child: Column(children: <Widget>[
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "Dati personali",
                                        style: kTitleTextstyle,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 15),
                                Image.asset(
                                  cm.res.gideon,
                                  width: 128,
                                  height: 128,
                                ),
                                SizedBox(height: 15),
                                InkWell(
                                  onLongPress: () => {
                                    ClipboardManager.copyToClipBoard(user.get("kp1pub").toString())
                                        .then((result) {
                                      FlutterToast.showToast(
                                          msg: "Chiave pubblica copiata negli appunti",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    })
                                  },
                                  child: PreventCard(
                                    text: user.get("kp1pub") != null
                                        ? user.get("kp1pub").toString()
                                        : "chiavepubblicadiprova",
                                    image: cm.res.pubkey,
                                    title: cm.loc.unitoPubKey,
                                  ),
                                ),
                                SizedBox(height: 15),
                                InkWell(
                                  onLongPress: () => {
                                    ClipboardManager.copyToClipBoard(
                                            user.get("password").toString())
                                        .then((result) {
                                      FlutterToast.showToast(
                                          msg: "Password copiata negli appunti",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    })
                                  },
                                  child: PreventCard(
                                    text: user.get("password") != null
                                        ? user.get("password").toString()
                                        : "passworddiesempio",
                                    image: cm.res.password,
                                    title: cm.loc.password,
                                  ),
                                ),
                              ]),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20.0),
                  NiceButton(
                    radius: 40,
                    background: null,
                    padding: const EdgeInsets.all(15),
                    text: cm.loc.updateData,
                    icon: Icons.update,
                    gradientColors: [Color(0xffff5722), Color(0xffFFC107)],
                    onPressed: () async {
                      await SettingsController.updateDatabases();
                      setState(() {});
                    },
                  ),
                  const SizedBox(height: 60.0),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }

  _onHorizontalDrag(DragEndDetails details) {
    if (details.primaryVelocity == 0) return; // user have just tapped on screen (no dragging)

    if (details.primaryVelocity.compareTo(0) == -1)
      return;
    else
      Navigator.pushReplacement(context, SlideRightRoute(page: ContactTracingActivity()));
  }

  Container _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 50.0, 0, 32.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
        color: Colors.grey,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: ListTile(
                  title: Text(
                    cm.loc.menuSettings,
                    style: whiteText.copyWith(fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                ),
              ),
              Expanded(
                  child: Image.asset(
                user.get("gender") == "M" ? cm.res.boyImage : cm.res.avatarGirl,
                width: 82,
                height: 82,
              )),
            ],
          ),
          const SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              userName,
              style: whiteText.copyWith(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 5.0),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              cm.loc.registeredUser,
              style: whiteText,
            ),
          ),
        ],
      ),
    );
  }
}

/// MVC Controller of the setting activity
///
/// We define all the possibile methods that allows us to define how to
/// use and gets the settings of the user, as well as how to save them.
class SettingsController extends ControllerMVC {
  static updateDatabases() async {
    ConfigManager cm = ConfigManager();
    Response response;
    String jwt;
    UnitoPandemicDatabase db;

    const String url = "https://xelinion.servebeer.com:8443/unito-pandemic-rest-backend-1.0";

    //cleanup phase
    //db.newsDao.clearTable();

    try {
      print("Started update task...");
      Box box = Hive.box('myself');
      db = await $FloorUnitoPandemicDatabase.databaseBuilder('unitoPandemic.db').build();
      jwt = box.get("JWT");
      db.diseaseDao.clearTable();
      db.contagionDao.clearTable();
      /* response = await http.get("http://10.0.0.27:8080/api/news/latest",
        headers: {"Accept": "application/json", "Authorization": "Bearer " + jwt});
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      for (var u in jsonData) {
        News n = News.fromJson(u);
        db.newsDao.insertNews(n);
      }
    } */

      var latestContagions;

      response = await http.get(url + "/api/contagion/latest", headers: {
        "Accept": "application/json",
        "Authorization": "Bearer " + jwt
      }).timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        latestContagions =
            (json.decode(response.body) as List).map((i) => Contagion.fromJson(i)).toList();
        for (var u in latestContagions) {
          db.contagionDao.insertContagion(u);
        }
      } else {}

      /* To be implemented in future realeases
    
    response = await http.get("http://10.0.0.27:8080/api/simulation/latest",
        headers: {"Accept": "application/json", "Authorization": "Bearer " + jwt});
    if (response.statusCode == 200) {
      var simJson = json.decode(response.body);
      Box sim = Hive.box('curSim');
      sim.clear();
      sim.put("id", simJson["id"]);
      sim.put("startDate", simJson["startDate"]);
      sim.put("endDate", simJson["endDate"]);
      sim.put("diseaseId", simJson["diseaseId"]);
      sim.close();
    } */

      List<Disease> latestDiseases;
      response = await http.get(url + "/api/diseases/all", headers: {
        "Accept": "application/json",
        "Authorization": "Bearer " + jwt
      }).timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        latestDiseases =
            (json.decode(response.body) as List).map((i) => Disease.fromJson(i)).toList();

        for (var u in latestDiseases) {
          db.diseaseDao.insertDisease(u);
        }
      }

      FlutterToast.showToast(
          msg: cm.loc.updateComplete,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } on TimeoutException catch (_) {
      // A timeout occurred.
      FlutterToast.showToast(
          msg: cm.loc.updateError,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } on SocketException catch (_) {
      FlutterToast.showToast(
          msg: cm.loc.genericError,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
