import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:convert/convert.dart';
import 'package:cryptography/cryptography.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:hive/hive.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:unito_pandemic_decentralized/utils/ConfigManager.dart';

class Form extends StateMVC {
  @override
  Form() {
    this.cm = ConfigManager();
  }

  //final Widget title;
  final genderController = TextEditingController();
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  ConfigManager cm;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProgressDialog pr = ProgressDialog(context);
    pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: true);
    pr.style(
        message: cm.loc.loadingRegScreenMessage,
        borderRadius: 12.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progressTextStyle:
            TextStyle(color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle:
            TextStyle(color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));
    return Column(
      children: <Widget>[
        TextFormField(
          keyboardType: TextInputType.text,
          autofocus: false,
          decoration: InputDecoration(
              hintText: cm.loc.formName,
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
          validator: null,
          controller: nameController,
        ),
        SizedBox(height: 20.0),
        TextFormField(
          autofocus: false,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintText: cm.loc.formGender,
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          ),
          controller: genderController,
        ),
        SizedBox(
          height: 25.0,
          width: 100.0,
        ),
        TextFormField(
          keyboardType: TextInputType.number,
          autofocus: false,
          decoration: InputDecoration(
            hintText: cm.loc.formAge,
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
          ),
          validator: null,
          controller: ageController,
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            padding: EdgeInsets.all(12),
            color: Colors.lightBlueAccent,
            onPressed: () async {
              await pr.show();
              String name = nameController.text;
              String age = ageController.text;
              String gender = genderController.text;
              await FormController.registration(name, age, gender);
              await pr.hide();
              Navigator.pushReplacementNamed(context, '/home');
            },
            child: Text(cm.loc.signUp, style: TextStyle(color: Colors.white)),
          ),
        ),
      ],
    );
  }
}

class FormController extends ControllerMVC {
  static Future<void> registration(name, age, gender) async {
    const String url = "https://xelinion.servebeer.com:8443/unito-pandemic-rest-backend-1.0";
    // Kp1: keypair for user registration
    final keyPair1 = await ed25519.newKeyPair();
    // Kp2: keypair for simple nearby advertisement
    final keyPair2 = await ed25519.newKeyPair();
    // Kp3: keypair for simulation mode advertisement
    final keyPair3 = await ed25519.newKeyPair();

    List<String> randomStrings = new List();
    Box box = Hive.box('randomStrings');

    //Generate our 16 random string list
    HashSink sink = blake2b.newSink();
    sink.add(keyPair2.publicKey.bytes);
    sink.close();
    Hash hash = sink.hash;
    randomStrings.add(hex.encode(hash.bytes).substring(0, 64));
    randomStrings.add(hex.encode(hash.bytes).substring(64));
    String currentHash = (hex.encode(hash.bytes));
    for (int i = 0; i < 7; i++) {
      sink = blake2b.newSink();
      sink.add(currentHash.codeUnits);
      sink.close();
      hash = sink.hash;
      String fullLengthHash = hex.encode(hash.bytes);
      String s1 = fullLengthHash.substring(0, 64);
      String s2 = fullLengthHash.substring(64);
      randomStrings.add(s1);
      randomStrings.add(s2);
      currentHash = (hex.encode(hash.bytes));
    }

    int j = 1;
    for (String s in randomStrings) {
      box.put("s" + j.toString(), s);
      j++;
    }

    List<int> randomBytes = keyPair2.publicKey.bytes;
    //add some sort of salt
    String timestamp = (new DateTime.now().millisecondsSinceEpoch / 1000).round().toString();
    randomBytes += Uint8List.fromList(timestamp.codeUnits);
    //Generate a new password
    sink = sha384.newSink();
    sink.add(randomBytes);
    sink.close();
    List<int> hashed = sink.hash.bytes;
    String pwd = hex.encode(hashed);
    Response response;

    String pk1 = hex.encode(keyPair1.publicKey.bytes);
    response = await http.post(url + "/api/register_app",
        body: json
            .encode({"name": name, "pubKey": pk1, "gender": gender, "age": age, "password": pwd}),
        headers: {"Accept": "application/json", "Content-Type": "application/json"});
    if (response.statusCode == 201) {
      Box box = Hive.box('myself');
      print(jsonDecode(response.body));
      //dobbiamo fare authenticate
      response = await http.post(url + "/api/app/signin",
          body: json.encode({"pubKey": pk1, "password": pwd}),
          headers: {"Accept": "application/json", "Content-Type": "application/json"});
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        print(json);
        box.put("kp1pub", hex.encode(keyPair1.publicKey.bytes));
        box.put("kp1pr", keyPair1.privateKey.toString());
        box.put("kp2pub", hex.encode(keyPair2.publicKey.bytes));
        box.put("kp2pr", keyPair2.privateKey.toString());
        box.put("kp3pub", hex.encode(keyPair3.publicKey.bytes));
        box.put("kp3pr", keyPair3.privateKey.toString());
        box.put("name", name);
        box.put("age", age);
        box.put("password", pwd);
        box.put("gender", gender);
        box.put("JWT", json["token"]);

        //box.close();
      }
    }

    print(response.toString());
  }
}
