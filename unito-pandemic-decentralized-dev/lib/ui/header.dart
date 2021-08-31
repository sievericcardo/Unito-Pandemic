import 'package:flutter/material.dart';

class MyHeader extends StatefulWidget {
  final String title;
  final int color1;
  final int color2;
  final String img1;
  final String img2;

  const MyHeader({Key key, this.title, this.color1, this.color2, this.img1, this.img2})
      : super(key: key);

  @override
  _MyHeaderState createState() => _MyHeaderState();
}

class _MyHeaderState extends State<MyHeader> {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyClipper(),
      child: Container(
        padding: EdgeInsets.only(left: 1, top: 50, right: 10),
        height: 340,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(widget.color1),
              Color(widget.color2),
            ],
          ),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  Text(
                    widget.title,
                    style: TextStyle(color: Colors.white, fontSize: 22.0),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 20, 20, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                            child: Image.asset(
                          widget.img1,
                          width: 150,
                          height: 150,
                        )),
                        Padding(padding: EdgeInsets.all(10)),
                        Expanded(
                            child: Image.asset(
                          widget.img2,
                          width: 150,
                          height: 150,
                        )),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: Stack(
                      children: <Widget>[
                        Container(), // I dont know why it can't work without container
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
