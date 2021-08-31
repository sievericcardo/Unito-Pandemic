import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'package:convert/convert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:nearby_connections/nearby_connections.dart';
import 'package:unito_pandemic_decentralized/HealtCareActivity.dart';
import 'package:unito_pandemic_decentralized/SettingsActivity.dart';
import 'package:unito_pandemic_decentralized/model/heard.dart';
import 'package:unito_pandemic_decentralized/model/said.dart';
import 'package:unito_pandemic_decentralized/model/simbeacon.dart';
import 'package:unito_pandemic_decentralized/ui/constant.dart';
import 'package:unito_pandemic_decentralized/ui/header.dart';
import 'package:unito_pandemic_decentralized/ui/slidetransition.dart';
import 'package:unito_pandemic_decentralized/utils/ConfigManager.dart';
import 'package:unito_pandemic_decentralized/utils/database.dart';

import 'model/backend/contagion.dart';

class ContactTracingActivity extends StatefulWidget {
  ContactTracingActivity({Key key}) : super(key: key);

  @override
  _ContactTracingActivity createState() => _ContactTracingActivity();
}

bool emulator = true;
int ill = 0;

/// MVC activity object for the conact tracing platform
///
/// We implement the contact tracing activity in accord to the MVC pattern
/// the model is itself the data that will be passed (and saved locally),
/// whereas we define the following class for the activity that will work
/// as the main view of the contact tracing block
class _ContactTracingActivity extends StateMVC<ContactTracingActivity> {
  ConfigManager cm;
  UnitoPandemicDatabase db;
  String title;
  String subtitle;
  String cardImg;

  _ContactTracingActivity();

  void callback() {
    setState(() {});
  }

  @override
  void initState() {
    Box user = Hive.box('myself');
    bool x = user.get("adv");
    ContactTracingController.init();
    this.dbInit().then((value) {
      ContactTracingController.checkContagion().then((value) {
        if (ill == 1) {
          this.cardImg = cm.res.infected;
          this.title = cm.loc.contagionStatusPositive;
          this.subtitle = cm.loc.contagionsubtitle2;
        } else {
          this.cardImg = cm.res.ok;
          this.title = cm.loc.contagionStatusNegative;
          this.subtitle = cm.loc.contagionsubtitle1;
        }
        setState(() {});
      });
    });
    cm = ConfigManager();
    this.title = cm.loc.contagionStatusNegative;
    this.subtitle = cm.loc.contagionsubtitle1;
    this.cardImg = cm.res.ok;

    if (!emulator) {
      if (x == null || !x) {
        ContactTracingController.startAdvertising(callback);
        user.put("adv", true);
        FlutterToast.showToast(
            msg: cm.loc.servicesStart,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
    super.initState();

    //ContactTracingController.startDiscovering();
  }

  /// Initializer function for the database
  ///
  /// We set this function as an asyncrhonous function that build the database
  /// without having to wait for something, or syncrhonizing to something
  /// We call the `datbaseBuilder` function invoking the respective file
  Future<UnitoPandemicDatabase> dbInit() async {
    db = await $FloorUnitoPandemicDatabase.databaseBuilder('unitoPandemic.db').build();

    return db;
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
                title: cm.loc.menuContacts,
                color1: 0xff1e88e5,
                color2: 0xff6ab7ff,
                img1: cm.res.unitoLogo,
                img2: cm.res.contactTracingImage),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: cm.loc.homeScreenSituationTitle,
                    style: kTitleTextstyle,
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            InkWell(
              onTap: () {
                setState(() {});
              },
              child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8),
                    ),
                    ListTile(
                      leading: Image.asset(cardImg),
                      title: Text(title),
                      subtitle: Text(subtitle),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
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
            SizedBox(height: 30),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: cm.loc.contactScreenLatestBeacons,
                    style: kTitleTextstyle,
                  ),
                ],
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.all(18),
                  child: Container(
                    child: FutureBuilder(
                        future: this.dbInit.call(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState != ConnectionState.done ||
                              snapshot == null ||
                              !snapshot.hasData) {
                            return SizedBox(height: 10);
                          } else
                            return StreamBuilder(
                              stream: db.heardDao.findAllHeards(),
                              initialData: [],
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: snapshot.data.length,
                                      itemBuilder: (BuildContext ctxt, int index) {
                                        if (snapshot.data[index] is Heard) {
                                          return Card(
                                            color: Colors.white,
                                            child: ListTile(
                                                leading: Image.asset(cm.res.generalBeaconImage),
                                                title:
                                                    Text(snapshot.data[index].getSimplifiedContact),
                                                subtitle: Text(getTimestampAsDate(
                                                    snapshot.data[index].getTimestamp))),
                                          );
                                        } else {
                                          return Card(
                                            color: Colors.white,
                                            child: ListTile(
                                                leading: Image.asset(cm.res.virusImage),
                                                title:
                                                    Text(snapshot.data[index].getSimplifiedContact),
                                                subtitle: Text(getTimestampAsDate(
                                                    snapshot.data[index].getTimestamp))),
                                          );
                                        }
                                      });
                                } else {
                                  return new CircularProgressIndicator();
                                }
                              },
                            );
                        }),
                  ),
                )),
              ],
            ),
            SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 30),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: cm.loc.newPositives,
                          style: kTitleTextstyle,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.all(0),
                    height: 224,
                    width: double.infinity,
                    child: Container(
                        child: Container(
                      child: FutureBuilder(
                          future: this.dbInit.call(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState != ConnectionState.done ||
                                snapshot == null ||
                                !snapshot.hasData) {
                              return Container(
                                child: Text("Nessun contenuto"),
                              );
                            } else
                              return StreamBuilder(
                                stream: db.contagionDao.findAllContagions(),
                                initialData: [],
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: snapshot.data.length,
                                        itemBuilder: (BuildContext ctxt, int index) {
                                          return Card(
                                            color: Colors.white,
                                            child: ListTile(
                                                leading: Image.asset(cm.res.infected),
                                                title: Text(snapshot.data[index].infected),
                                                subtitle: Text(getTimestampAsDate(
                                                    snapshot.data[index].getTimestamp))),
                                          );
                                        });
                                  } else {
                                    return Container(
                                      child: Text("Nessun contenuto"),
                                    );
                                  }
                                },
                              );
                          }),
                    )),
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(0, 90, 0, 0)),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }

  String getTimestampAsDate(timestamp) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    String x = DateFormat('dd-MM-yyy hh:mm').format(date);
    return x;
  }

  _onHorizontalDrag(DragEndDetails details) {
    if (details.primaryVelocity == 0) return; // user have just tapped on screen (no dragging)

    if (details.primaryVelocity.compareTo(0) == -1)
      Navigator.pushReplacement(context, SlideLeftRoute(page: SettingsActivity()));
    else
      Navigator.pushReplacement(context, SlideRightRoute(page: HealthCareActivity()));
  }
}

Function callback;

/// MVC Controller for the contact tracing platform
///
/// We control the data that gets passed and received via low energy bluetooth
/// with the following class. Moreover we define a method to generate a random
/// value between two bounds and by making use of the shuffle method to make
/// it more randomic.
class ContactTracingController extends ControllerMVC {
  static UnitoPandemicDatabase db;

  static random(min, max) {
    var rn = new Random();
    return min + rn.nextInt(max - min);
  }

  /// Initializer function for the database
  ///
  /// We set this function as an asyncrhonous function that build the database
  /// without having to wait for something, or syncrhonizing to something
  /// We call the `datbaseBuilder` function invoking the respective file
  static void init() async {
    db = await $FloorUnitoPandemicDatabase.databaseBuilder('unitoPandemic.db').build();
  }

  static Future<String> get getRandomString async {
    Box box = Hive.box('randomStrings');

    return box.get("s" + random(0, 7).toString());
  }

  static Future<String> get getSimulationPKey async {
    var box = await Hive.openBox('myself');
    return hex.encode(box.get(0).keyPair3.publicKey.bytes);
  }

  static Future<String> get getJWT async {
    var box = await Hive.openBox('myself');
    return box.get(0).getJWT();
  }

  /// Function that send data via bluetooth using the contact tracing protocol
  ///
  /// We define the operation that sends data as advertising. We set it to be
  /// asyncrhonous, as we must not syncrhonize with anyhting, rather we start
  /// sending the data via blueetoth, waiting for someone to get data and
  /// respond
  static startAdvertising(Function c) async {
    callback = c;
    bool a = await Nearby().startAdvertising(
      "io11",
      Strategy.P2P_CLUSTER,
      onConnectionInitiated: (String id, ConnectionInfo info) {
        // Called whenever a discoverer requests connection

        print("ho accettato la connessione");
        print(info.isIncomingConnection);
        print(info.endpointName);
        print(info.authenticationToken);
        acceptConnection(id);
      },
      onConnectionResult: (String id, Status status) {
        // Called when connection is accepted/rejected
        print("problema");
        print(status.toString());
        if (status == Status.CONNECTED) {
          print("connesso");
          //acceptConnection(id);
        }
      },
      onDisconnected: (String id) {
        // Called whenever a discoverer disconnects from advertiser
        print("problema disconnessione");
      },
      serviceId: "unito", // uniquely identifies your app
    );

    print("ADVERTISING: " + a.toString());
  }

  /// Function that gets data via bluetooth using the contact tracing protocol
  ///
  /// We define the operation that gets data as discovering. We set it to be
  /// asyncrhonous, as we must not syncrhonize with anyhting, rather we start
  /// getting the data via blueetoth when we see an advertisement.
  static startDiscovering() async {
    bool a = await Nearby().startDiscovery(
      "tu2",
      Strategy.P2P_CLUSTER,
      onEndpointFound: (String endpointId, String userName, String serviceId) {
        // called when an advertiser is found
        print("Found new endpoint with id $endpointId");
        print(userName);
        print(serviceId);
        requestConnection(endpointId);
      },
      onEndpointLost: (String id) {
        //called when an advertiser is lost (only if we weren't connected to it )
      },
      serviceId: "unito", // uniquely identifies your app
    );

    print("DISCOVERING: " + a.toString());
  }

  /// Function that request connections with beacons
  ///
  /// We set an `endpointId` to map the identifier of the connection we want
  /// to establish
  static requestConnection(String endpointId) {
    Nearby().requestConnection(
      "tu",
      endpointId,
      onConnectionInitiated: (connectedId, info) {
        print("sono qui");
        acceptConnection(connectedId);
        print("non è vero");
      },
      onConnectionResult: (id, status) async {
        print("status update with $status");
        if (status == Status.CONNECTED) {
          Uint8List bytes;
          bool cond = false;
          if (cond) {
            String simType = "sim";
            bytes += Uint8List.fromList(simType.codeUnits);
            String myString = ContactTracingController.getSimulationPKey as String;
            bytes += Uint8List.fromList(myString.codeUnits);
            String timestamp = (new DateTime.now().millisecondsSinceEpoch / 1000).toString();
            bytes += Uint8List.fromList(timestamp.codeUnits);
            Box sim = Hive.box('curSim');
            SimBeacon s = new SimBeacon(myString, int.parse(timestamp), sim.get(0).getId());
            db.simBeaconDao.insertSimSaid(s);
          } else {
            String simType = "reg";
            Uint8List b1 = Uint8List.fromList(simType.codeUnits);
            String result1 = await ContactTracingController.getRandomString;
            result1 = "pqpelkohoehkeuwcnrkyusmvcdvqnwcgjjbrpasdjkldfgjklsdklòfgkjfdkfkf";
            Uint8List b2 = Uint8List.fromList(result1.codeUnits);
            String timestamp =
                (new DateTime.now().millisecondsSinceEpoch / 1000).round().toString();
            Uint8List b3 = Uint8List.fromList(timestamp.codeUnits);

            //bytes = new Uint8List(b1.length + b2.length + b3.length);
            bytes = Uint8List.fromList(b1 + b2 + b3);

            Said s = new Said(result1, int.parse(timestamp));
            db.saidDao.insertSaid(s);
          }

          await Nearby().sendBytesPayload(id, bytes);
          //Nearby().sendBytesPayload(id, utf8.encode("ciaone"));
          print("mandato payload");
          Nearby().disconnectFromEndpoint(endpointId);
        } else {
          print(status.toString());
        }
        print("mandato nulla");
      },
      onDisconnected: (id) {},
    );
  }

  /// Accept a connection given a specific id
  ///
  /// It works like the `requestConnection` as it uses an identifier for the
  /// mapping. This time we do not try to engage a conneciton, rather we accept
  /// an incoming one.
  static acceptConnection(String id) {
    print("accepted");
    Nearby().acceptConnection(id, onPayLoadRecieved: (endpointId, payload) async {
      // called whenever a payload is recieved.
      print("ricevuto un payload da $endpointId");
      var cm = ConfigManager();
      FlutterToast.showToast(
          msg: cm.loc.newContact,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0);
      print("received payload of " + payload.bytes.length.toString() + " bytes");
      Uint8List list = payload.bytes;
      print(list);
      print(new String.fromCharCodes(payload.bytes));
      String type = String.fromCharCodes(list.sublist(0, 3));
      print("type is $type");
      if (type == "reg") {
        //sappiamo che l'hash è di 64 caratteri
        String contact = String.fromCharCodes(list.sublist(3, 67));
        print("contact is $contact");
        //sappiamo che il timestamp è di 10 caratteri
        int timestamp = int.parse(String.fromCharCodes(list.sublist(67)));
        //query al db per aggiungere h
        Heard h = new Heard(contact, timestamp);
        db.heardDao.insertHeard(h);
      } else {
        //facciamo
        String pubKey = String.fromCharCodes(list.sublist(3, 68));
        int timestamp = int.parse(String.fromCharCodes(list.sublist(68, 79)));
        //recupero l'id della simulazione corrente
        Box sim = Hive.box('curSim');
        //query al db per aggiungere s
        SimBeacon s = new SimBeacon(pubKey, timestamp, sim.get(0).getId());
        db.simBeaconDao.insertSimHeard(s);
        //facciamo finta di aver finito
      }
      callback();
      Box user = Hive.box('myself');
      user.put("adv", false);
      Nearby().disconnectFromEndpoint(endpointId);
    }, onPayloadTransferUpdate: (endpointId, payloadTransferUpdate) {
      print("qualcosa si muove da $endpointId");
      print(payloadTransferUpdate.status.toString());
      // gives status of a payload
      // e.g success/failure/in_progress
      // bytes transferred and total bytes etc
    });
  }

  static Future<void> checkContagion() async {
    //query a tutto il db, sui miei contagi
    Box m = Hive.box('myself');
    String mykey = m.get("kp1pub");
    List<String> h = new List<String>();
    Box box = Hive.box('randomStrings');
    for (int i = 1; i < 9; i++) {
      h.add(box.get("s" + i.toString()));
    }
    await db.contagionDao.allContagions().then((value) {
      for (Contagion x in value) {
        if (x.getInfected.contains(mykey)) {
          ill = 1;
          return;
        }
      }

      /* for (Heard x in value) {
        for (String s in h) {
          if (x.getContact == s) {
            ill = 1;
          }
        }
      } */
      ill = 0;
      return;
    });
  }
}
